import 'package:asset_management_module/model/component.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComponentController extends GetxController {
  Rx<TextEditingController> fieldSearch = TextEditingController().obs;
  RxList<Component> components = <Component>[].obs;
  RxList<Component> componentSearch = <Component>[].obs;
  RxBool progress = false.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    progress.value = true;
    await DioClient().get('/component/list').then((res) => components.value = List.from(res['data'].map((json) => Component.fromJson(json))));
    progress.value = false;
  }

  void onSearch(String key) {
    componentSearch.value = components.where((item) =>
        item.name!.toLowerCase().contains((key.toLowerCase()))).toList();
    update();
  }

  void clearSearch() {
    fieldSearch.value = TextEditingController();
    componentSearch.value = [];
    update();
  }
}
