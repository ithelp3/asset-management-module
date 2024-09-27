import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LendingController extends GetxController {
  Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;
  Rx<TextEditingController> fieldTitle = TextEditingController().obs;
  Rx<TextEditingController> fieldNeeds = TextEditingController().obs;
  Rx<TextEditingController> fieldFirstDate = TextEditingController().obs;
  Rx<TextEditingController> fieldLastDate = TextEditingController().obs;
  DateTime? selectedFirstDate;
  DateTime? selectedLastDate;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void selectDate(context, String key) async {
    DateTime firstDate = DateTime(2005);
    if(key == 'last') firstDate = selectedFirstDate!;
    final date = await showDatePicker(
        context: context,
        firstDate: firstDate,
        initialDate: DateTime.now(),
        lastDate: DateTime(2100)
    );

    if(date == null) return;
    String selectDate = DateFormat('yyyy-MM-dd').format(date);
    if(key == 'first'){
      fieldFirstDate.value.value = TextEditingValue(text: selectDate);
      selectedFirstDate = date;
    } else {
      selectedLastDate = date;
      fieldLastDate.value.value = TextEditingValue(text: selectDate);
    }

  }

  void save() {}
}
