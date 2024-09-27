import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class LendingPage extends StatelessWidget {
  const LendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: LendingController(),
      builder: (ctr) => Scaffold(
        appBar: AppBar(
          title: Text('lending'.tr),
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : const Color(0xFF272d34),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios,
              color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,),
          ),
          centerTitle: true,
        ),
        body: Form(
            key: ctr.formKey.value,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'title'.tr,
                            hintText: 'write_in_field'.trParams({'value': 'title'.tr}),
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
                              ? 'please_in_field'.trParams({'value': 'title'.tr})
                              : null,
                          controller: ctr.fieldTitle.value,
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
                          onTap: () => ctr.selectDate(context, 'first'),
                          decoration: InputDecoration(
                            labelText: 'lending_date'.tr,
                            hintText: 'select_item_field'.trParams({'value': 'lending_date'.tr}),
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
                              ? 'please_in_field'.trParams({'value': 'lending_date'.tr})
                              : null,
                          controller: ctr.fieldFirstDate.value,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: TextFormField(
                          readOnly: true,
                          onTap: () => ctr.selectDate(context, 'last'),
                          decoration: InputDecoration(
                            labelText: 'return_date'.tr,
                            hintText: 'select_in_field'.trParams({'value': 'return_date'.tr}),
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
                              ? 'please_in_field'.trParams({'value': 'return_date'.tr})
                              : null,
                          controller: ctr.fieldLastDate.value,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.only(bottom: 40, top: 10, left: 10, right: 10),
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
                        // if(ctr.formKey.value.currentState!.validate()) ctr.save(context);
                      },
                      child: Text('save'.tr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
                  ),
                )
              ],
            )
        ),
      ),
    );
  }
}
