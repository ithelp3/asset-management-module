import 'package:asset_management_module/component_widget/dialog_item_select.dart';
import 'package:asset_management_module/component_widget/formates.dart';
import 'package:asset_management_module/component_widget/loading.dart';
import 'package:asset_management_module/model/asset.dart';
import 'package:asset_management_module/model/component.dart';
import 'package:asset_management_module/model/depreciation.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEditDepreciationController extends GetxController {
  RxString type = ''.obs;
  Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;
  Rx<TextEditingController> fieldMethod = TextEditingController().obs;
  Rx<TextEditingController> fieldCategory = TextEditingController().obs;
  Rx<TextEditingController> fieldByCategory = TextEditingController().obs;
  Rx<TextEditingController> fieldCostByCategory = TextEditingController().obs;
  Rx<TextEditingController> fieldPeriod = TextEditingController().obs;
  Rx<TextEditingController> fieldValue = TextEditingController().obs;
  RxList<Asset> assets = <Asset>[].obs;
  Rx<Asset> asset = Asset().obs;
  RxList<Component> components = <Component>[].obs;
  Rx<Component> component = Component().obs;
  Rx<Depreciation> depreciation = Depreciation().obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    type.value = Get.arguments['type'];
    if(type.value == 'edit') {
      depreciation.value = Get.arguments['data'];
      fieldMethod.value.value = TextEditingValue(
        text: depreciation.value.depreciationFormula == 1 ? 'straight_line_method'.tr : 'decreasing_balance_method'.tr
      );
        fieldValue.value.value = TextEditingValue(
          text: depreciation.value.depreciationFormula == 1
              ? depreciation.value.assetValue ?? '0'
              : depreciation.value.depreciationRate ?? '0'
        );
      if(depreciation.value.assetId != null) {
        fieldCategory.value.value = TextEditingValue(text:'asset'.tr);
        fieldByCategory.value.value = TextEditingValue(text: depreciation.value.asset ?? 'N/A');
        fieldCostByCategory.value.value = TextEditingValue(text: double.tryParse(depreciation.value.assetValue ?? '0.0')!.toIdr());
      } else {
        fieldCategory.value.value = TextEditingValue(text:'component'.tr);
        fieldByCategory.value.value = TextEditingValue(text: depreciation.value.component ?? 'N/A');
        fieldCostByCategory.value.value = TextEditingValue(text: double.tryParse(depreciation.value.componentCost ?? '0.0')!.toIdr());
      }
      fieldPeriod.value.value = TextEditingValue(text: depreciation.value.period ?? '0');
    }
    DioClient().get('/depreciation/data-before-create').then((res) {
      assets.value = List.from(res['data']['assets'].map((json) => Asset.fromJson(json)));
      components.value = List.from(res['data']['components'].map((json) => Component.fromJson(json)));
    });
    update();
  }

  void selectItem(context, String key) async {
    String label = '';
    List<Item> items = [];
    if(key == 'method') {
      label = 'select_item_label'.trParams({'value': 'depreciation_method'.tr});
      items = ['straight_line_method'.tr, 'decreasing_balance_method'.tr].map((i) => Item(
        label: i,
        value: i
      )).toList();
    } else if(key == 'category') {
      label = 'select_item_label'.trParams({'value': 'category'.tr});
      items = ['asset'.tr, 'component'.tr].map((i) => Item(
          label: i,
          value: i
      )).toList();
    } else if(key == 'asset') {
      label = 'select_item_label'.trParams({'value': 'asset'.tr});
      items = assets.map((i) => Item(
          label: i.name,
          value: i
      )).toList();
    } else if(key == 'component') {
      label = 'select_item_label'.trParams({'value': 'component'.tr});
      items = components.map((i) => Item(
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

    if(key == 'method') {
      String selected = result['value'];
      fieldMethod.value.value = TextEditingValue(text: selected);
      fieldByCategory.value = TextEditingController();
      fieldCostByCategory.value = TextEditingController();
      fieldPeriod.value = TextEditingController();
      fieldValue.value = TextEditingController();
      asset.value = Asset();
      component.value = Component();
    } else if(key == 'category') {
      String selected = result['value'];
      fieldCategory.value.value = TextEditingValue(text: selected);
      fieldCostByCategory.value = TextEditingController();
      fieldByCategory.value = TextEditingController();
      asset.value = Asset();
      component.value = Component();
    } else if(key == 'asset') {
      Asset selected = result['value'];
      fieldByCategory.value.value = TextEditingValue(text: selected.name!);
      fieldCostByCategory.value.value = TextEditingValue(text: double.tryParse(selected.cost ?? '0.0')!.toIdr());
      asset.value = selected;
      fieldPeriod.value = TextEditingController();
      fieldValue.value = TextEditingController();
    } else if(key == 'component') {
      Component selected = result['value'];
      fieldByCategory.value.value = TextEditingValue(text: selected.name!);
      fieldCostByCategory.value.value = TextEditingValue(text: double.tryParse(selected.cost ?? '0.0')!.toIdr());
      component.value = selected;
      fieldPeriod.value = TextEditingController();
      fieldValue.value = TextEditingController();
    }
    update();
  }

  void save(context) async {
    dynamic response;
    LoadingFullscreen.startLoading();
    if(type.value == 'add'){
      Map<String, dynamic> payload = {
        'period': fieldPeriod.value.value.text,
      };
      if(fieldMethod.value.value.text == 'straight_line_method'.tr){
        payload['depreciation_formula'] = 1;
        payload['asset_value'] = fieldValue.value.value.text;
        payload['depreciation_rate'] = null;
      } else {
        payload['depreciation_formula'] = 2;
        payload['depreciation_rate'] = fieldValue.value.value.text;
        payload['asset_value'] = null;
      }
      if(fieldCategory.value.value.text == 'asset'.tr) {
        payload['asset_id'] = asset.value.id;
        payload['component_id'] = null;
      } else {
        payload['asset_id'] = null;
        payload['component_id'] = component.value.id;
      }
      response = await DioClient().post('/depreciation/add',
          data: payload
      );
    } else {
      Map<String, dynamic> payload = {
        'id': depreciation.value.id,
        'period': fieldPeriod.value.value.text,
      };
      if(fieldMethod.value.value.text == 'straight_line_method'.tr){
        payload['depreciation_formula'] = 1;
        payload['asset_value'] = fieldValue.value.value.text;
        payload['depreciation_rate'] = null;
      } else {
        payload['depreciation_formula'] = 2;
        payload['depreciation_rate'] = fieldValue.value.value.text;
        payload['asset_value'] = null;
      }
      response = await DioClient().post('/depreciation/update',
          data: payload
      );
    }

    LoadingFullscreen.stopLoading();
    if(response['success'] ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.lightBlue,
            content: Text('successful_'.trParams({'value': type.value == 'add' ? 'add_depreciation'.tr : 'edit_depreciation'.tr})),
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
