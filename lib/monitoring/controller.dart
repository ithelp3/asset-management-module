import 'package:asset_management_module/model/purchase_order_submission.dart';
import 'package:asset_management_module/purchase_order/view.dart';
import 'package:asset_management_module/submission/choose_approved_supplier/view.dart';
import 'package:asset_management_module/submission/dialog_reason/view.dart';
import 'package:asset_management_module/submission/set_suppliers/view.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:get/get.dart';

class MonitoringController extends GetxController {
  RxBool progress = false.obs;
  RxList<PurchaseOrderSubmission> items = <PurchaseOrderSubmission>[].obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    progress.value = true;
    await DioClient().get('/submission/list')
      .then((res) => items.value = List.from(res['data'].map((json) => PurchaseOrderSubmission.fromJson(json))));
    progress.value = false;
  }

  void reject(PurchaseOrderSubmission item) async {
    final result = await Get.dialog(const DialogReasonPage(),
      arguments: {
        'type': item.step == 2
            ? 'reject_level_1'
            : 'reject_level_3',
        'data': item,
      }
    );
    if(result == null) return;

    Get.back(result: true);
  }

  void approve(PurchaseOrderSubmission item) async {
    final result = await Get.dialog(const DialogReasonPage(),
      arguments: {
        'type': item.step == 2
            ? 'approve_level_1'
            : 'approve_level_3',
        'data': item
      }
    );
    if(result == null) return;

    Get.back(result: true);
  }

  void findSupplier(PurchaseOrderSubmission item) async {
    final result = await Get.to(const SetSuppliersPage(),
        routeName: '/submission/find-supplier',
        transition: Transition.rightToLeft,
        arguments: {
          'data': item
        }
    );
    if(result == null) return;

    Get.back(result: true);
  }

  void chooseApprovedSupplier(PurchaseOrderSubmission item) async {
    final result = await Get.to(const ChooseApprovedSupplierPage(),
      arguments: {
        'data' : item
      },
      routeName: '/submission/choose-approved-supplier',
    );
    if(result == null) return;

    Get.back(result: true);
  }

  void createPurchaseOrder(PurchaseOrderSubmission item) async {
    final result = await Get.to(const PurchaseOrderPage(),
      arguments: {
        'type': 'submission',
        'data' : item
      },
      routeName: '/submission/create-purchase-order',
    );
    if(result == null) return;
  }

  void uploadInvoice(PurchaseOrderSubmission item) async {}
}
