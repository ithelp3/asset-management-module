import 'package:asset_management_module/component_widget/loading.dart';
import 'package:asset_management_module/model/asset.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_file_selector/flutter_web_file_selector.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;

class DialogAssetAddFileController extends GetxController {
  Rx<Asset> asset = Asset().obs;
  Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;
  Rx<TextEditingController> fieldFileName = TextEditingController().obs;
  RxBool showAlertImage = false.obs;
  XFile? file;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    asset.value = Get.arguments['data'];
  }

  void save(context) async {
    if(file == null) return;

    LoadingFullscreen.startLoading();
    final bytes = await file!.readAsBytes();
    final payload = FormData.fromMap({
      'asset_id': asset.value.id,
      'name': fieldFileName.value.value.text,
      'file': MultipartFile.fromBytes(bytes,
          filename: file!.name,
          contentType: DioMediaType('file', '')
      )
    });

    final response = await DioClient().post('/asset/upload-file',
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

  void selectedFile(List<XFile> files) async {
    showAlertImage.value = false;
    if(files.isEmpty) return;

    file = files.first;
    // imageName.value = files.first.name;
    final bytes = await files.first.readAsBytes();
    if((bytes.lengthInBytes/(1024 *1024)) > 2) showAlertImage.value = true;
    update();
  }
}
