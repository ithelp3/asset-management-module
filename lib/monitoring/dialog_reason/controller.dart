import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogReasonController extends GetxController {
  Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;
  Rx<TextEditingController> fieldReason = TextEditingController().obs;
  RxString type = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    type.value = Get.arguments['type'];
  }

  void send() {}
}
