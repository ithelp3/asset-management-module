import 'package:asset_management_module/component_widget/formates.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetDiscountTaxModalBottomSheetController extends GetxController {
  RxDouble subTotal = 0.0.obs;
  RxDouble taxTotal = 0.0.obs;
  RxDouble discountTotal = 0.0.obs;
  Rx<TextEditingController> fieldDisc = TextEditingController(text: '0').obs;
  Rx<TextEditingController> fieldTotalDisc = TextEditingController(text: '0').obs;
  Rx<TextEditingController> fieldTax = TextEditingController(text: '0').obs;
  Rx<TextEditingController> fieldTotalTax = TextEditingController(text: '0').obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    subTotal.value = Get.arguments['subTotal'];
    fieldDisc.value.value = TextEditingValue(text: Get.arguments['discount'].toString());
    fieldTax.value.value = TextEditingValue(text: Get.arguments['tax'].toString());
    totalDiscount(Get.arguments['discount'].toString());
    totalTax(Get.arguments['tax'].toString());
  }

  void totalDiscount(String v) {
    double value = double.parse(v);
    double total = (value/100) * subTotal.value;
    fieldTotalDisc.value.value = TextEditingValue(text: total.toIdr().replaceAll('Rp', ''));
    discountTotal.value = total;
  }

  void totalTax(String v) {
    double value = double.parse(v);
    double total = (value/100) * subTotal.value;
    fieldTotalTax.value.value = TextEditingValue(text: total.toIdr().replaceAll('Rp', ''));
    taxTotal.value = total;
  }

  void save() {
    Get.back(result: {
      'discount': int.parse(fieldDisc.value.value.text),
      'tax': int.parse(fieldTax.value.value.text)
    });
  }
}
