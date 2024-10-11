import 'package:asset_management_module/component_widget/dialog_item_select.dart';
import 'package:asset_management_module/model/supplier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_file_selector/flutter_web_file_selector.dart';
import 'package:get/get.dart';

class DialogSupplierAddController extends GetxController {
  Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;
  Rx<TextEditingController> fieldSupplier = TextEditingController().obs;
  // Rx<TextEditingController> fieldFile = TextEditingController().obs;
  Rx<TextEditingController> fieldNote = TextEditingController().obs;
  RxList<Supplier> suppliers = <Supplier>[].obs;
  Rx<Supplier> selectedSupplier = Supplier().obs;
  XFile? file;
  RxString fileName = ''.obs;
  RxBool showAlertFileSize = false.obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    suppliers.value = Get.arguments['suppliers'];
    SupplierSelected? editSupplier = Get.arguments['selected'];
    if(editSupplier != null) {
      fieldSupplier.value.value = TextEditingValue(text: editSupplier.supplier!.name!);
      fieldNote.value.value = TextEditingValue(text: editSupplier.note ?? '');
      fileName.value = editSupplier.file!.name;
      file = editSupplier.file;
      selectedSupplier.value = editSupplier.supplier!;
    }
  }

  void selectSupplier(context) async {
    dynamic result = await showDialog(
      context: context,
      builder: (context) => dialogItemSelect(context,
          label: 'select_item_label'.trParams({'value': 'supplier'.tr}),
          items: suppliers.map((i) => Item(
              label: i.name,
              value: i
          )).toList()
      )
    );
    if(result == null) return;
    Supplier selected = result['value'];
    selectedSupplier.value = selected;
    fieldSupplier.value.value = TextEditingValue(text: selected.name!);
  }

  void selectedFile(List<XFile> files) async {
    showAlertFileSize.value = false;
    if(files.isEmpty) return;

    file = files.first;
    fileName.value = file!.name;
    final bytes = await files.first.readAsBytes();
    if((bytes.lengthInBytes/(1024 *1024)) > 4) showAlertFileSize.value = true;
    update();
  }

  void added() {
    Get.back(
      result: SupplierSelected(
        supplier: selectedSupplier.value,
        file: file,
        note: fieldNote.value.value.text,
      )
    );
  }
}

class SupplierSelected {
  Supplier? supplier;
  String? note;
  XFile? file;

  SupplierSelected({
    this.supplier,
    this.note,
    this.file,
  });
}