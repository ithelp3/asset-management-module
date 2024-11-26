import 'package:asset_management_module/model/submission.dart';
import 'package:asset_management_module/model/submission_log.dart';
import 'package:asset_management_module/model/submission_suppliers.dart';
import 'package:asset_management_module/purchase_order/add_edit_purchase/view.dart';
import 'package:asset_management_module/submission/add_edit_submission/view.dart';
import 'package:asset_management_module/submission/choose_approved_supplier/view.dart';
import 'package:asset_management_module/submission/dialog_reason/view.dart';
import 'package:asset_management_module/submission/set_suppliers/view.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:asset_management_module/utils/data/nav_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;

class SubmissionDetailsController extends GetxController with GetTickerProviderStateMixin {
  AnimationController? animationControllerRotation1;
  AnimationController? animationControllerRotation2;
  // Rx<Monitoring> monitoring = Monitoring().obs;
  RxInt submissionId = 0.obs;
  Rx<Submission> submission = Submission().obs;
  RxList<SubmissionLog> logs = <SubmissionLog>[].obs;
  RxBool expandHead = false.obs;
  RxBool showUploadInvoice = false.obs;
  RxBool progress = false.obs;
  
  RxList<SupplierRelations> selectedSuppliers = <SupplierRelations>[].obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    progress.value = true;
    animationControllerRotation1 = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
        upperBound: 0.5
    );
    animationControllerRotation2 = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
        upperBound: 0.5
    );
    // monitoring.value = Get.arguments['data'];
    submissionId.value = Get.arguments['id'];
    getData();
  }

  void getData() async {
    await DioClient().post('/submission/details',
      data: {
        'id': submissionId.value,
        'language': NavKey.pwa!.language
      }
    )
      .then((res) {
        submission.value = Submission.fromJson(res['data']);
         logs.value = List.from(res['logs'].map((json) => SubmissionLog.fromJson(json)));
         selectedSuppliers.value = List.from(res['suppliers'].map((json) => SupplierRelations.fromJson(json)));
      });
    progress.value = false;
  }

  void selectExpand(String key) {
    if(key == 'head'){
      if(expandHead.value) {
        animationControllerRotation1!.reverse(from: 0.5);
      } else {
        animationControllerRotation1!.forward(from: 0.0);
      }
      expandHead.value = !expandHead.value;
    }
  }

  void reject() async {
    final result = await Get.dialog(const DialogReasonPage(),
        arguments: {
          'type': 'reject_level_1',
          'data': submission.value
        }
    );
    if(result == null) return;

    Get.back(result: true);
  }

  void approve() async {
    final result = await Get.dialog(const DialogReasonPage(),
        arguments: {
          'type': 'approve_level_1',
          'data': submission.value
        }
    );
    if(result == null) return;

    Get.back(result: true);
  }

  void findSupplier(String key) async {
    String type = key;
    final result = await Get.to(const SetSuppliersPage(),
        routeName: '/submission/find-supplier',
        transition: Transition.rightToLeft,
        arguments: {
          'type': type,
          'data': submission.value,
          if(type == 'edit')'suppliers': selectedSuppliers,
        }
    );
    if(result == null) return;

    getData();
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
    final result = await Get.to(const AddEditPurchasePage(),
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


  
  void resubmission() async {
    final result = await Get.to(const AddEditSubmissionPage(),
      routeName: '/submission/edit',
      arguments: {
        'type': 'edit',
        'data': submission.value
      }
    );

    if(result == null) return;

    getData();
  }
}
