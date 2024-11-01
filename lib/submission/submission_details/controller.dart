import 'package:asset_management_module/component_widget/loading.dart';
import 'package:asset_management_module/model/asset_relations.dart';
import 'package:asset_management_module/model/purchase.dart';
import 'package:asset_management_module/model/purchase_order_submission.dart';
import 'package:asset_management_module/model/submission_log.dart';
import 'package:asset_management_module/model/submission_suppliers.dart';
import 'package:asset_management_module/purchase_order/view.dart';
import 'package:asset_management_module/submission/choose_approved_supplier/view.dart';
import 'package:asset_management_module/submission/dialog_reason/view.dart';
import 'package:asset_management_module/submission/set_suppliers/view.dart';
import 'package:asset_management_module/submission/view.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_file_selector/flutter_web_file_selector.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;

class SubmissionDetailsController extends GetxController with GetTickerProviderStateMixin {
  AnimationController? animationControllerRotation1;
  AnimationController? animationControllerRotation2;
  Rx<PurchaseOrderSubmission> submissionItem = PurchaseOrderSubmission().obs;
  Rx<PurchaseOrderSubmission> submissionDetails = PurchaseOrderSubmission().obs;
  Rx<Purchase> purchase = Purchase().obs;
  RxList<SubmissionLog> logs = <SubmissionLog>[].obs;
  RxList<AssetRelations> items = <AssetRelations>[].obs;
  XFile? file;
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
    submissionItem.value = Get.arguments['data'];
    getData();
  }

  void getData() async {
    await DioClient().get('/submission/details/${submissionItem.value.id}',)
      .then((res) {
        submissionDetails.value = PurchaseOrderSubmission.fromJson(res['data']);
         logs.value = List.from(res['logs'].map((json) => SubmissionLog.fromJson(json)));
         items.value = List.from(res['items'].map((json) => AssetRelations.fromJson(json)));
         if(res['purchase'] != null) purchase.value = Purchase.fromJson(res['purchase']);
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
          'type': submissionDetails.value.step == 2
              ? 'reject_level_1'
              : 'reject_level_3',
          'data': submissionDetails.value
        }
    );
    if(result == null) return;

    Get.back(result: true);
  }

  void approve() async {
    final result = await Get.dialog(const DialogReasonPage(),
        arguments: {
          'type': submissionDetails.value.step == 2
              ? 'approve_level_1'
              : 'approve_level_3',
          'data': submissionDetails.value
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
          'submission': submissionDetails.value,
          if(type == 'edit')'suppliers': selectedSuppliers,
        }
    );
    if(result == null) return;

    getData();
  }

  void chooseApprovedSupplier() async {
    final result = await Get.to(const ChooseApprovedSupplierPage(),
      transition: Transition.rightToLeft,
      arguments: {'data' : submissionDetails.value},
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
        'data' : submissionDetails.value
      },
      routeName: '/submission/create-purchase-order',
    );
    if(result == null) return;

    progress.value = true;
    getData();
  }

  void setFile(List<XFile> files) {
    file = files.first;
    update();
  }

  void uploadInvoice(context) async {
    if(file == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.blue.shade400,
            content: Text('please_add_file'.tr),
            behavior: SnackBarBehavior.floating,
          )
      );
      return;
    }

    LoadingFullscreen.startLoading();
    final fileBytes = await file!.readAsBytes();
    final payload = FormData.fromMap({
      'id': purchase.value.id,
      'file': MultipartFile.fromBytes(fileBytes,
        filename: file!.name,
        contentType: DioMediaType('file', file!.name.split('.').last)
      )
    });

    final response = await DioClient().post('/purchase-order/upload-file',
      data: payload
    );

    LoadingFullscreen.stopLoading();
    if(response['success'] ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.lightBlue,
            content: Text('successful_'.trParams({'value': 'upload_file'.tr})),
            behavior: SnackBarBehavior.floating,
          )
      );
      showUploadInvoice.value = !showUploadInvoice.value;
      getData();
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
  
  void resubmission() async {
    final result = await Get.to(const SubmissionPage(),
      routeName: '/submission/add',
      arguments: {
        'type': 'edit',
        'data': submissionDetails.value
      }
    );

    if(result == null) return;

    getData();
  }
}
