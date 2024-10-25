import 'package:asset_management_module/model/purchase_order_submission.dart';
import 'package:asset_management_module/submission/submission_details/view.dart';
import 'package:asset_management_module/utils/data/nav_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'controller.dart';

class MonitoringPage extends StatelessWidget {
  const MonitoringPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MonitoringController(),
      builder: (ctr) => Scaffold(
        appBar: AppBar(
          title: Text('monitoring'.tr),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios,
              color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,),
          ),
          centerTitle: true,
        ),
        body: ScrollConfiguration(
          behavior: const ScrollBehavior(),
          child: Obx(() => ListView.builder(
            itemCount: ctr.items.length,
            itemBuilder: (context, idx) {
              PurchaseOrderSubmission i = ctr.items[idx];
              MaterialColor colorStatus = Colors.brown;
              if(i.status == 'On Process') colorStatus = Colors.blue;
              if(i.status == 'Approved' || i.status == 'Complete') colorStatus = Colors.green;
              if(i.status == 'Rejected') colorStatus = Colors.red;
              return Container(
                margin: EdgeInsets.only(top: 8, left: 12, right: 12, bottom: idx+1 == ctr.items.length ? 20 : 0),
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
                        Icon(Icons.data_exploration,
                          color: Colors.yellow.shade700,
                          size: 36,
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
                          const Divider(height: 10,),
                          Table(
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
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(4)
                            ),
                            child: InkWell(
                              onTap: () => Get.to(const SubmissionDetailsPage(),
                                  arguments: {
                                    'data': i
                                  },
                                  routeName: 'purchase-order/details'
                              ),
                              child: Row(
                                children: [
                                  Expanded(child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('tracking'.tr, style: TextStyle(fontSize: 12, color: Colors.blue.shade400),),
                                      Text('submission_step_${i.step}'.tr, style: const TextStyle(fontSize: 12),)
                                    ],
                                  )),
                                  Icon(Icons.arrow_forward_ios_outlined, color: Colors.blue.shade400, size: 20,)
                                ],
                              ),
                            ),
                          ),
                          if(i.addedFromId != NavKey.user!.userId) if(i.step == 2 || i.step == 5) Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: () => ctr.reject(i),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          side: const BorderSide(color: Color(0xFF3f87b9)),
                                          borderRadius: BorderRadius.circular(8)
                                      ),
                                    ),
                                    child: Text('Rejected'.tr, style: const TextStyle(color: Color(0xFF3f87b9), fontWeight: FontWeight.bold),)
                                ),
                              ),
                              const VerticalDivider(width: 10,),
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: () => ctr.approve(i),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF3f87b9),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        padding: EdgeInsets.zero
                                    ),
                                    child: Text('yes,approved'.tr, style: const TextStyle(color: Colors.white),)
                                ),
                              ),
                            ],
                          ) else if(i.step == 3) SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () => ctr.findSupplier(i),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF3f87b9),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: EdgeInsets.zero
                                ),
                                child: Text('find_supplier'.tr, style: const TextStyle(color: Colors.white),)
                            ),
                          ) else if(i.step == 4) SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () => ctr.chooseApprovedSupplier(i),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF3f87b9),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: EdgeInsets.zero
                                ),
                                child: Text('choose_approved_supplier'.tr, style: const TextStyle(color: Colors.white),)
                            ),
                          ) else if(i.step == 6) SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () => ctr.createPurchaseOrder(i),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF3f87b9),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: EdgeInsets.zero
                                ),
                                child: Text('create_purchase_order'.tr, style: const TextStyle(color: Colors.white),)
                            ),
                          ) else if(i.step == 7) SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () => ctr.uploadInvoice(i),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF3f87b9),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: EdgeInsets.zero
                                ),
                                child: Text('upload_invoice'.tr, style: const TextStyle(color: Colors.white),)
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
          )),
        ),
      ),
    );
  }
}
