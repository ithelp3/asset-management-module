import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class PurchaseOrderPage extends StatelessWidget {
  const PurchaseOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PurchaseOrderController(),
      builder: (ctr) => Scaffold(
        appBar: AppBar(
          title: Text('purchase_order'.tr),
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : const Color(0xFF272d34),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios,
              color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,),
          ),
          centerTitle: true,
          bottom: TabBar(
            controller: ctr.tabController,
            dividerColor: Colors.grey.shade200,
            tabs: [
              Tab(
                text: 'Lengkapi Data'.tr,
              ),
              Tab(
                text: 'Tambah Aset'.tr,
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: ctr.tabController,
          children: [
            Form(
              key: ctr.formKey.value,
              child:Column(
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
                      onTap: () => ctr.selectDate(context),
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
                      decoration: InputDecoration(
                        labelText: 'priority'.tr,
                        hintText: 'write_in_field'.trParams({'value': 'priority'.tr}),
                        prefixIcon: const Icon(Icons.priority_high_outlined, color: Color(0xFF3f87b9), size: 22,),
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
            Container(
              alignment: Alignment.center,
              child: Text('Tambah asset'),
            )
          ]
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(bottom: 30, top: 10, left: 10, right: 10),
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
              onPressed: () {},
              child: Text('next'.tr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
          ),
        ),
      ),
    );
  }
}
