import 'package:asset_management_module/model/monitoring.dart';
import 'package:asset_management_module/monitoring/controller.dart';
import 'package:asset_management_module/purchase_order/purchase_details/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Widget purchaseItem(BuildContext context, MonitoringController ctr) {
  return ScrollConfiguration(
    behavior: const ScrollBehavior(),
    child: ListView.builder(
      itemCount: ctr.itemPurchases.length,
      itemBuilder: (ctx, idx) {
        Monitoring i = ctr.itemPurchases[idx];
        MaterialColor colorStatus = Colors.brown;
        if(i.status == 'un_paid') colorStatus = Colors.blue;
        if(i.status == 'paid') colorStatus = Colors.green;
        return Container(
          margin: EdgeInsets.only(top: 8, left: 12, right: 12, bottom: idx+1 == ctr.itemPurchases.length ? 20 : 0),
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
                        Text('purchase_order'.tr,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(i.submissionId ?? 'N/A', style: const TextStyle(fontSize: 12, color: Colors.grey),),
                      ],
                    ),
                  ),),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                        color: colorStatus.shade50,
                        borderRadius: BorderRadius.circular(4)
                    ),
                    child: Text(i.status?.tr ?? '',
                      style: TextStyle(
                          fontSize: 12,
                          color: colorStatus.shade700),),
                  ),
                ],
              ),
              Divider(color: Colors.blue.shade100,),
              Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HtmlWidget(i.submissionDetail ?? '',
                      textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8, top: 12),
                      child: Table(
                        columnWidths: {
                          0: FlexColumnWidth((i.purchaseStatus == null) ? 1 : 1.2),
                          1: const FlexColumnWidth(0.1),
                          2: const FlexColumnWidth(2),
                        },
                        children: [
                          {'label': 'added_from'.tr, 'value': i.username},
                          {'label': 'priority'.tr, 'value': i.priority},
                          {'label': 'date_used'.tr, 'value': DateFormat('dd MMMM yyyy').format(DateFormat('dd-MM-yyyy').parse(i.dateUsed!))},
                          if(i.purchaseStatus != null) {'label': 'purchase_order'.tr, 'value': i.purchaseStatus! == 1 ? 'un_paid'.tr : 'paid'.tr},
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
                    // if(i.status == 'un_paid')
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if(i.status == 'un_paid') Flexible(
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
                        if(i.status == 'un_paid') const VerticalDivider(width: 8,),
                        Flexible(
                          flex: 2,
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () => Get.to(const PurchaseDetailsPage(),
                                  arguments: { 'findSupplierId': i.findSupplierId },
                                  routeName: '/purchase/details'
                                ),
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
              )
            ],
          ),
        );
      }
    )
  );
}