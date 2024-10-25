import 'package:asset_management_module/component_widget/dialog_item_select.dart';
import 'package:asset_management_module/component_widget/loading.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SubmissionController extends GetxController {
  Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;
  Rx<TextEditingController> fieldSubject = TextEditingController().obs;
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

  void selectPriority(context) async {
    final result = await showDialog(
        context: context,
        builder: (context) => dialogItemSelect(context,
            label: 'select_item_label'.trParams({'value': 'priority'.tr}),
            items: ['NORMAL'.tr, 'URGENT'.tr].map((i) => Item(
                label: i,
                value: i
            )).toList()
        )
    );
    if(result == null) return;

    fieldPriority.value.value = TextEditingValue(text: result['value']);
  }

  void save(context) async {
    LoadingFullscreen.startLoading();
    final response = await DioClient().post('/submission/create',
      data: {
        'subject': fieldSubject.value.value.text,
        'submission_detail': fieldNeeds.value.value.text,
        'date_used': fieldPoDate.value.value.text,
        'priority': fieldPriority.value.value.text == 'NORMAL' ? 0 : 1,
      }
    );

    LoadingFullscreen.stopLoading();
    if(response['success'] ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.lightBlue,
            content: Text('successful_'.trParams({'value': 'create_submission'.tr})),
            behavior: SnackBarBehavior.floating,
          )
      );
      Get.back();
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
}
