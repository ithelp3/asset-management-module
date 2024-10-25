import 'package:asset_management_module/component_widget/loading.dart';
import 'package:asset_management_module/model/purchase_order_submission.dart';
import 'package:asset_management_module/model/supplier.dart';
import 'package:asset_management_module/submission/set_suppliers/dialog_supplier_add/controller.dart';
import 'package:asset_management_module/submission/set_suppliers/dialog_supplier_add/view.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;

class SetSuppliersController extends GetxController {
  Rx<TextEditingController> fieldNotes = TextEditingController().obs;
  Rx<PurchaseOrderSubmission> submission = PurchaseOrderSubmission().obs;
  RxList<SupplierSelected> selectedSuppliers = <SupplierSelected>[].obs;
  RxList<Supplier> suppliers = <Supplier>[].obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    submission.value = Get.arguments['data'];
    await DioClient().get('/supplier/list').then((res)
      => suppliers.value = List.from(res['data'].map((json) => Supplier.fromJson(json))));
  }

  void addSupplier() async {
    final result = await Get.dialog(const DialogSupplierAddPage(),
      arguments: {
        'suppliers': suppliers
      }
    );
    if(result == null) return;

    SupplierSelected supplier = result;
    selectedSuppliers.add(supplier);
  }

  void editSupplier(SupplierSelected item, int idx) async {
    final result = await Get.dialog(const DialogSupplierAddPage(),
        arguments: {
          'suppliers': suppliers,
          'selected': item
        }
    );
    if(result == null) return;

    SupplierSelected supplier = result;
    selectedSuppliers.removeAt(idx);
    selectedSuppliers.add(supplier);
  }

  void save(context) async {
    if(selectedSuppliers.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.blue.shade400,
            content: Text('please_add_a_suppliers'.tr),
            behavior: SnackBarBehavior.floating,
          )
      );
      return;
    }

    final payload = FormData.fromMap({
      'submission_id': submission.value.id,
      'notes': fieldNotes.value.value.text,
      for(final (idx, item) in selectedSuppliers.indexed) 'items[${idx+1}][supplier_id]': item.supplier!.id,
      for(final (idx, item) in selectedSuppliers.indexed) 'items[${idx+1}][file]': MultipartFile.fromBytes(item.fileBytes!,
        filename: item.file!.name, contentType: DioMediaType('file', item.file!.name.split('.').last)
      ),
    });

    LoadingFullscreen.startLoading();
    final response = await DioClient().post('/submission/set-suppliers',
      data: payload
    );
    LoadingFullscreen.stopLoading();
    if(response['success'] ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.lightBlue,
            content: Text('successful_'.trParams({'value': 'set_supplier'.tr})),
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
  }
}
