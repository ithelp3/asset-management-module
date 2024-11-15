import 'package:asset_management_module/component_widget/dialog_item_select.dart';
import 'package:asset_management_module/component_widget/loading.dart';
import 'package:asset_management_module/model/submission.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddEditSubmissionController extends GetxController {
  Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;
  Rx<TextEditingController> fieldSubject = TextEditingController().obs;
  Rx<TextEditingController> fieldNeeds = TextEditingController().obs;
  Rx<TextEditingController> fieldPoDate = TextEditingController().obs;
  Rx<TextEditingController> fieldPriority = TextEditingController().obs;
  Rx<Submission> submission = Submission().obs;
  DateTime? selectedDate;
  RxString selectedPriority = 'NORMAL'.tr.obs;
  RxString type = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    type.value = Get.arguments['type'];
    if(type.value == 'edit') {
      submission.value = Get.arguments['data'];
      fieldSubject.value.value = TextEditingValue(text: submission.value.subject!);
      fieldNeeds.value.value = TextEditingValue(text: submission.value.submissionDetail!);
      fieldPoDate.value.value = TextEditingValue(text: submission.value.dateUsed!);
      fieldPriority.value.value = TextEditingValue(text: submission.value.priority!);
      selectedPriority.value = submission.value.priority!;
    }
  }

  void selectDate(context) async {
    DateTime initial = type.value == 'add'
        ? DateTime.now()
        : DateFormat('yyyy-MM-dd').parse(submission.value.dateUsed!);
    final date = await showDatePicker(
        context: context,
        firstDate: DateTime(2005),
        initialDate: initial,
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
    selectedPriority.value = result['value'];
  }

  void save(context) async {
    dynamic response;
    Map<String, dynamic> payload = {
      'subject': fieldSubject.value.value.text,
      'submission_detail': fieldNeeds.value.value.text,
      'date_used': fieldPoDate.value.value.text,
      'priority': fieldPriority.value.value.text == 'NORMAL' ? 0 : 1,
    };

    LoadingFullscreen.startLoading();
    if(type.value == 'add') {
      response = await DioClient().post('/submission/create',
          data: payload
      );
    } else {
      payload['id'] = submission.value.id;
      response = await DioClient().post('/submission/update',
          data: payload
      );
    }

    LoadingFullscreen.stopLoading();
    if(response['success'] ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.lightBlue,
            content: Text('successful_'.trParams({'value': 'create_submission'.tr})),
            behavior: SnackBarBehavior.floating,
          )
      );
      Get.back(result: type.value == 'edit');
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
