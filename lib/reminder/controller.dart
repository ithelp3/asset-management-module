import 'package:asset_management_module/component_widget/dialog_item_select.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReminderController extends GetxController with GetTickerProviderStateMixin {
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
  DateTime? dateStart;
  DateTime? dateEnd;
  TimeOfDay time = const TimeOfDay(hour: 9, minute: 0);
  AnimationController?  animationController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this
    );
  }

  void onSwitch(bool value) {
    switchEveryDay.value = !switchEveryDay.value;
    if(!value) {
      // showCalender.value = false;
      dateSelected = DateTime.now();
      dateStart = DateTime.now();
      dateEnd = DateTime.now();
      update();
    }
  }

  void selectedDate(DateTime selectedDate, DateTime focusedDay) {
    dateFocus = focusedDay;
    dateSelected = selectedDate;
    dateStart = selectedDate;
    dateEnd = selectedDate;
    update();
  }

  void selectedRangeDate(DateTime? start, DateTime? end, DateTime focusDay) {
    dateSelected = null;
    dateFocus = focusDay;
    dateStart = start;
    dateEnd = end;
    update();
  }

  void selectDate() {
    showCalender.value = !showCalender.value;
    if(showCalender.value) {
      animationController!.forward();
    } else {
      animationController!.reverse();
    }
  }

  void selectTime(context, String key) async {
    TimeOfDay? result = await showTimePicker(
      context: context,
      initialTime: time,
      initialEntryMode: TimePickerEntryMode.input,
      // orientation: Orientation.
      routeSettings: const RouteSettings(
        name: 'reminder/select-notification',
      )
    );

    if(result == null) return;
    if(key == 'notification') fieldNotification.value.value = TextEditingValue(text: result.format(context));
    if(key == 'timeFirst') fieldNotification.value.value = TextEditingValue(text: result.format(context));
    if(key == 'timeLast') fieldNotification.value.value = TextEditingValue(text: result.format(context));
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
