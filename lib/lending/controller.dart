import 'package:asset_management_module/component_widget/dialog_item_select.dart';
import 'package:asset_management_module/model/asset.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LendingController extends GetxController with GetTickerProviderStateMixin{
  Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;
  AnimationController? animationControllerDate;
  Rx<TextEditingController> fieldAsset = TextEditingController().obs;
  Rx<TextEditingController> fieldNeeds = TextEditingController().obs;
  Rx<TextEditingController> fieldFirstDate = TextEditingController().obs;
  Rx<TextEditingController> fieldLastDate = TextEditingController().obs;
  RxList<Asset> assets = <Asset>[].obs;
  Rx<Asset> asset = Asset().obs;
  DateTime? selectedFirstDate;
  DateTime? selectedLastDate;
  RxBool showCalender = false.obs;
  DateTime dateFocus = DateTime.now();
  DateTime? dateSelected;
  DateTime? dateStart = DateTime.now();
  DateTime? dateEnd;
  RxString keyDate = ''.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    animationControllerDate = AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this
    );
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
      animationControllerDate!.forward();
      showCalender.value = true;
    }
    keyDate.value = key;
  }

  void save() {}
}
