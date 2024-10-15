import 'package:asset_management_module/model/purchase_order_submission.dart';
import 'package:asset_management_module/model/sumission_log.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubmissionDetailsController extends GetxController with GetTickerProviderStateMixin{
  AnimationController? animationController;
  Rx<PurchaseOrderSubmission> dataPo = PurchaseOrderSubmission().obs;
  RxList<SubmissionLog> logs = <SubmissionLog>[].obs;
  RxBool expand = true.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
        upperBound: 0.5
    );
    dataPo.value = Get.arguments['data'];
    if(dataPo.value.submissionDetail!.length > 120) expand.value = false;

    await DioClient().get('/purchaseorder/submissionlog/${dataPo.value.id}',
    ).then((res) => logs.value = List.from(res['data'].map((json) => SubmissionLog.fromJson(json))));
  }

  void selectExpand() {
    if(expand.value) {
      animationController!.reverse(from: 0.5);
    } else {
      animationController!.forward(from: 0.0);
    }

    expand.value = !expand.value;
  }
}
