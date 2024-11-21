import 'package:asset_management_module/component_widget/skeleton_monitoring.dart';
import 'package:asset_management_module/home/controller.dart';
import 'package:asset_management_module/model/monitoring.dart';
import 'package:asset_management_module/monitoring/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Widget dashboardMonitoring(BuildContext context, HomeController ctr) {
  return Column(
    children: [
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 14, top: 14),
        child: Text('monitoring'.tr,
          style: const TextStyle(fontSize: 20,),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 14,),
        child: Row(
          children: ['submission'.tr, 'purchase'.tr,
            // 'lending'.tr, 'maintenance'.tr,
          ].map((i) {
            return GestureDetector(
              onTap: () => ctr.selectedCapsule(i),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                margin: EdgeInsets.only(
                    left: i == 'all'.tr ? 14 : 8,
                    right: i == 'maintenance'.tr ? 14 : 0
                ),
                decoration: BoxDecoration(
                  color: ctr.capsule.value == i ? Colors.blue.shade100 : null,
                  borderRadius: BorderRadius.circular(16),
                  // border: Border.all(color: const Color(0xFF3f87b9))
                ),
                child: Text(i,
                  style: TextStyle(
                      color: ctr.capsule.value == i ? Colors.blue.shade700 : Colors.black,
                      fontWeight: ctr.capsule.value == i ? FontWeight.bold : FontWeight.normal
                  ),),
              ),
            );
          }).toList(),
        ),
      ),
      if(ctr.capsule.value == 'submission'.tr) Padding(
        padding: const EdgeInsets.only(top: 10, left: 14, right: 14, bottom: 10),
        child: ctr.progressDashboard.value
          ? skeletonMonitoringItemDashboard()
          : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: ctr.itemSubmission.length <= 10 ? ctr.itemSubmission.length : 10,
            itemBuilder: (ctx, idx) {
              Monitoring i = ctr.itemSubmission[idx];
              MaterialColor colorStatus = Colors.brown;
              if(i.status == 'On Process') colorStatus = Colors.blue;
              if(i.status == 'Approved' || i.status == 'Complete') colorStatus = Colors.green;
              if(i.status == 'Rejected') colorStatus = Colors.red;
              return Container(
                margin: const EdgeInsets.only(top: 8),
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
                child: InkWell(
                  onTap: () => ctr.selectItemMonitoring('submission', i),
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
                                Text(DateFormat('dd MMMM yyyy').format(DateFormat('dd-MM-yyyy').parse(i.dateUsed!)),
                                  style: const TextStyle(fontSize: 12, color: Colors.grey),
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
                        child: HtmlWidget(i.submissionDetail ?? '',
                          textStyle: const TextStyle(fontSize: 12),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
        ),
      ),
      if(ctr.capsule.value == 'purchase'.tr) Padding(
        padding: const EdgeInsets.only(top: 10, left: 14, right: 14, bottom: 10),
        child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: ctr.itemPurchases.length <= 10 ? ctr.itemPurchases.length : 10,
            itemBuilder: (ctx, idx) {
              Monitoring i = ctr.itemPurchases[idx];
              MaterialColor colorStatus = Colors.brown;
              if(i.status == 'un_paid') colorStatus = Colors.blue;
              if(i.status == 'paid') colorStatus = Colors.green;
              return Container(
                margin: const EdgeInsets.only(top: 8),
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
                child: InkWell(
                  onTap: () => ctr.selectItemMonitoring('purchase', i),
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
                                Text(DateFormat('dd MMMM yyyy').format(DateFormat('dd-MM-yyyy').parse(i.dateUsed!)),
                                  style: const TextStyle(fontSize: 12, color: Colors.grey),
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
                        child: HtmlWidget(i.submissionDetail ?? '',
                          textStyle: const TextStyle(fontSize: 12),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
        ),
      ),
      // if(ctr.capsule.value == 'lending'.tr) Padding(
      //   padding: const EdgeInsets.only(top: 10, left: 14, right: 14, bottom: 10),
      //   child: ListView.builder(
      //       shrinkWrap: true,
      //       physics: const NeverScrollableScrollPhysics(),
      //       itemCount: ctr.lendings.length,
      //       itemBuilder: (ctx, idx) {
      //         final i = ctr.lendings[idx];
      //         MaterialColor colorStatus = Colors.brown;
      //         // if(i.status == 'On Process') colorStatus = Colors.blue;
      //         // if(i.status == 'Approved' || i.status == 'Complete') colorStatus = Colors.green;
      //         // if(i.status == 'Rejected') colorStatus = Colors.red;
      //         return Container(
      //           margin: const EdgeInsets.only(top: 8),
      //           padding: const EdgeInsets.all(10),
      //           decoration: BoxDecoration(
      //               color: Colors.white,
      //               borderRadius: BorderRadius.circular(10),
      //               border: Border.all(color: Colors.blue.shade100),
      //               boxShadow: [BoxShadow(
      //                 color: Colors.blue.withOpacity(0.1),
      //                 blurRadius: 2,
      //                 spreadRadius: 2,
      //                 offset: const Offset(1, 2),
      //               )]
      //           ),
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Row(
      //                 children: [
      //                   Container(
      //                     padding: const EdgeInsets.all(6),
      //                     decoration: BoxDecoration(
      //                         borderRadius: BorderRadius.circular(40),
      //                         color: Colors.cyan.shade100
      //                     ),
      //                     child: const Icon(Icons.real_estate_agent_rounded,
      //                       color: Colors.cyan,
      //                       size: 24,
      //                     ),
      //                   ),
      //                   Expanded(child: Padding(
      //                     padding: const EdgeInsets.symmetric(horizontal: 10),
      //                     child: Column(
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         Text('lending'.tr,
      //                           style: const TextStyle(fontWeight: FontWeight.bold),
      //                         ),
      //                         Text(DateFormat('dd MMMM yyyy').format(DateTime.now()), style: const TextStyle(fontSize: 12, color: Colors.grey),),
      //                       ],
      //                     ),
      //                   ),),
      //                   Container(
      //                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      //                     decoration: BoxDecoration(
      //                         color: colorStatus.shade50,
      //                         borderRadius: BorderRadius.circular(4)
      //                     ),
      //                     child: Text('On Process'.tr,
      //                       style: TextStyle(
      //                           fontSize: 12,
      //                           color: colorStatus.shade700),),
      //                   ),
      //                 ],
      //               ),
      //               Divider(color: Colors.blue.shade100,),
      //               Padding(
      //                 padding: const EdgeInsets.only(left: 2),
      //                 child: HtmlWidget('$i alat kantor',
      //                   textStyle: const TextStyle(fontSize: 12),
      //                 ),
      //               )
      //             ],
      //           ),
      //         );
      //       }
      //   ),
      // ),
      // if(ctr.capsule.value == 'maintenance'.tr) Padding(
      //   padding: const EdgeInsets.only(top: 10, left: 14, right: 14, bottom: 10),
      //   child: ListView.builder(
      //       shrinkWrap: true,
      //       physics: const NeverScrollableScrollPhysics(),
      //       itemCount: ctr.maintenances.length,
      //       itemBuilder: (ctx, idx) {
      //         final i = ctr.maintenances[idx];
      //         MaterialColor colorStatus = Colors.brown;
      //         // if(i.status == 'On Process') colorStatus = Colors.blue;
      //         // if(i.status == 'Approved' || i.status == 'Complete') colorStatus = Colors.green;
      //         // if(i.status == 'Rejected') colorStatus = Colors.red;
      //         return Container(
      //           margin: const EdgeInsets.only(top: 8),
      //           padding: const EdgeInsets.all(10),
      //           decoration: BoxDecoration(
      //               color: Colors.white,
      //               borderRadius: BorderRadius.circular(10),
      //               border: Border.all(color: Colors.blue.shade100),
      //               boxShadow: [BoxShadow(
      //                 color: Colors.blue.withOpacity(0.1),
      //                 blurRadius: 2,
      //                 spreadRadius: 2,
      //                 offset: const Offset(1, 2),
      //               )]
      //           ),
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Row(
      //                 children: [
      //                   Container(
      //                     padding: const EdgeInsets.all(6),
      //                     decoration: BoxDecoration(
      //                         borderRadius: BorderRadius.circular(40),
      //                         color: Colors.indigo.shade100
      //                     ),
      //                     child: const Icon(Icons.construction_outlined,
      //                       color: Colors.indigo,
      //                       size: 24,
      //                     ),
      //                   ),
      //                   Expanded(child: Padding(
      //                     padding: const EdgeInsets.symmetric(horizontal: 10),
      //                     child: Column(
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         Text('maintenance'.tr,
      //                           style: const TextStyle(fontWeight: FontWeight.bold),
      //                         ),
      //                         Text(DateFormat('dd MMMM yyyy').format(DateTime.now()), style: const TextStyle(fontSize: 12, color: Colors.grey),),
      //                       ],
      //                     ),
      //                   ),),
      //                   Container(
      //                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      //                     decoration: BoxDecoration(
      //                         color: colorStatus.shade50,
      //                         borderRadius: BorderRadius.circular(4)
      //                     ),
      //                     child: Text('On Process'.tr,
      //                       style: TextStyle(
      //                           fontSize: 12,
      //                           color: colorStatus.shade700),),
      //                   ),
      //                 ],
      //               ),
      //               Divider(color: Colors.blue.shade100,),
      //               Padding(
      //                 padding: const EdgeInsets.only(left: 2),
      //                 child: HtmlWidget('$i alat kantor',
      //                   textStyle: const TextStyle(fontSize: 12),
      //                 ),
      //               )
      //             ],
      //           ),
      //         );
      //       }
      //   ),
      // ),
      if(ctr.progressDashboard.value) Container(color: Colors.transparent,)
      else if((ctr.capsule.value == 'purchase'.tr && ctr.itemPurchases.isNotEmpty) ||
          (ctr.capsule.value == 'submission'.tr && ctr.itemSubmission.isNotEmpty) ||
          (ctr.capsule.value == 'lending'.tr && ctr.lendings.isNotEmpty) ||
          (ctr.capsule.value == 'maintenance'.tr && ctr.maintenances.isNotEmpty)) Padding(
        padding: const EdgeInsets.only(left: 14, right: 14, bottom: 20),
        child: TextButton(
            onPressed: () {
              Get.to(const MonitoringPage(),
                  arguments: { 'type': ctr.capsule.value },
                  routeName: '/monitoring'
              );
            },
            child: Text('see_all_monitoring_lists'.tr)
        ),
      ) else Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/4, top: 40),
        child: Column(
            children: [
              const Icon(Icons.folder_off_outlined, size: 60, color: Color(0xFF3f87b9),),
              const Divider(height: 10,),
              Text('no_data_available'.tr,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF3f87b9)),)
            ]
        ),
      )
    ],
  );
}