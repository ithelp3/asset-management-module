import 'package:asset_management_module/model/purchase.dart';
import 'package:asset_management_module/model/purchase_order_submission.dart';
import 'package:asset_management_module/model/submission_log.dart';
import 'package:asset_management_module/model/submission_suppliers.dart';
import 'package:asset_management_module/purchase_order/view.dart';
import 'package:asset_management_module/submission/choose_approved_supplier/view.dart';
import 'package:asset_management_module/submission/dialog_reason/view.dart';
import 'package:asset_management_module/submission/set_suppliers/view.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubmissionDetailsController extends GetxController with GetTickerProviderStateMixin{
  AnimationController? animationController;
  Rx<PurchaseOrderSubmission> submission = PurchaseOrderSubmission().obs;
  Rx<Purchase> purchase = Purchase().obs;
  RxList<SubmissionLog> logs = <SubmissionLog>[].obs;
  RxList<SupplierRelations> items = <SupplierRelations>[].obs;
  RxBool expand = true.obs;
  RxBool progress = false.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    progress.value = true;
    animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
        upperBound: 0.5
    );
    submission.value = Get.arguments['data'];
    if(submission.value.submissionDetail!.length > 120) expand.value = false;

    getData();
  }

  void getData() async {
    await DioClient().get('/submission/details/${submission.value.id}',)
        .then((res) {
           logs.value = List.from(res['data']['logs'].map((json) => SubmissionLog.fromJson(json)));
           items.value = List.from(res['data']['items'].map((json) => SupplierRelations.fromJson(json)));
           if(res['data']['purchase'] != null) purchase.value = Purchase.fromJson(res['data']['purchase']);
        });
    progress.value = false;
  }

  void selectExpand() {
    if(expand.value) {
      animationController!.reverse(from: 0.5);
    } else {
      animationController!.forward(from: 0.0);
    }

    expand.value = !expand.value;
  }

  void reject() async {
    final result = await Get.dialog(const DialogReasonPage(),
        arguments: {
          'type': submission.value.step == 2
              ? 'reject_level_1'
              : 'reject_level_3',
          'data': submission.value
        }
    );
    if(result == null) return;

    Get.back(result: true);
  }

  void approve() async {
    final result = await Get.dialog(const DialogReasonPage(),
        arguments: {
          'type': submission.value.step == 2
              ? 'approve_level_1'
              : 'approve_level_3',
          'data': submission.value
        }
    );
    if(result == null) return;

    Get.back(result: true);
  }

  void findSupplier() async {
    final result = await Get.to(const SetSuppliersPage(),
        routeName: '/submission/find-supplier',
        transition: Transition.rightToLeft,
        arguments: {
          'data': submission.value
        }
    );
    if(result == null) return;

    Get.back(result: true);
  }

  void chooseApprovedSupplier() async {
    final result = await Get.to(const ChooseApprovedSupplierPage(),
      transition: Transition.rightToLeft,
      arguments: {'data' : submission.value},
      routeName: '/submission/choose-approved-supplier',
    );
    if(result == null) return;

    Get.back(result: true);
  }

  void createPurchaseOrder() async {
    final result = await Get.to(const PurchaseOrderPage(),
      transition: Transition.rightToLeft,
      arguments: {
        'type': 'submission',
        'data' : submission.value
      },
      routeName: '/submission/create-purchase-order',
    );
    if(result == null) return;

    progress.value = true;
    getData();
  }

  void uploadInvoice() {}
}
