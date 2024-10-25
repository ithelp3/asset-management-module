import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class DialogPoAddItemPage extends StatelessWidget {
  const DialogPoAddItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DialogPoAddItemController(),
      builder: (ctr) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: SizedBox(
          height: 560,
          child: Column(
            children: [
              Expanded(child: Form(
                key: ctr.formKey.value,
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior(),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16, left: 14, right: 14),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'asset_name'.tr,
                            hintText: 'write_in_field'.trParams({'value': 'name_asset'.tr}),
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
                          controller: ctr.fieldName.value,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12, left: 14, right: 14),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'description'.tr,
                            hintText: 'write_in_field'.trParams({'value': 'description'.tr}),
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
                          maxLines: 8,
                          controller: ctr.fieldDesc.value,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12, left: 14, right: 14),
                        child: TextFormField(
                          readOnly: true,
                          onTap: () => ctr.selectedItem(context, 'brand'),
                          decoration: InputDecoration(
                            labelText: 'brand'.tr,
                            hintText: 'select_item_field'.trParams({'value': 'brand'.tr}),
                            prefixIcon: const Icon(Icons.discount_outlined, color: Color(0xFF3f87b9), size: 22,),
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
                              ? 'please_in_field'.trParams({'value': 'brand'.tr})
                              : null,
                          controller: ctr.fieldBrand.value,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12, left: 14, right: 14),
                        child: TextFormField(
                          readOnly: true,
                          onTap: () => ctr.selectedItem(context, 'subCategory'),
                          decoration: InputDecoration(
                            labelText: 'sub_category'.tr,
                            hintText: 'select_item_field'.trParams({'value': 'sub_category'.tr}),
                            prefixIcon: const Icon(Icons.category_outlined, color: Color(0xFF3f87b9), size: 22,),
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
                              ? 'please_in_field'.trParams({'value': 'sub_category'.tr})
                              : null,
                          controller: ctr.fieldSubCategory.value,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12, left: 14, right: 14),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'quantity'.tr,
                            hintText: 'write_in_field'.trParams({'value': 'quantity'.tr}),
                            prefixIcon: const Icon(Icons.web_stories_outlined, color: Color(0xFF3f87b9), size: 22,),
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
                              ? 'please_in_field'.trParams({'value': 'quantity'.tr})
                              : null,
                          controller: ctr.fieldQty.value,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12, left: 14, right: 14, bottom: 16),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'cost'.tr,
                            hintText: 'write_in_field'.trParams({'value': 'cost'.tr}),
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
                          validator: (value) => (value == null || value.isEmpty)
                              ? 'please_in_field'.trParams({'value': 'cost'.tr})
                              : null,
                          controller: ctr.fieldCost.value,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                )
              )),
              Padding(
                padding: const EdgeInsets.all(14),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        if(ctr.formKey.value.currentState!.validate()) ctr.added();
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
      )
    );
  }
}
