import 'package:asset_management_module/component_widget/skeleton_purchase_order.dart';
import 'package:asset_management_module/purchase_order/add_edit_purchase/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

formPo(BuildContext context, AddEditPurchaseController ctr) {
  return !ctr.progress.value ? Form(
      key: ctr.formKey.value,
      child:Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 10, right: 10),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Subject'.tr,
                hintText: 'write_in_field'.trParams({'value': 'Subject'.tr}),
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
                  ? 'please_in_field'.trParams({'value': 'Subject'.tr})
                  : null,
              controller: ctr.fieldSubject.value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 10, right: 10),
            child: TextFormField(
              readOnly: true,
              enabled: (ctr.type.value != 'submission'),
              onTap: () => ctr.selectSupplier(context),
              decoration: InputDecoration(
                labelText: 'supplier'.tr,
                hintText: 'select_item_field'.trParams({'value': 'supplier'.tr}),
                prefixIcon: const Icon(Icons.local_grocery_store_outlined, color: Color(0xFF3f87b9), size: 22,),
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
                  ? 'please_in_field'.trParams({'value': 'supplier'.tr})
                  : null,
              controller: ctr.fieldSupplier.value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 10, right: 10),
            child: TextFormField(
              readOnly: true,
              onTap: () => ctr.selectDate(context),
              decoration: InputDecoration(
                labelText: 'purchase_date'.tr,
                hintText: 'select_item_field'.trParams({'value': 'purchase_date'.tr}),
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
                  ? 'please_in_field'.trParams({'value': 'purchase_date'.tr})
                  : null,
              controller: ctr.fieldPoDate.value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 10, right: 10),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'notes'.tr,
                hintText: 'write_in_field'.trParams({'value': 'notes'.tr}),
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
              validator: (value) => (value == null || value.isEmpty)
                  ? 'please_in_field'.trParams({'value': 'notes'.tr})
                  : null,
              controller: ctr.fieldNotes.value,
            ),
          ),
        ],
      )
  ) : skeletonForm();
}