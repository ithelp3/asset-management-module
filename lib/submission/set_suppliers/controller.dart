import 'package:asset_management_module/model/purchase_order_submission.dart';
import 'package:asset_management_module/model/supplier.dart';
import 'package:asset_management_module/submission/set_suppliers/dialog_supplier_add/controller.dart';
import 'package:asset_management_module/submission/set_suppliers/dialog_supplier_add/view.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:get/get.dart';

class SetSuppliersController extends GetxController {
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

  void send() {}
}
