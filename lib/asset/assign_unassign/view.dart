import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class AssignUnassignPage extends StatelessWidget {
  const AssignUnassignPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AssignUnassignController(),
      builder: (ctr) => Obx(() => Scaffold(
        appBar: AppBar(
          title: Text(ctr.asset.value.status == '2' ? 'un_assign'.tr : 'assign'.tr),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios,
              color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,),
          ),
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : const Color(0xFF272d34),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(child: Form(
              key: ctr.formKey.value,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 14, left: 10, right: 10),
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'tag_asset'.tr,
                        prefixIcon: const Icon(Icons.tag_outlined, color: Color(0xFF3f87b9), size: 22,),
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
                      controller: ctr.fieldTagAsset.value,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 14, left: 10, right: 10),
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'asset'.tr,
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
                      controller: ctr.fieldAsset.value,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 14, left: 10, right: 10),
                    child: TextFormField(
                      readOnly: true,
                      onTap: () {
                        if(ctr.asset.value.status != '2') ctr.selectItem(context);
                      },
                      decoration: InputDecoration(
                        labelText: 'assign'.tr,
                        hintText: 'select_item_field'.trParams({'value': 'assign'.tr}),
                        prefixIcon: const Icon(Icons.assignment_ind_outlined, color: Color(0xFF3f87b9), size: 22,),
                        suffixIcon: const Icon(Icons.expand_more_outlined, color: Color(0xFF3f87b9),),
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
                          ? 'please_in_field'.trParams({'value': 'assign'.tr})
                          : null,
                      controller: ctr.fieldAssign.value,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 14, left: 10, right: 10),
                    child: TextFormField(
                      readOnly: true,
                      onTap: () => ctr.selectDate(context),
                      decoration: InputDecoration(
                        labelText: 'assign_date'.tr,
                        hintText: 'select_item_field'.trParams({'value': 'assign_date'.tr}),
                        prefixIcon: const Icon(Icons.date_range_outlined, color: Color(0xFF3f87b9), size: 22,),
                        suffixIcon: const Icon(Icons.expand_more_outlined, color: Color(0xFF3f87b9),),
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
                          ? 'please_in_field'.trParams({'value': 'assign_date'.tr})
                          : null,
                      controller: ctr.fieldAssignDate.value,
                    ),
                  ),
                ],
              ),
            )),
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
                    if(ctr.formKey.value.currentState!.validate()) ctr.save(context);
                  },
                  child: Text('save'.tr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
              ),
            )
          ],
        ),
      ))
    );
  }
}
