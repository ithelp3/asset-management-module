import 'package:asset_management_module/component_widget/loading.dart';
import 'package:asset_management_module/model/purchase.dart';
import 'package:asset_management_module/purchase_order/add_edit_purchase/view.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_file_selector/flutter_web_file_selector.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;

class PurchaseOrderController extends GetxController {
  RxList<Purchase> purchases = <Purchase>[].obs;
  RxBool progress = false.obs;

  Rx<Purchase> purchaseUploadFile = Purchase().obs;
  XFile? file;
  RxBool showUploadInvoice = false.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    progress.value = true;
    await DioClient().get('/purchase-order/list').then((res)
      => purchases.value = List.from(res['data'].map((json)
      => Purchase.fromJson(json))));

    progress.value = false;
  }

  void addPurchase(context) async {
     final result = await Get.to(const AddEditPurchasePage(),
        routeName: '/purchase-order/add',
        arguments: {
          'type': 'add'
        }
    );

     if(result == null) return;

     onInit();
  }
  void showModalUploadInvoice(Purchase item) {
    purchaseUploadFile.value = item;
    showUploadInvoice.value = !showUploadInvoice.value;
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
      'id': purchaseUploadFile.value.id,
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
}
