import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PurchaseOrderController extends GetxController {
  Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;
  Rx<TextEditingController> fieldTitle = TextEditingController().obs;
  Rx<TextEditingController> fieldNeeds = TextEditingController().obs;
  Rx<TextEditingController> fieldPoDate = TextEditingController().obs;
  Rx<TextEditingController> fieldPriority = TextEditingController().obs;
  DateTime? selectedDate;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void selectDate(context) async {
    final date = await showDatePicker(
        context: context,
        firstDate: DateTime(2005),
        initialDate: DateTime.now(),
        lastDate: DateTime(2100)
    );

    if(date == null) return;
    String selectDate = DateFormat('yyyy-MM-dd').format(date);
    fieldPoDate.value.value = TextEditingValue(text: selectDate);
    selectedDate = date;
  }

  void save() {}
}
