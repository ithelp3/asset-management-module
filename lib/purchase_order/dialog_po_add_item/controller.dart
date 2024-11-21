import 'package:asset_management_module/component_widget/dialog_item_select.dart';
import 'package:asset_management_module/model/brand.dart';
import 'package:asset_management_module/model/category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogPoAddItemController extends GetxController {
  Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;
  Rx<TextEditingController> fieldName = TextEditingController().obs;
  Rx<TextEditingController> fieldDesc = TextEditingController().obs;
  Rx<TextEditingController> fieldBrand = TextEditingController().obs;
  Rx<TextEditingController> fieldSubCategory = TextEditingController().obs;
  Rx<TextEditingController> fieldQty = TextEditingController().obs;
  Rx<TextEditingController> fieldCost = TextEditingController().obs;
  RxList<Brand> brands = <Brand>[].obs;
  Rx<Brand> selectedBrand = Brand().obs;
  RxList<Category> subCategories = <Category>[].obs;
  Rx<Category> selectedSubCategory = Category().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    brands.value = Get.arguments['brands'];
    subCategories.value = Get.arguments['subCategories'];
  }

  selectedItem(context, String key) async {
    String label = '';
    List<Item> items = [];
    if(key == 'brand') {
      label = 'select_item_label'.trParams({'value': 'brand'.tr});
      items = brands.map((i) => Item(
        label: i.name,
        value: i,
      )).toList();
    } else if(key == 'subCategory') {
      label = 'select_item_label'.trParams({'value': 'sub_category'.tr});
      items = subCategories.map((i) => Item(
        label: '${i.kode} - ${i.name}',
        value: i,
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

    if(key == 'brand') {
      Brand brand = result['value'];
      selectedBrand.value = brand;
      fieldBrand.value.value = TextEditingValue(text: brand.name!);
    } else if(key == 'subCategory') {
      Category subCategory = result['value'];
      selectedSubCategory.value = subCategory;
      fieldSubCategory.value.value = TextEditingValue(text: '${subCategory.kode} - ${subCategory.name}');
    }
  }

  void added() {
    Get.back(
      result: PoItem(
        name: fieldName.value.value.text,
        desc: fieldDesc.value.value.text,
        brand: selectedBrand.value,
        subCategory: selectedSubCategory.value,
        qty: int.parse(fieldQty.value.value.text),
        cost: double.parse(fieldCost.value.value.text),
      )
    );
  }
}

class PoItem {
  String? name;
  String? desc;
  Brand? brand;
  Category? subCategory;
  int? qty;
  double? cost;

  PoItem({
    this.name,
    this.desc,
    this.brand,
    this.subCategory,
    this.qty,
    this.cost,
  });
}
