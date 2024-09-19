import 'package:asset_management_module/model/maintenance.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MaintenanceController extends GetxController {
  Rx<TextEditingController> fieldSearch = TextEditingController().obs;
  RxList<Maintenance> maintenances = <Maintenance>[].obs;
  RxList<Maintenance> maintenanceSearch = <Maintenance>[].obs;
  RxBool progress = false.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    progress.value = true;
    await DioClient().get('/maintenance/list').then((res) => maintenances.value = List.from(res['data'].map((json) => Maintenance.fromJson(json))));
    progress.value = false;
  }

  void onSearch(String key) {
    maintenanceSearch.value = maintenances.where((item) =>
        item.assetTag!.toLowerCase().contains((key.toLowerCase()))).toList();
    update();
  }

  void clearSearch() {
    fieldSearch.value = TextEditingController();
    maintenanceSearch.value = [];
    update();
  }
}
