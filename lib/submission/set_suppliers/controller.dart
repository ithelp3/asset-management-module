import 'package:asset_management_module/model/submission.dart';
import 'package:asset_management_module/component_widget/loading.dart';
import 'package:asset_management_module/model/submission_suppliers.dart';
import 'package:asset_management_module/model/supplier.dart';
import 'package:asset_management_module/submission/set_suppliers/dialog_supplier_add/controller.dart';
import 'package:asset_management_module/submission/set_suppliers/dialog_supplier_add/view.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;

class SetSuppliersController extends GetxController {
  Rx<TextEditingController> fieldNotes = TextEditingController().obs;
  Rx<Submission> submission = Submission().obs;
  RxList<SupplierSelected> selectedSuppliers = <SupplierSelected>[].obs;
  RxList<SupplierSelected> deletedSuppliers = <SupplierSelected>[].obs;
  RxList<Supplier> suppliers = <Supplier>[].obs;
  RxString type = ''.obs;

  RxList<SupplierRelations> supplierRelations = <SupplierRelations>[].obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    type.value = Get.arguments['type'];
    submission.value = Get.arguments['data'];
    await DioClient().get('/supplier/list').then((res) {
      suppliers.value = List.from(res['data'].map((json) => Supplier.fromJson(json)));
    });

    if(type.value == 'edit') {
      supplierRelations.value = Get.arguments['suppliers'];
      for (final i in supplierRelations) {
        Supplier supplierData = suppliers.firstWhere((supp) => supp.id.toString() == i.supplierId);
        selectedSuppliers.add(SupplierSelected(
            id: i.id,
            supplier: supplierData,
            fileName: i.originalFilename,
        ));
      }
    }
  }

  void addSupplier() async {
    final result = await Get.dialog(const DialogSupplierAddPage(),
      arguments: {
        'suppliers': suppliers
      }
    );
    if(result == null) return;

    SupplierSelected supplier = result;
    selectedSuppliers.add(supplier);
  }

  void editSupplier(SupplierSelected item, int idx) async {
    final result = await Get.dialog(const DialogSupplierAddPage(),
        arguments: {
          'suppliers': suppliers,
          'selected': item
        }
    );
    if(result == null) return;

    SupplierSelected supplier = result;
    selectedSuppliers[idx] = supplier;
    // selectedSuppliers.removeAt(idx);
    // selectedSuppliers.add(supplier);
  }

  void deleteSupplier(SupplierSelected item, int idx) {
    deletedSuppliers.add(item);
    selectedSuppliers.removeAt(idx);
  }

  void save(context) async {
    if(selectedSuppliers.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.blue.shade400,
            content: Text('please_add_a_suppliers'.tr),
            behavior: SnackBarBehavior.floating,
          )
      );
      return;
    }

    dynamic response;

    LoadingFullscreen.startLoading();
    if(type.value == 'add') {
      final payload = FormData.fromMap({
        'submission_id': submission.value.id,
        'notes': fieldNotes.value.value.text,
        for(final (idx, item) in selectedSuppliers.indexed) 'items[${idx+1}][supplier_id]': item.supplier!.id,
        for(final (idx, item) in selectedSuppliers.indexed) 'items[${idx+1}][file]': MultipartFile.fromBytes(item.fileBytes!,
            filename: item.fileName, contentType: DioMediaType('file', item.fileName!.split('.').last)
        ),
      });
      response = await DioClient().post('/submission/set-suppliers/create',
          data: payload
      );
    } else {
      List<SupplierSelected> oltItems = selectedSuppliers.where((i) => i.id != 0).toList();
      List<SupplierSelected> newItems = selectedSuppliers.where((i) => i.id == 0).toList();
      final payload = FormData.fromMap({
        'id': submission.value.findSupplierId,
        'submission_id': submission.value.id,
        'notes': fieldNotes.value.value.text,
        for(final (idx, item) in oltItems.indexed) 'items[${idx+1}][supplier_id]': item.supplier!.id,
        for(final (idx, item) in oltItems.indexed) 'items[${idx+1}][itemId]': item.id,
        for(final (idx, item) in oltItems.indexed) 'items[${idx+1}][file]': item.fileBytes != null ? MultipartFile.fromBytes(item.fileBytes!,
            filename: item.fileName, contentType: DioMediaType('file', item.fileName!.split('.').last)
        ) : null,
        if(newItems.isNotEmpty) for(final (idx, item) in newItems.indexed) 'newItems[${idx+1}][supplier_id]': item.supplier!.id,
        if(newItems.isNotEmpty) for(final (idx, item) in newItems.indexed) 'newItems[${idx+1}][file]': MultipartFile.fromBytes(item.fileBytes!,
            filename: item.fileName, contentType: DioMediaType('file', item.fileName!.split('.').last)
        ),
        if(deletedSuppliers.isNotEmpty) for(final (idx, item) in newItems.indexed) 'items[${idx+1}][delete]': item.id,
        'resubmission': 'resubmission'
      });

      response = await DioClient().post('/submission/set-suppliers/update',
          data: payload
      );
    }

    LoadingFullscreen.stopLoading();
    if(response['success'] ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.lightBlue,
            content: Text('successful_'.trParams({'value': 'set_supplier'.tr})),
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
