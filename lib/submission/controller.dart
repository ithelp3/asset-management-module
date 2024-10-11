import 'package:asset_management_module/model/purchase_order_submission.dart';
import 'package:asset_management_module/model/submission.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubmissionController extends GetxController with GetTickerProviderStateMixin{
  TabController? tabController;
  Rx<PurchaseOrderSubmission> dataPo = PurchaseOrderSubmission().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    dataPo.value = Get.arguments['data'];
  }
}
