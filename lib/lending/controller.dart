import 'package:asset_management_module/component_widget/dialog_item_select.dart';
import 'package:asset_management_module/model/asset.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LendingController extends GetxController {
  Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;
  Rx<TextEditingController> fieldAsset = TextEditingController().obs;
  Rx<TextEditingController> fieldNeeds = TextEditingController().obs;
  Rx<TextEditingController> fieldFirstDate = TextEditingController().obs;
  Rx<TextEditingController> fieldLastDate = TextEditingController().obs;
  RxList<Asset> assets = <Asset>[].obs;
  Rx<Asset> asset = Asset().obs;
  DateTime? selectedFirstDate;
  DateTime? selectedLastDate;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await DioClient().get('/asset/list')
        .then((res) => assets.value = List.from((res['data'].map((json) => Asset.fromJson(json)))));
  }

  void selectItem(context, String key) async {
    String label = '';
    List<Item> items = [];
    if(key == 'asset') {
      label = 'select_item_label'.trParams({'value': 'asset'.tr});
      items = assets.map((i) => Item(
        label: i.name,
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

    if(key == 'asset') {
      Asset selected = result['value'] as Asset;
      fieldAsset.value.value = TextEditingValue(text: selected.name!);
      asset.value = selected;
    }
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
