import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class AddEditSubmissionPage extends StatelessWidget {
  const AddEditSubmissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AddEditSubmissionController(),
      builder: (ctr) => Obx(() => Scaffold(
        appBar: AppBar(
          title: Text('submission'.tr),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios,
              color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,),
          ),
        ),
        body: Form(
            key: ctr.formKey.value,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'subject'.tr,
                      hintText: 'write_in_field'.trParams({'value': 'subject'.tr}),
                      prefixIcon: const Icon(Icons.web_asset_outlined, color: Color(0xFF3f87b9), size: 22,),
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
                        ? 'please_in_field'.trParams({'value': 'subject'.tr})
                        : null,
                    controller: ctr.fieldSubject.value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'needs'.tr,
                      hintText: 'write_in_field'.trParams({'value': 'needs'.tr}),
                      prefixIcon: const Icon(Icons.chat_outlined, color: Color(0xFF3f87b9), size: 22,),
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
                    minLines: 2,
                    maxLines: 4,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'please_in_field'.trParams({'value': 'needs'.tr})
                        : null,
                    controller: ctr.fieldNeeds.value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: TextFormField(
                    readOnly: true,
                    onTap: () => ctr.selectDate(context),
                    enableInteractiveSelection: false,
                    decoration: InputDecoration(
                      labelText: 'date_needed'.tr,
                      hintText: 'select_item_field'.trParams({'value': 'date_needed'.tr}),
                      prefixIcon: const Icon(Icons.date_range_outlined, color: Color(0xFF3f87b9), size: 22,),
                      suffixIcon: const Icon(Icons.expand_more_outlined, color: Color(0xFF3f87b9), size: 30,),
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
                        ? 'please_in_field'.trParams({'value': 'date_needed'.tr})
                        : null,
                    controller: ctr.fieldPoDate.value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: TextFormField(
                    readOnly: true,
                    onTap: () => ctr.selectPriority(context),
                    enableInteractiveSelection: false,
                    decoration: InputDecoration(
                      labelText: 'priority'.tr,
                      hintText: 'write_in_field'.trParams({'value': 'priority'.tr}),
                      prefixIcon: const Icon(Icons.priority_high_outlined, color: Color(0xFF3f87b9), size: 22,),
                      suffixIcon: const Icon(Icons.expand_more_outlined, color: Color(0xFF3f87b9), size: 30,),
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
                        ? 'please_in_field'.trParams({'value': 'priority'.tr})
                        : null,
                    controller: ctr.fieldPriority.value,
                  ),
                ),
              ],
            )
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(bottom: 30, top: 14, left: 10, right: 10),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : const Color(0xFF272d34)
          ),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)
                  ),
                  backgroundColor: const Color(0xFF3f87b9),
                  foregroundColor: Colors.white
              ),
              onPressed: () {
                if(ctr.formKey.value.currentState!.validate()) ctr.save(context);
              },
              child: Text('save'.tr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
          ),
        ),
      ))
    );
  }
}
