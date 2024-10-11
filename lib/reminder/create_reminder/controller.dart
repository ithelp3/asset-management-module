import 'package:asset_management_module/component_widget/dialog_item_select.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateReminderController extends GetxController with GetTickerProviderStateMixin{
  Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;
  Rx<TextEditingController> fieldNameReminder = TextEditingController().obs;
  Rx<TextEditingController> fieldNotification = TextEditingController().obs;
  Rx<TextEditingController> fieldRepeat = TextEditingController().obs;
  Rx<TextEditingController> fieldCategory = TextEditingController().obs;
  Rx<TextEditingController> fieldDescription = TextEditingController().obs;
  RxBool switchEveryDay = false.obs;
  RxBool showCalender = false.obs;
  DateTime dateFocus = DateTime.now();
  DateTime? dateSelected;
  DateTime? dateStart = DateTime.now();
  DateTime? dateEnd;
  AnimationController? animationControllerDate;
  AnimationController? animationControllerTime;
  RxString keyDate = ''.obs;
  RxBool showTime = false.obs;
  RxString keyTime = ''.obs;
  DateTime timeStart = DateTime.now();
  DateTime timeEnd = DateTime.now();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    animationControllerDate = AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this
    );
    animationControllerTime = AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this
    );
  }

  void onSwitch(bool value) {
    switchEveryDay.value = !switchEveryDay.value;
  }

  void selectedDate(DateTime selectedDate, DateTime focusedDay) {
    dateFocus = focusedDay;
    dateSelected = selectedDate;
    if(keyDate.value == 'start') dateStart = selectedDate;
    if(keyDate.value == 'end') dateEnd = selectedDate;
    update();
  }

  void showSelectCalender(String key) {
    if(showCalender.value && (keyDate.value == key)) {
      animationControllerDate!.reverse();
      showCalender.value = false;
    } else {
      if(showTime.value) {
        showTime.value = false;
        animationControllerTime!.reverse();
      }
      animationControllerDate!.forward();
      showCalender.value = true;
    }
    keyDate.value = key;
  }

  void showSelectTime(String key) {
    if(showTime.value && (keyTime.value == key)) {
      animationControllerTime!.reverse();
      showTime.value = false;
    } else {
      if(showCalender.value) {
        showCalender.value = false;
        animationControllerDate!.reverse();
      }
      animationControllerTime!.forward();
      showTime.value = true;
    }
    keyTime.value = key;
  }

  void selectedTime(DateTime newTime) async {
    if(keyTime.value == 'start') {
      timeStart = newTime;
    }
    if(keyTime.value == 'end') {
      timeEnd = newTime;
    }
    update();
  }

  void selected(context, String key) async {
    String label = '';
    List<Item> items = [];
    if(key == 'repeat') {
      label = 'repeat'.tr;
      items = ['weekly'.tr, 'monthly'.tr, 'yearly'.tr].map((i) => Item(
          label: i,
          value: i
      )).toList();
    }else if(key == 'category') {
      label = 'category'.tr;
      items = ['asset_management'.tr, 'maintenance'.tr, 'lending'.tr].map((i) => Item(
          label: i,
          value: i
      )).toList();
    }

    dynamic result = await showDialog(
        context: context,
        builder: (context) => dialogItemSelect(context,
            label: label,
            items: items
        )
    );
    if(result == null) return;

    if(key == 'repeat') {
      fieldRepeat.value.value = TextEditingValue(text: result['value']);
    } else if(key == 'category') {
      fieldCategory.value.value = TextEditingValue(text: result['value']);
    }
  }
}
