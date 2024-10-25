import 'package:asset_management_module/component_widget/loading.dart';
import 'package:asset_management_module/model/purchase_order_submission.dart';
import 'package:asset_management_module/model/submission_suppliers.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogReasonController extends GetxController {
  Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;
  Rx<TextEditingController> fieldReason = TextEditingController().obs;
  RxString type = ''.obs;
  Rx<PurchaseOrderSubmission> submission = PurchaseOrderSubmission().obs;
  RxString label = ''.obs;
  Rx<SupplierRelations> selectedSupplier = SupplierRelations().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    type.value = Get.arguments['type'];
    submission.value = Get.arguments['data'];
    if(type.value.contains('approve')) {
      label.value = 'approve_submission'.tr;
      if(type.value == 'approve_level_2') selectedSupplier.value = Get.arguments['selected_supplier'];
    } else {
      label.value = 'reject_submission'.tr;
    }
  }

  void send(context) async {
    dynamic response;
    String message = '';
    Map<String, dynamic> payload = {
      'id': submission.value.id,
    };

    if(type.value == 'approve_level_1' || type.value == 'reject_level_1') {
      payload['reason'] = fieldReason.value.value.text;
      payload['type'] = 'approval_level_1';
      message = 'submission_approved'.tr;

      if(type.value == 'reject_level_1') message = 'submission_rejected'.tr;
    }
    if(type.value == 'approve_level_2' || type.value == 'reject_level_2') {
      payload['id'] = submission.value.findSupplierId;
      payload['reason'] = fieldReason.value.value.text;
      payload['type'] = 'approval_level_2';
      payload['approved_suppliers'] = selectedSupplier.value.id;
      message = 'submission_selected_supplier'.tr;

      if(type.value == 'reject_level_3') message = 'submission_rejected'.tr;
    }
    if(type.value == 'approve_level_3' || type.value == 'reject_level_3') {
      payload['id'] = submission.value.findSupplierId;
      payload['reason'] = fieldReason.value.value.text;
      payload['type'] = 'approval_level_3';
      message = 'submission_approved'.tr;

      if(type.value == 'reject_level_3') message = 'submission_rejected'.tr;
    }

    LoadingFullscreen.startLoading();
    if(type.value.contains('approve')){
      response = await DioClient().post('/submission/approved',
        data: payload
      );
    } else if (type.value.contains('reject')){
      response = await DioClient().post('/submission/rejected',
        data: payload
      );
    }
    LoadingFullscreen.stopLoading();
    if(response['success'] ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.lightBlue,
            content: Text('successful_'.trParams({'value': message})),
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
