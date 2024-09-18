import 'package:asset_management_module/component_widget/dialog_item_select.dart';
import 'package:asset_management_module/component_widget/loading.dart';
import 'package:asset_management_module/model/asset.dart';
import 'package:asset_management_module/model/user.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AssignUnassignController extends GetxController {
  Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;
  Rx<Asset> asset = Asset().obs;
  Rx<TextEditingController> fieldTagAsset = TextEditingController().obs;
  Rx<TextEditingController> fieldAsset = TextEditingController().obs;
  Rx<TextEditingController> fieldAssign = TextEditingController().obs;
  Rx<TextEditingController> fieldAssignDate = TextEditingController().obs;
  RxList<User> assigns = <User>[].obs;
  DateTime? selectedDate;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    asset.value = Get.arguments['data'];
    fieldTagAsset.value.value = TextEditingValue(text: asset.value.assetTag ?? 'N/A');
    fieldAsset.value.value = TextEditingValue(text: asset.value.assetName ?? 'N/A');
    await DioClient().get('/user/list').then((res) => assigns.value = List.from(res['data'].map((json) => User.fromJson(json))));
    if(asset.value.status == '2') {
      fieldAssign.value.value = TextEditingValue(text: asset.value.assign ?? 'N/A');
    }
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
    fieldAssignDate.value.value = TextEditingValue(text: selectDate);
    selectedDate = date;
  }

  void selectItem(context) async {
    dynamic result = await showDialog(
      context: context,
      builder: (context) => dialogItemSelect(context,
        label: 'select_item_label'.trParams({'value': 'person_on_charge'.tr}),
        items: assigns.map((i) => Item(
          label: i.fullName,
          value: i,
        )).toList()
      )
    );
    if(result == null) return;
    User selected = result['value'];
    fieldAssign.value.value = TextEditingValue(text: selected.fullName ?? '');
  }
  
  void save(context) async{
    dynamic response;
    LoadingFullscreen.startLoading();
    Map<String, dynamic> payload = {
      'id': asset.value.id,
      'employeeid': assigns.firstWhere((i) => i.fullName == asset.value.assign).id,
      'date': DateFormat('yyyy-MM-dd').format(selectedDate!),
    };

    if(asset.value.status != '2') {
      payload['type'] = 1;
      response = await DioClient().post('/asset/assign-or-unassign',
        data: payload
      );
    } else {
      payload['type'] = 2;
      response = await DioClient().post('/asset/assign-or-unassign',
          data: payload
      );
    }
    
    LoadingFullscreen.stopLoading();
    if(response['success'] ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.lightBlue,
            content: Text('successful_'.trParams({'value': asset.value.status != '2' ? 'assign'.tr : 'un_assign'.tr})),
            behavior: SnackBarBehavior.floating,
          )
      );
      Get.back(result: true);
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
