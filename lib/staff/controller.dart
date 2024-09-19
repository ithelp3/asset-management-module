import 'package:asset_management_module/model/employee.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StaffController extends GetxController {
  Rx<TextEditingController> fieldSearch = TextEditingController().obs;
  RxList<Employee> employees = <Employee>[].obs;
  RxList<Employee> employeeSearch = <Employee>[].obs;
  RxBool progress = false.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    progress.value = true;
    await DioClient().get('/user/list').then((res) => employees.value = List.from(res['data'].map((json) => Employee.fromJson(json))));
    progress.value = false;
  }

  void onSearch(String key) {
    employeeSearch.value = employees.where((item) =>
        item.fullName!.toLowerCase().contains((key.toLowerCase()))).toList();
    update();
  }

  void clearSearch() {
    fieldSearch.value = TextEditingController();
    employeeSearch.value = [];
    update();
  }
}
