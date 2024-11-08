import 'package:asset_management_module/component_widget/loading.dart';
import 'package:asset_management_module/model/asset_relations.dart';
import 'package:asset_management_module/model/monitoring.dart';
import 'package:asset_management_module/model/purchase.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_file_selector/flutter_web_file_selector.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';

class PurchaseDetailsController extends GetxController {
  Rx<Monitoring> submission = Monitoring().obs;
  Rx<Purchase> purchase = Purchase().obs;
  RxList<AssetRelations> items = <AssetRelations>[].obs;
  XFile? file;
  RxBool progress = false.obs;
  RxBool showUploadInvoice = false.obs;
  
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    progress.value = true;
    submission.value = Get.arguments['data'];
    await DioClient().post('/purchase-order/details',
      data: { 'find_supplier_id': submission.value.findSupplierId }
    ).then((res) {
      items.value = List.from(res['items'].map((json) => AssetRelations.fromJson(json)));
      purchase.value = Purchase.fromJson(res['purchase']);
    });
    progress.value = false;
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

  void downloadFile() async {
    Uri url = Uri.parse(purchase.value.fileUrl!);
    if(!await launchUrl(url)) {
      throw Exception('Oppss..');
    }
  }
}

