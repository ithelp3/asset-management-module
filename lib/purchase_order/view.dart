import 'package:asset_management_module/component_widget/formates.dart';
import 'package:asset_management_module/purchase_order/add_items.dart';
import 'package:asset_management_module/purchase_order/form_po.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class PurchaseOrderPage extends StatelessWidget {
  const PurchaseOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PurchaseOrderController(),
      builder: (ctr) => Obx(() => Scaffold(
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
            onTap: (int idx) => ctr.update(),
            controller: ctr.tabController,
            dividerColor: Colors.grey.shade200,
            tabs: [
              Tab(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text('form_purchase'.tr),
                  )
              ),
              Tab(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('add_asset'.tr),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: ctr.tabController,
          children: [
            formPo(context, ctr),
            addItem(context, ctr)
          ]
        ),
        bottomSheet: ctr.tabController.index == 1 && ctr.items.isNotEmpty
            ? !ctr.showSetTaxDisc.value
              ? Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () => ctr.showModal(context, ctr),
              child: Container(
                padding: const EdgeInsets.only(left: 24, right: 18, top: 14, bottom: 14),
                decoration: BoxDecoration(
                  border: Border.symmetric(horizontal: BorderSide(color: Colors.blue.shade400)) ,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24)
                  ),
                  color: Colors.blue.shade50
                ),
                child: Row(
                  children: [
                    Expanded(child: Text('insert_the_discount_amount_and_tax_your_assets'.tr)),
                    const Icon(Icons.arrow_forward_ios_outlined, size: 18,)
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Table(
                      columnWidths: const {
                        0: FlexColumnWidth(0.3),
                        1: IntrinsicColumnWidth(),
                      },
                      children: [
                        {'label': 'Sub Total', 'value': ctr.subTotal.value},
                        {'label': 'discount'.tr, 'value': (ctr.subTotal.value * (ctr.discount.value/100))},
                        {'label': 'tax'.tr, 'value': (ctr.subTotal.value * (ctr.tax.value/100))},
                      ].map((i) {
                        double value = i['value'] as double;
                        return TableRow(
                          children: [
                            Text(i['label'].toString(), style: const TextStyle(height: 1.6),),
                            Text(value.toIdr(),
                              textAlign: TextAlign.right,
                              style: const TextStyle(height: 1.6),)
                          ]
                      );
                      }).toList(),
                    ),
                  ),
                  Divider(color: Colors.grey.shade200,),
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('total_payment'.tr,),
                        const VerticalDivider(width: 20,),
                        Text((ctr.subTotal.value-(ctr.subTotal.value*(ctr.discount.value/100))+((ctr.subTotal)*(ctr.tax/100))).toIdr())
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        )
        : null
            : null,
        bottomNavigationBar: !ctr.showSetTaxDisc.value ? Container(
          padding: const EdgeInsets.only(bottom: 20, top: 18, left: 10, right: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey.shade200)),
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
                if(ctr.tabController.index == 0){
                  if(ctr.formKey.value.currentState!.validate()) ctr.tabController.index = 1;
                }
                if(ctr.tabController.index == 1) ctr.save(context);
              },
              child: Text('save'.tr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
          ),
        ) : null,
      )),
    );
  }
}
