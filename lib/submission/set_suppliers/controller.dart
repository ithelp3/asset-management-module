import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_web_file_selector/flutter_web_file_selector.dart';
import 'package:get/get_connect/http/src/_http/_io/_file_decoder_io.dart';
import 'package:mime/mime.dart';
import 'package:asset_management_module/component_widget/loading.dart';
import 'package:asset_management_module/model/purchase_order_submission.dart';
import 'package:asset_management_module/model/submission_suppliers.dart';
import 'package:asset_management_module/model/supplier.dart';
import 'package:asset_management_module/submission/set_suppliers/dialog_supplier_add/controller.dart';
import 'package:asset_management_module/submission/set_suppliers/dialog_supplier_add/view.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:path_provider/path_provider.dart';

class SetSuppliersController extends GetxController {
  Rx<TextEditingController> fieldNotes = TextEditingController().obs;
  Rx<PurchaseOrderSubmission> submission = PurchaseOrderSubmission().obs;
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
    submission.value = Get.arguments['submission'];
    await DioClient().get('/supplier/list').then((res) {
      suppliers.value = List.from(res['data'].map((json) => Supplier.fromJson(json)));
    });

    if(type.value == 'edit') {
      supplierRelations.value = Get.arguments['suppliers'];
      for (final i in supplierRelations) {
        // Directory tempDir = await getTemporaryDirectory();
        // String tempPath = tempDir.path;
        // File file = File("$tempPath/${i.originalFilename}");

        // Response response = await DioClient().get(i.fileUrl!, typeBytes: true);
        // final response = await DioClient().get(i.fileUrl!, typeBytes: true);

        // final response = await http.get(Uri.http("http:${i.fileUrl!.replaceAll(' ', "%20")}"),);
        // String fileName = response.headers['content-disposition'] ?? 'File';
        // var raf = file.openSync(mode: FileMode.write);
        // raf.writeFromSync(response.data);
        // await raf.close();
        // final mimeType = lookupMimeType(i.originalFilename.toString(), headerBytes: [0xFF, 0xD8]);
        // final mimeType = response.headers['content-type'] ?? '';
        // mimeType!.split("/");

        // XFile xFile = XFile(fileName, mimeType: mimeType);
        // XFile xFile = XFile.fromData(
        //   response.bodyBytes,
        //   // mimeType: mimeType,
        //   name: i.originalFilename,
        //   path: i.originalFilename,
        // );
        Supplier supplierData = suppliers.firstWhere((supp) => supp.id.toString() == i.supplierId);
        selectedSuppliers.add(SupplierSelected(
            id: i.id,
            supplier: supplierData,
            fileName: i.originalFilename,
            // fileBytes: fileToBytes(xFile.path)
        ));
      }
    }
  }

  // Future getFileByUrl(String url, String fileName) async {
  //   Directory tempDir = await getTemporaryDirectory();
  //   String tempPath = tempDir.path;
  //   File file = File("$tempPath/$fileName");
  //
  //   Response response = await DioClient().get(url);
  //   file.openSync(mode: FileMode.write).writeByteSync(response.data);
  //   final mimeType = lookupMimeType("$tempPath/$fileName", headerBytes: [0xFF, 0xD8]);
  //   mimeType!.split("/");
  //   XFile xFile = XFile("$tempPath/$fileName", mimeType: mimeType);
  //   return xFile;
  // }

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
      response = await DioClient().post('/submission/set-suppliers',
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
