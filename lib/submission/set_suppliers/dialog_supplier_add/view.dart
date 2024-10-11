import 'package:flutter/material.dart';
import 'package:flutter_web_file_selector/flutter_web_file_selector.dart';
import 'package:get/get.dart';

import 'controller.dart';

class DialogSupplierAddPage extends StatelessWidget {
  const DialogSupplierAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DialogSupplierAddController(),
      builder: (ctr) => Obx(() => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: SizedBox(
          height: 360,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                key: ctr.formKey.value,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 14, right: 14),
                      child: TextFormField(
                        readOnly: true,
                        enableInteractiveSelection: false,
                        onTap: () => ctr.selectSupplier(context),
                        controller: ctr.fieldSupplier.value,
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'select_item_field'.trParams({'value': 'supplier'.tr})
                            : null,
                        style: const TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                          labelText: 'supplier'.tr,
                          labelStyle: const TextStyle(fontSize: 14),
                          hintText: 'write_in_field'.trParams({'value': 'supplier'.tr}),
                          hintStyle: const TextStyle(fontSize: 14),
                          filled: true,
                          prefixIcon: const Icon(Icons.storefront_outlined, color: Color(0xFF3f87b9), size: 22,),
                          suffixIcon: const Icon(Icons.expand_more_outlined, color: Color(0xFF3f87b9),),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFF3f87b9)
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                      margin: const EdgeInsets.only(left: 14, right: 14, top: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF3f87b9)),
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: WebFileSelector(
                        onData: (files) async => ctr.selectedFile(files),
                        accept: '.png, .jpg, .jpeg, .pdf, .doc, .docx, .xls, .xls,',
                        multiple: false,
                        child: Row(
                          children: [
                            const Icon(Icons.document_scanner_outlined, color: Color(0xFF3f87b9), size: 22,),
                            Expanded(child: Padding(
                              padding: const EdgeInsets.only(left: 10 , right: 8),
                              child: Text(ctr.fileName.value == ''
                                ? 'select_item_field'.trParams({'value': 'upload_document'.tr})
                                : ctr.fileName.value,
                                style: const TextStyle(fontSize: 14),
                              ),
                            )),
                            const Icon(Icons.upload, color:  Color(0xFF3f87b9), size: 22,)
                          ],
                        ),
                      ),
                    ),
                    if(ctr.showAlertFileSize.value)Padding(
                      padding: const EdgeInsets.only(right: 14, left: 22, top: 8),
                      child: Text('upload_file_find_supplier'.tr,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.red.shade600, fontSize: 12),),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 12),
                    //   child: WebFileSelector(
                    //     onData: (files) async => ctr.selectedFile(files),
                    //     accept: '.png, .jpg, .jpeg, .pdf, .doc, .docx, .xls, .xls,',
                    //     multiple: false,
                    //     child: TextFormField(
                    //       readOnly: true,
                    //       showCursor: false,
                    //       enableInteractiveSelection: false,
                    //       controller: ctr.fieldSupplier.value,
                    //       validator: (value) => ((value == null || value.isEmpty) || ctr.showAlertFileSize.value)
                    //           ? ctr.showAlertFileSize.value
                    //             ? 'upload_file_find_supplier'.tr
                    //             : 'please_in_field'.trParams({'value': 'upload_document'.tr})
                    //           : null,
                    //       // style: const TextStyle(fontSize: 14),
                    //       decoration: InputDecoration(
                    //         labelText: 'upload_document'.tr,
                    //         // labelStyle: const TextStyle(fontSize: 14),
                    //         hintText: 'write_in_field'.trParams({'value': 'upload_document'.tr}),
                    //         // hintStyle: const TextStyle(fontSize: 14),
                    //         filled: true,
                    //         prefixIcon: const Icon(Icons.document_scanner, color: Color(0xFF3f87b9), size: 22,),
                    //         suffixIcon: const Icon(Icons.upload, color: Color(0xFF3f87b9),),
                    //         border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(6),
                    //         ),
                    //         enabledBorder: OutlineInputBorder(
                    //           borderSide: const BorderSide(
                    //               color: Color(0xFF3f87b9)
                    //           ),
                    //           borderRadius: BorderRadius.circular(10),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12, left: 14, right: 14),
                      child: TextFormField(
                        minLines: 2,
                        maxLines: 4,
                        controller: ctr.fieldNote.value,
                        style: const TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                          labelText: 'note'.tr,
                          labelStyle: const TextStyle(fontSize: 14),
                          hintText: 'write_in_field'.trParams({'value': 'note'.tr}),
                          hintStyle: const TextStyle(fontSize: 14),
                          filled: true,
                          prefixIcon: const Icon(Icons.speaker_notes_outlined, color: Color(0xFF3f87b9), size: 22,),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFF3f87b9)
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ),
              Padding(
                padding: const EdgeInsets.only(right: 14, left: 14, bottom: 14),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if(ctr.formKey.value.currentState!.validate() && ctr.file != null){
                        ctr.added();
                      }
                      if(ctr.file == null) ctr.showAlertFileSize.value = true;
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3f87b9),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                    ),
                    child: Text('added'.tr, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                                ),
                ),
              )
            ],
          ),
        ),
      ))
    );
  }
}
