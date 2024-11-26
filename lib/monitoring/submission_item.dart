import 'package:asset_management_module/model/monitoring.dart';
import 'package:asset_management_module/model/permissions.dart';
import 'package:asset_management_module/monitoring/controller.dart';
import 'package:asset_management_module/submission/submission_details/view.dart';
import 'package:asset_management_module/utils/data/nav_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Widget submissionItem(BuildContext context, MonitoringController ctr) {
  Permission permission = NavKey.permissions!.firstWhere((i) => i.feature == "find-supplier", orElse: () => Permission());
  bool accessAdd = false;
  bool accessEdit = false;
  bool accessView = false;
  bool isAdministrator = NavKey.user?.administrator ?? false;
  if(permission.permissions?.isNotEmpty ?? false ) accessAdd = permission.permissions!.any((i) => i == 'add');
  if(permission.permissions?.isNotEmpty ?? false ) accessEdit = permission.permissions!.any((i) => i == 'edit');
  if(permission.permissions?.isNotEmpty ?? false ) accessView = permission.permissions!.any((i) => i == 'view');
  return ScrollConfiguration(
    behavior: const ScrollBehavior(),
    child: ListView.builder(
      itemCount:  ctr.itemSubmissions.length,
      itemBuilder: (context, idx) {
        Monitoring i = ctr.itemSubmissions[idx];
        MaterialColor colorStatus = Colors.brown;
        if(i.status == 'On Process') colorStatus = Colors.blue;
        if(i.status == 'Approved' || i.status == 'Complete') colorStatus = Colors.green;
        if(i.status == 'Rejected') colorStatus = Colors.red;
        return Container(
          margin: EdgeInsets.only(top: 8, left: 12, right: 12, bottom: idx+1 == ctr.itemSubmissions.length ? 20 : 0),
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
                        color: Colors.yellow.shade100
                    ),
                    child: Icon(Icons.data_exploration,
                      color: Colors.yellow.shade700,
                      size: 24,
                    ),
                  ),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('submission'.tr,
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
                              'id': i.id
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
                    if(i.addedFromId != NavKey.user!.userId)
                      if(i.step == 2 && NavKey.user!.approverLevel1!.contains(NavKey.user!.userId))  Row(
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
                    ) else if(i.step == 3 && (isAdministrator || accessAdd)) SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => ctr.findSupplier(i, 'add'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3f87b9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.zero
                          ),
                          child: Text('find_supplier'.tr, style: const TextStyle(color: Colors.white),)
                      ),
                    ) else if((i.step == 4 && NavKey.user!.approverLevel2!.contains(NavKey.user!.userId) ||
                        (i.step == 5 && NavKey.user!.approverLevel3!.contains(NavKey.user!.userId))) &&
                            i.status != 'Rejected' && (isAdministrator || accessView)) SizedBox(
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
                    ) else if((i.step == 4 || i.step == 5) && i.status == 'Rejected' && (isAdministrator || accessEdit)) SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () => ctr.findSupplier(i, 'edit'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.zero
                            ),
                            child: Text('resubmission'.tr, style: const TextStyle(color: Colors.white),)
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
                    ),
                    if(i.addedFromId == NavKey.user!.userId && i.status == 'Rejected')
                      if(i.step == 2) SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => ctr.resubmission(i),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.zero
                          ),
                          child: Text('resubmission'.tr, style: const TextStyle(color: Colors.white),)
                        ),
                      )
                  ],
                ),
              )
            ],
          ),
        );
      }
    ),
  );
}