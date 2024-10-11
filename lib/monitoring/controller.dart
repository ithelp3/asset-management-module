import 'package:asset_management_module/model/purchase_order_submission.dart';
import 'package:asset_management_module/monitoring/dialog_reason/view.dart';
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
    await DioClient().get('/purchaseorder/submissionlist')
      .then((res) => items.value = List.from(res['data'].map((json) => PurchaseOrderSubmission.fromJson(json))));
    progress.value = false;
  }

  void reject() async {
    final result = await Get.dialog(const DialogReasonPage(),
      arguments: {
        'type': 'reject'
      }
    );
    if(result == null) return;
  }

  void approve() async {
    final result = await Get.dialog(const DialogReasonPage(),
      arguments: {
        'type': 'approve'
      }
    );
    if(result == null) return;
  }
}
