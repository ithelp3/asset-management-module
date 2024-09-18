import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'controller.dart';

class AddEditDepreciationPage extends StatelessWidget {
  const AddEditDepreciationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AddEditDepreciationController(),
      builder: (ctr) => Obx(() => Scaffold(
        appBar: AppBar(
          title: Text(ctr.type.value == 'add' ? 'add_depreciation'.tr : 'edit_depreciation'.tr),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black,),
          ),
          backgroundColor: Colors.white,
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
                      onTap: () => ctr.selectItem(context, 'method'),
                      decoration: InputDecoration(
                        labelText: 'depreciation_method'.tr,
                        hintText: 'select_item_field'.trParams({'value': 'depreciation_method'.tr}),
                        prefixIcon: const Icon(Icons.calculate_outlined, color: Color(0xFF3f87b9), size: 22,),
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
                          ? 'please_in_field'.trParams({'value': 'depreciation_method'.tr})
                          : null,
                      controller: ctr.fieldMethod.value,
                    ),
                  ),
                  if(ctr.type.value == 'add') Padding(
                    padding: const EdgeInsets.only(top: 14, left: 10, right: 10),
                    child: TextFormField(
                      readOnly: true,
                      onTap: () =>  ctr.selectItem(context, 'category'),
                      decoration: InputDecoration(
                        labelText: 'category'.tr,
                        hintText: 'select_item_field'.trParams({'value': 'category'.tr}),
                        prefixIcon: const Icon(Icons.category_outlined, color: Color(0xFF3f87b9), size: 22,),
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
                          ? 'please_in_field'.trParams({'value': 'category'.tr})
                          : null,
                      controller: ctr.fieldCategory.value,
                    ),
                  ),
                  if(ctr.fieldCategory.value.value.text != '') Padding(
                    padding: const EdgeInsets.only(top: 14, left: 10, right: 10),
                    child: TextFormField(
                      readOnly: true,
                      onTap: () {
                        if(ctr.type.value == 'add') ctr.selectItem(context, ctr.fieldCategory.value.value.text == 'asset' ? 'asset' : 'component');
                      },
                      decoration: InputDecoration(
                        labelText: ctr.fieldCategory.value.value.text == 'asset'
                            ? 'asset'.tr
                            : 'component'.tr,
                        hintText: 'select_item_field'.trParams({'value': ctr.fieldCategory.value.value.text == 'asset'
                            ? 'asset'.tr
                            : 'component'.tr}),
                        prefixIcon: const Icon(Icons.category_outlined, color: Color(0xFF3f87b9), size: 22,),
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
                      controller: ctr.fieldByCategory.value,
                    ),
                  ),
                  if(ctr.fieldCostByCategory.value.value.text != '')  Padding(
                    padding: const EdgeInsets.only(top: 14, left: 10, right: 10),
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: ctr.fieldCategory.value.value.text == 'asset'
                            ? 'cost_asset'.tr
                            : 'cost_component'.tr,
                        prefixIcon: const Icon(Icons.account_balance_wallet_outlined, color: Color(0xFF3f87b9), size: 22,),
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
                      controller: ctr.fieldCostByCategory.value,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 14, left: 10, right: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'period'.tr,
                        hintText: 'write_in_field'.trParams({'value': 'period'.tr}),
                        prefixIcon: const Icon(Icons.calculate_outlined, color: Color(0xFF3f87b9), size: 22,),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(top: 12, right: 14, bottom: 12),
                          child: Text('month'.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.grey),),
                        ),
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
                      keyboardType: TextInputType.number,
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'please_fill_in_@'.trParams({'value': 'period'.tr})
                          : null,
                      controller: ctr.fieldPeriod.value,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 14, left: 10, right: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: ctr.fieldMethod.value.value.text == 'decreasing_balance_method'.tr ? 'asset_value'.tr : 'depreciation_value'.tr,
                        hintText: 'write_in_field'.trParams({'value': 'asset_value'.tr}),
                        prefixIcon: const Icon(Icons.account_balance_wallet_outlined, color: Color(0xFF3f87b9), size: 22,),
                        suffixIcon: ctr.fieldMethod.value.value.text == 'decreasing_balance_method'.tr ? const Padding(
                          padding: EdgeInsets.only(top: 12, right: 14, bottom: 12),
                          child: Text('%',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),),
                        ) : null,
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
                      keyboardType: TextInputType.number,
                      inputFormatters: ctr.fieldMethod.value.value.text == 'decreasing_balance_method'.tr ? [
                        LengthLimitingTextInputFormatter(3),
                      ] : null,
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'please_in_field'.trParams({'value': 'asset_value'.tr})
                          : null,
                      controller: ctr.fieldValue.value,
                    ),
                  ),
                ],
              )
            )),
            Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.only(bottom: 40, top: 10, left: 10, right: 10),
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white
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
