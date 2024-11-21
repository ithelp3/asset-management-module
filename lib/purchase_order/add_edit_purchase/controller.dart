import 'package:asset_management_module/component_widget/dialog_item_select.dart';
import 'package:asset_management_module/component_widget/loading.dart';
import 'package:asset_management_module/model/brand.dart';
import 'package:asset_management_module/model/category.dart';
import 'package:asset_management_module/model/submission.dart';
import 'package:asset_management_module/model/submission_suppliers.dart';
import 'package:asset_management_module/model/supplier.dart';
import 'package:asset_management_module/purchase_order/dialog_po_add_item/controller.dart';
import 'package:asset_management_module/purchase_order/dialog_po_add_item/view.dart';
import 'package:asset_management_module/purchase_order/set_discount_tax_modal_bottom_sheet/view.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddEditPurchaseController extends GetxController with GetTickerProviderStateMixin{
  late TabController tabController;
  Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;
  Rx<TextEditingController> fieldSubject = TextEditingController().obs;
  Rx<TextEditingController> fieldSupplier = TextEditingController().obs;
  Rx<TextEditingController> fieldPoDate = TextEditingController().obs;
  Rx<TextEditingController> fieldNotes = TextEditingController().obs;
  List<PoItem> items = <PoItem>[].obs;
  RxDouble subTotal = 0.0.obs;
  RxInt tax = 0.obs;
  RxInt discount = 0.obs;
  DateTime? selectedDate;
  RxString type = ''.obs;
  RxList<Brand> brands = <Brand>[].obs;
  RxList<Category> subCategories = <Category>[].obs;
  RxList<Supplier> suppliers = <Supplier>[].obs;
  Rx<Supplier> selectedSupplier = Supplier().obs;
  RxBool progress = false.obs;
  RxBool showSetTaxDisc = false.obs;

  Rx<Submission> submission = Submission().obs;
  Rx<SubmissionSuppliers> supplierData = SubmissionSuppliers().obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    progress.value = true;
    type.value = Get.arguments?['type'] ?? '';
    submission.value = Get.arguments?['data'] ?? Submission();
    await Future.wait({
      DioClient().get('/category/sub-categories').then((res) => subCategories.value = List.from(res['data'].map((json) => Category.fromJson(json)))),
      DioClient().get('/brand/list').then((res) => brands.value = List.from(res['data'].map((json) => Brand.fromJson(json)))),
      DioClient().get('/supplier/list').then((res) => suppliers.value = List.from(res['data'].map((json) => Supplier.fromJson(json)))),
      if(type.value == 'submission') DioClient().get('/submission/suppliers/${submission.value.id}').then((res) => supplierData.value = SubmissionSuppliers.fromJson(res['data'])),
    });
    if(type.value == 'submission') {
      selectedSupplier.value = suppliers.firstWhere((supplier) => supplier.id.toString() == supplierData.value.suppliers!.firstWhere((item) => item.isChecked == 1).supplierId);
      fieldSubject.value.value = TextEditingValue(text: submission.value.subject!);
      fieldPoDate.value.value = TextEditingValue(text: DateFormat('yyyy-MM-dd').format(DateFormat('dd-MM-yyyy').parse(submission.value.dateUsed!)));
      fieldNotes.value.value = TextEditingValue(text: supplierData.value.notes ?? '');
      fieldSupplier.value.value = TextEditingValue(text: selectedSupplier.value.name!);
    }
    progress.value = false;
  }

  void selectDate(context) async {
    DateTime initDate = DateTime.now();
    if(type.value == 'submission') initDate = DateTime.parse(DateFormat('yyyy-MM-dd').format(DateFormat('dd-MM-yyyy').parse(submission.value.dateUsed!)));
    final date = await showDatePicker(
        context: context,
        firstDate: DateTime(2005),
        initialDate: initDate,
        lastDate: DateTime(2100)
    );

    if(date == null) return;
    String selectDate = DateFormat('yyyy-MM-dd').format(date);
    fieldPoDate.value.value = TextEditingValue(text: selectDate);
    selectedDate = date;
  }

  void selectSupplier(context) async {
    dynamic result = await showDialog(
        context: context,
        builder: (context) => dialogItemSelect(context,
            label: 'select_item_label'.trParams({'value': 'supplier'.tr}),
            items: suppliers.map((i) => Item(
                label: i.name,
                value: i
            )).toList()
        )
    );
    if(result == null) return;

    Supplier selected = result['value'];
    selectedSupplier.value = selected;
    fieldSupplier.value.value = TextEditingValue(text: selected.name!);
  }

  void addItem(context) async {
    final result = await Get.dialog(const DialogPoAddItemPage(),
        arguments: {
          'brands': brands,
          'subCategories': subCategories
        }
    );
    if(result == null) return;

    PoItem item = result;
    subTotal.value += item.qty! * item.cost!;
    items.add(item);
  }

  void showModal(context, ctr) async {
    showSetTaxDisc.value = true;
    final result = await Get.bottomSheet(const SetDiscountTaxModalBottomSheetPage(),
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : const Color(0xFF272d34),
        isScrollControlled: true,
        settings: RouteSettings(
            name: 'purchase-order/set-discount-and-tax',
            arguments: {
              'subTotal': subTotal.value,
              'discount': discount.value,
              'tax': tax.value
            }
        )
    );

    showSetTaxDisc.value = false;
    if(result == null) return;

    discount.value = result['discount'];
    tax.value = result['tax'];
  }

  void save(context) async {
    if(items.isNotEmpty) {
      Map<String, dynamic> payload = {
        'subject': fieldSubject.value.value.text,
        'status': 1,
        'find_supplier_id': submission.value.findSupplierId,
        'date': fieldPoDate.value.value.text,
        'notes': fieldNotes.value.value.text,
        'sub_total': subTotal.value,
        'supplier_id': selectedSupplier.value.id,
        'discount': discount.value,
        'tax': tax.value,
        'items': items.map((i) => {
          "name": i.name,
          "description": i.desc,
          "brandid": i.brand!.id,
          "subcategory_id": i.subCategory!.id,
          "qty": i.qty,
          "cost": i.cost,
        }).toList(),
      };

      LoadingFullscreen.startLoading();
      final response = await DioClient().post('/purchase-order/create',
        data: payload,
      );

      LoadingFullscreen.stopLoading();
      if(response['success'] ?? false) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.lightBlue,
              content: Text('successful_'.trParams({'value': 'created_purchase_order'.tr})),
              behavior: SnackBarBehavior.floating,
            )
        );
        Get.back(result: true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text('Oppss..!!'),
              behavior: SnackBarBehavior.floating,
            )
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.blue,
            content: Text('please_fill_in_the_items_to_purchase'.tr),
            behavior: SnackBarBehavior.floating,
          )
      );
    }
  }
}
