import 'package:flutter/material.dart';
import 'package:flutter_web_file_selector/flutter_web_file_selector.dart';
import 'package:get/get.dart';

import 'controller.dart';

class DialogAssetAddFilePage extends StatelessWidget {
  const DialogAssetAddFilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DialogAssetAddFileController(),
      builder: (ctr) => Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
        ),
        child: Form(
          key: ctr.formKey.value,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('add_file'.tr, style: const TextStyle(color: Color(0xFF3f87b9), fontWeight: FontWeight.bold, fontSize: 18),),
                const Divider(height: 10,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'name'.tr,
                    hintText: 'write_in_field'.trParams({'value': 'name'.tr}),
                    prefixIcon: const Icon(Icons.text_fields_outlined, color: Color(0xFF3f87b9), size: 22,),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color(0xFF3f87b9)
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'please_in_field'.trParams({'value': 'name'.tr})
                      : null,
                  controller: ctr.fieldFileName.value,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF3f87b9)),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: WebFileSelector(
                    onData: (files) async => ctr.selectedFile(files),
                    multiple: false,
                    accept: '.pdf, .doc, .docx, .xls, .xlsx, .jpeg, .png, .jpg',
                    child: Column(
                      children: [
                        const Icon(Icons.upload_rounded, color: Color(0xFF3f87b9), size: 40,),
                        Text(ctr.file == null
                            ? 'file allowed are pdf, doc, docx, xls, xls, jpeg, png, jpg (max 2 MB)'
                            : ctr.file!.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.grey, fontSize: 12),)
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () => Get.back(),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Color(0xFF3f87b9)),
                                borderRadius: BorderRadius.circular(8)
                            ),
                          ),
                          child: Text('cancel'.tr, style: const TextStyle(fontSize: 14, color: Color(0xFF3f87b9)),)
                      ),
                    ),
                    const VerticalDivider(width: 10,),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            if(ctr.formKey.value.currentState!.validate()) ctr.save(context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3f87b9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.zero
                          ),
                          child: Text('save'.tr, style: const TextStyle(color: Colors.white, fontSize: 13),)
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
