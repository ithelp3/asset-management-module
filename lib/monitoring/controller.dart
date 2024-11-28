import 'package:asset_management_module/component_widget/loading.dart';
import 'package:asset_management_module/model/monitoring.dart';
import 'package:asset_management_module/model/purchase.dart';
import 'package:asset_management_module/model/submission.dart';
import 'package:asset_management_module/model/submission_suppliers.dart';
import 'package:asset_management_module/purchase_order/add_edit_purchase/view.dart';
import 'package:asset_management_module/submission/add_edit_submission/view.dart';
import 'package:asset_management_module/submission/choose_approved_supplier/view.dart';
import 'package:asset_management_module/submission/dialog_reason/view.dart';
import 'package:asset_management_module/submission/set_suppliers/view.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:asset_management_module/utils/data/nav_key.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';

class MonitoringController extends GetxController with GetTickerProviderStateMixin{
  TabController? tabController;
  RxBool progress = false.obs;
  RxList<Monitoring> itemSubmissions = <Monitoring>[].obs;
  RxList<Monitoring> itemPurchases = <Monitoring>[].obs;

  Rx<Monitoring> itemUploadInvoice = Monitoring().obs;
  XFile? file;
  RxBool showUploadInvoice = false.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    progress.value = true;

    String typeTab = Get.arguments['type'];
    int initTab = 0;
    if(typeTab == 'purchase'.tr) initTab = 1;
    tabController = TabController(length: 2, vsync: this, initialIndex: initTab);

    await DioClient().get('/monitoring/list').then((res) {
      for(final findSupplier in res['find_supplier']) {
        for(final po in res['submission']) {
          Monitoring submission = Monitoring.fromJson(po);
          if(findSupplier == submission.findSupplierId) {
            itemSubmissions.add(submission);
          }
        }
      }
      for(final approve in res['approval']) {
        for(final po in res['submission']) {
          Monitoring submission = Monitoring.fromJson(po);
          if(approve == submission.id) itemSubmissions.add(submission);
        }
      }
      for(final purchase in res['purchases']) {
        for(final po in res['submission']) {
          Monitoring submissionPurchase = Monitoring.fromJson(po);
          if((purchase['find_supplier_id'] ?? 0) != 0 && purchase['find_supplier_id'] == submissionPurchase.findSupplierId) {
            submissionPurchase.status = purchase['status'] == 1 ? 'un_paid' : 'paid';
            submissionPurchase.submissionId = purchase['purchase_id'];
            itemPurchases.add(submissionPurchase);
          }
        }
      }
    }).catchError((err) {
       progress.value = false;
    });
    progress.value = false;
  }

  void reject(Monitoring item) async {
    final response = await DioClient().post('/submission/details',
      data : {
        'id' : item.id,
        'language': NavKey.pwa!.language
      }
    );
    final result = await Get.dialog(const DialogReasonPage(),
      arguments: {
        'type': item.step == 2
            ? 'reject_level_1'
            : 'reject_level_3',
        'data': Submission.fromJson(response['data']),
      }
    );
    if(result == null) return;

    onInit();
  }

  void approve(Monitoring item) async {
    final response = await DioClient().post('/submission/details',
        data : {
          'id' : item.id,
          'language': NavKey.pwa!.language
        }
    );
    final result = await Get.dialog(const DialogReasonPage(),
      arguments: {
        'type': item.step == 2
            ? 'approve_level_1'
            : 'approve_level_3',
        'data': Submission.fromJson(response['data'])
      }
    );
    if(result == null) return;

    onInit();
  }

  void findSupplier(Monitoring item, String type) async {
    Submission submission = Submission();
    List<SupplierRelations> suppliers = [];
    await DioClient().post('/submission/details',
        data : {
          'id' : item.id,
          'language': NavKey.pwa!.language
        }
    ).then((res) {
      submission = Submission.fromJson(res['data']);
      suppliers = List.from(res['suppliers'].map((json) => SupplierRelations.fromJson(json)));
    });
    final result = await Get.to(const SetSuppliersPage(),
        routeName: '/submission/find-supplier',
        transition: Transition.rightToLeft,
        arguments: {
          'type': type,
          'data': submission,
          'suppliers': suppliers
        }
    );
    if(result == null) return;

    Get.back(result: true);
  }

  void chooseApprovedSupplier(Monitoring item) async {
    final response = await DioClient().post('/submission/details',
        data : {
          'id' : item.id,
          'language': NavKey.pwa!.language
        }
    );
    final result = await Get.to(const ChooseApprovedSupplierPage(),
      arguments: {
        'data' : Submission.fromJson(response['data'])
      },
      routeName: '/submission/choose-approved-supplier',
    );
    if(result == null) return;

    Get.back(result: true);
  }

  void createPurchaseOrder(Monitoring item) async {
    final response = await DioClient().post('/submission/details',
        data : {
          'id' : item.id,
          'language': NavKey.pwa!.language
        }
    );
    final result = await Get.to(const AddEditPurchasePage(),
      arguments: {
        'type': 'submission',
        'data' : Submission.fromJson(response['data'])
      },
      routeName: '/submission/create-purchase-order',
    );
    if(result == null) return;
  }

  void showModalUploadInvoice(Monitoring item) {
    itemUploadInvoice.value = item;
    showUploadInvoice.value = !showUploadInvoice.value;
  }

  void setFile(List<XFile> files) {
    file = files.first;
    update();
  }

  void uploadInvoice(context) async {
    if(file == null || itemUploadInvoice.value.id == null) {
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
    Purchase purchase = await DioClient().post('/purchase-order/details',
        data: { 'find_supplier_id': itemUploadInvoice.value.findSupplierId }
    ).then((res) => Purchase.fromJson(res));
    final fileBytes = await file!.readAsBytes();
    final payload = FormData.fromMap({
      'id': purchase.id,
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
      onInit();
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

  void resubmission(Monitoring item) async {
    final response = await DioClient().post('/submission/details',
        data : {
          'id' : item.id,
          'language': NavKey.pwa!.language
        }
    );
    final result = await Get.to(const AddEditSubmissionPage(),
        routeName: '/submission/edit',
        arguments: {
          'type': 'edit',
          'data': Submission.fromJson(response['data'])
        }
    );

    if(result == null) return;

    onInit();
  }
}
