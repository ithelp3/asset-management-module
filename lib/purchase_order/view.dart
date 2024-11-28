import 'package:asset_management_module/component_widget/scaffold_message.dart';
import 'package:asset_management_module/component_widget/skeleton_purchase_order.dart';
import 'package:asset_management_module/model/purchase.dart';
import 'package:asset_management_module/purchase_order/bottom_sheet.dart';
import 'package:asset_management_module/purchase_order/purchase_details/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
            onPressed: () => Get.back(result: true),
            icon: Icon(Icons.arrow_back_ios,
              color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,),
          ),
          centerTitle: true,
        ),
        body: ScrollConfiguration(
          behavior: const ScrollBehavior(),
          child: ctr.progress.value
            ? skeletonPurchaseItem()
            : ListView.builder(
              itemCount: ctr.purchases.length,
              itemBuilder: (ctx, idx) {
                Purchase i = ctr.purchases[idx];
                MaterialColor colorStatus = Colors.brown;
                if(i.status == 1) colorStatus = Colors.blue;
                if(i.status == 2) colorStatus = Colors.green;
                return Container(
                  margin: EdgeInsets.only(top: 8, left: 12, right: 12, bottom: idx+1 == ctr.purchases.length ? 20 : 0),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue.shade100),
                      boxShadow: [BoxShadow(
                        color: Colors.blue.withOpacity(0.1),
                        blurRadius: 2,
                        spreadRadius: 2,
                        offset: const Offset(1, 2),
                      )]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.orange.shade100
                            ),
                            child: Icon(Icons.assignment_rounded,
                              color: Colors.orange.shade700,
                              size: 24,
                            ),
                          ),
                          Expanded(child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(i.purchaseCode ?? '',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                                color: colorStatus.shade50,
                                borderRadius: BorderRadius.circular(4)
                            ),
                            child: Text(i.status == 1 ? 'un_paid'.tr : 'paid'.tr,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: colorStatus.shade700),),
                          ),
                        ],
                      ),
                      Divider(color: Colors.blue.shade100,),
                      Padding(
                        padding: const EdgeInsets.only(left: 2, bottom: 8, top: 8),
                        child: Table(
                          columnWidths: {
                            0: FlexColumnWidth((i.status == null) ? 1 : 1.2),
                            1: const FlexColumnWidth(0.1),
                            2: const FlexColumnWidth(2),
                          },
                          children: [
                            {'label': 'added_from'.tr, 'value': i.addedFromName ?? 'N/A'},
                            {'label': 'date_used'.tr, 'value': DateFormat('dd MMMM yyyy').format(DateFormat('yyyy-MM-dd').parse(i.date!))},
                            if(i.status != null) {'label': 'purchase_order'.tr, 'value': i.status! == 1 ? 'un_paid'.tr : 'paid'.tr},
                          ].map((i) => TableRow(
                              children: [
                                Text(i['label'].toString(), style : const TextStyle(fontSize: 12, height: 1.2)),
                                const Text(':', style: TextStyle(height: 1.2),),
                                Text((i['value'] ?? '') != '' ? i['value'].toString() : 'N/A',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(fontSize: 12, height: 1.2),
                                ),
                              ]
                          )).toList(),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if(i.status == 1) Flexible(
                            flex: 3,
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () => ctr.showModalUploadInvoice(i),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF3f87b9),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: EdgeInsets.zero
                                  ),
                                  child: Text('upload_invoice'.tr, style: const TextStyle(color: Colors.white),)
                              ),
                            ),
                          ),
                          if(i.status == 1) const VerticalDivider(width: 8,),
                          Flexible(
                            flex: 2,
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  // onPressed: () => Get.to(const PurchaseDetailsPage(),
                                  //     arguments: { 'findSupplierId': i.findSupplierId },
                                  //     routeName: '/purchase/details'
                                  // ),
                                  onPressed: () => scaffoldMessage(context, 'Coming soon..'),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF3f87b9),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: EdgeInsets.zero
                                  ),
                                  child: Text('details'.tr, style: const TextStyle(color: Colors.white),)
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }
          ),
        ),
        floatingActionButton: Visibility(
            visible: !(MediaQuery.of(context).viewInsets.bottom != 0),
            child: FloatingActionButton(
              onPressed: () => ctr.addPurchase(context),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)
              ),
              backgroundColor: const Color(0xFF3f87b9),
              child: const Icon(Icons.add, size: 34, color: Colors.white,),
            )
        ),
        bottomNavigationBar: ctr.showUploadInvoice.value ? Container(
          padding: const EdgeInsets.only(bottom: 20, top: 18, left: 10, right: 10),
          width: double.infinity,
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : const Color(0xFF272d34),
          child: ElevatedButton(
              onPressed: () => !ctr.showUploadInvoice.value
                  ? ctr.showUploadInvoice.value = !ctr.showUploadInvoice.value
                  : ctr.uploadInvoice(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3f87b9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 20),
              ),
              child: Text('upload'.tr,
                style: const TextStyle(color: Colors.white),)
          ),
        ) : null,
        bottomSheet: ctr.showUploadInvoice.value
            ? bottomSheet(context, ctr)
            : null,
      )),
    );
  }
}
