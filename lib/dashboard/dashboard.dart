import 'package:asset_management_module/home/controller.dart';
import 'package:asset_management_module/model/purchase_order_submission.dart';
import 'package:asset_management_module/monitoring/view.dart';
import 'package:asset_management_module/submission/submission_details/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'dart:js' as js;

@override
Widget dashboard(BuildContext context, HomeController ctr) {
  return Scaffold(
    key: const ValueKey(0),
    appBar: AppBar(
      title: Text('asset_management'.tr,
        style: const TextStyle(fontSize: 18,),
      ),
      centerTitle: true,
      leading: GestureDetector(
          onTap: () {
            // js.context.callMethod('backToMainApp');
          },
          child: const Icon(Icons.arrow_back_ios, color: Colors.black,)),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Container(
          height: 56,
          color: const Color(0xFF3f87b9),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Icon(Icons.home_work_outlined, color: Colors.white, size: 26,),
              ),
              Expanded(
                child: Text(ctr.user.company ?? '',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
              ),
            ],
          ),
        )
      ),
    ),
    body:  Obx(() =>
      //   NotificationListener<OverscrollIndicatorNotification>(
      // onNotification: (OverscrollIndicatorNotification overscroll) => overscroll.disallowIndicator() as dynamic,
      // child:
      ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 14, top: 14),
              child: Text('menu'.tr,
                // textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 20,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                crossAxisCount: 4,
                childAspectRatio: 1,
                children: [
                  {'label': 'purchase_order'.tr, 'icon': Icons.assignment_rounded},
                  {'label': 'lending'.tr, 'icon': Icons.real_estate_agent_rounded},
                  {'label': 'maintenance'.tr, 'icon': Icons.construction_outlined},
                  // {'label': 'reminder'.tr, 'icon': Icons.notifications_active_outlined},
                  {'label': 'component'.tr, 'icon': Icons.interests_outlined},
                  {'label': 'submission'.tr, 'icon': Icons.data_exploration},
                  {'label': 'staff'.tr, 'icon': Icons.supervisor_account_sharp},
                  {'label': 'supplier'.tr, 'icon': Icons.trolley},
                  {'label': 'brand'.tr, 'icon': Icons.discount},
                  // {'label': 'location'.tr, 'icon': Icons.location_on},
                  // {'label': 'Q/A'.tr, 'icon': Icons.chat_outlined},
                ].map((i) {
                  IconData icon = i['icon'] as IconData;
                  String label = i['label'].toString();
                  return GestureDetector(
                    onTap: () => ctr.selectItemIcon(context, label),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [BoxShadow(
                                    color: Colors.blue.withOpacity(0.1),
                                    blurRadius: 2,
                                    spreadRadius: 2,
                                    offset: const Offset(1, 4),
                                  )]
                              ),
                              child: Icon(icon, size: 36, color: const Color(0xFF3f87b9),)),
                          Text(label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 14, left: 14, right: 14),
            //   child: GridView.count(
            //     shrinkWrap: true,
            //     physics: const NeverScrollableScrollPhysics(),
            //     crossAxisSpacing: 10,
            //     mainAxisSpacing: 10,
            //     crossAxisCount: 2,
            //     childAspectRatio: 2.2,
            //     children: [
            //       {'label': 'total_asset'.tr, 'value': ctr.totalAsset, 'color': const Color(0XFFFDDA5E)},
            //       {'label': 'total_component'.tr, 'value': ctr.totalComponent, 'color': const Color(0XFF81E6EF)},
            //       {'label': 'total_maintenance'.tr, 'value': ctr.totalMaintenance, 'color': const Color(0XFF79C7F2)},
            //       {'label': 'total_staff'.tr, 'value': ctr.totalEmployee, 'color': const Color(0XFF91B4F8)},
            //     ].map((i) => GestureDetector(
            //       onTap: () {
            //         if(i['label'] == 'total_asset'.tr) ctr.selectNavbarBottomIdx(1);
            //         if(i['label'] == 'total_component'.tr) {
            //           Get.to(const ComponentPage(),
            //               routeName: '/component/list',
            //               transition: Transition.rightToLeft
            //           );
            //         }
            //         if(i['label'] == 'total_maintenance'.tr) {
            //           Get.to(const MaintenancePage(),
            //               routeName: '/maintenance/list',
            //               transition: Transition.rightToLeft
            //           );
            //         }
            //         if(i['label'] == 'total_staff'.tr) {
            //           Get.to(const StaffPage(),
            //               routeName: '/staff/list',
            //               transition: Transition.rightToLeft
            //           );
            //         }
            //       },
            //       child: Container(
            //         height: 20,
            //         decoration: BoxDecoration(
            //           color: i['color'] as Color,
            //           borderRadius: BorderRadius.circular(8),
            //         ),
            //         child: Column(
            //           children: [
            //             Padding(
            //               padding: const EdgeInsets.symmetric(vertical: 6),
            //               child: Text(i['label'].toString(),
            //                 style: TextStyle(
            //                     fontWeight: FontWeight.bold,
            //                     fontSize: 15,
            //                     color: Theme.of(context).brightness == Brightness.light
            //                         ? Colors.white
            //                         : const Color(0xFF272d34)
            //                 ),),
            //             ),
            //             Expanded(
            //               child: Container(
            //                   margin: const EdgeInsets.only(bottom: 2, left: 2, right: 2),
            //                   width: double.infinity,
            //                   alignment: Alignment.center,
            //                   decoration: BoxDecoration(
            //                       color: Theme.of(context).brightness == Brightness.light
            //                           ? Colors.white
            //                           : const Color(0xFF272d34),
            //                       borderRadius: const BorderRadius.only(
            //                         bottomLeft: Radius.circular(6),
            //                         bottomRight: Radius.circular(6),
            //                       )
            //                   ),
            //                   child: Text(i['value'].toString(), style: const TextStyle(fontSize: 24),)
            //               ),
            //             )
            //           ],
            //         ),
            //       ),
            //     )).toList(),
            //   ),
            // ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 14, top: 14),
              child: Text('monitoring'.tr,
                style: const TextStyle(fontSize: 20,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14,),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ['all'.tr, 'purchase_order'.tr, 'lending'.tr, 'maintenance'.tr,
                    // 'submission'.tr,
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
            ),
            if(ctr.capsule.value == 'all'.tr) Padding(
              padding: const EdgeInsets.only(top: 10, left: 14, right: 14, bottom: 10),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ctr.allMonitoring.length,
                itemBuilder: (ctx, idx) {
                  PurchaseOrderSubmission i = ctr.allMonitoring[idx];
                  MaterialColor colorStatus = Colors.brown;
                  if(i.status == 'On Process') colorStatus = Colors.blue;
                  if(i.status == 'Approved' || i.status == 'Complete') colorStatus = Colors.green;
                  if(i.status == 'Rejected') colorStatus = Colors.red;

                  String label = 'purchase_order'.tr;
                  IconData icon = Icons.data_exploration;
                  MaterialColor colorIcon = Colors.yellow;
                  if(i.subject! == 'maintenance') {
                    label = 'maintenance'.tr;
                    icon = Icons.construction_outlined;
                    colorIcon = Colors.indigo;
                  }
                  if(i.subject! == 'peminjaman') {
                    label = 'lending'.tr;
                    icon = Icons.real_estate_agent_rounded;
                    colorIcon = Colors.cyan;
                  }
                  return InkWell(
                    onTap: () => ctr.selectItemMonitoring(label, i),
                    child: Container(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: colorIcon.shade100
                                ),
                                child: Icon(icon,
                                  color: colorIcon.shade700,
                                  size: 24,
                                ),
                              ),
                              Expanded(child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text('purchase_order'.tr,
                                    Text(label,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    // Text(DateFormat('dd MMMM yyyy').format(DateFormat('dd-MM-yyyy').parse(i.dateUsed!)),
                                    Text( label == 'purchase_order'.tr
                                        ? DateFormat('dd MMMM yyyy').format(DateFormat('dd-MM-yyyy').parse(i.dateUsed!))
                                        : DateFormat('dd MMMM yyyy').format(DateTime.now()),
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
            if(ctr.itemPO.isNotEmpty && ctr.capsule.value == 'purchase_order'.tr) Padding(
              padding: const EdgeInsets.only(top: 10, left: 14, right: 14, bottom: 10),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ctr.itemPO.length <= 10 ? ctr.itemPO.length : 10,
                itemBuilder: (ctx, idx) {
                  PurchaseOrderSubmission i = ctr.itemPO[idx];
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
                      onTap: () => Get.to(const SubmissionDetailsPage(),
                        arguments: {
                          'data': i
                        },
                        routeName: 'submission/details'
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
            if(ctr.capsule.value == 'lending'.tr) Padding(
              padding: const EdgeInsets.only(top: 10, left: 14, right: 14, bottom: 10),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: ctr.lendings.length,
                  itemBuilder: (ctx, idx) {
                    final i = ctr.lendings[idx];
                    MaterialColor colorStatus = Colors.brown;
                    // if(i.status == 'On Process') colorStatus = Colors.blue;
                    // if(i.status == 'Approved' || i.status == 'Complete') colorStatus = Colors.green;
                    // if(i.status == 'Rejected') colorStatus = Colors.red;
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: Colors.cyan.shade100
                                ),
                                child: const Icon(Icons.real_estate_agent_rounded,
                                  color: Colors.cyan,
                                  size: 24,
                                ),
                              ),
                              Expanded(child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('lending'.tr,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(DateFormat('dd MMMM yyyy').format(DateTime.now()), style: const TextStyle(fontSize: 12, color: Colors.grey),),
                                  ],
                                ),
                              ),),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                    color: colorStatus.shade50,
                                    borderRadius: BorderRadius.circular(4)
                                ),
                                child: Text('On Process'.tr,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: colorStatus.shade700),),
                              ),
                            ],
                          ),
                          Divider(color: Colors.blue.shade100,),
                          Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: HtmlWidget('$i alat kantor',
                              textStyle: const TextStyle(fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    );
                  }
              ),
            ),
            if(ctr.capsule.value == 'maintenance'.tr) Padding(
              padding: const EdgeInsets.only(top: 10, left: 14, right: 14, bottom: 10),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: ctr.maintenances.length,
                  itemBuilder: (ctx, idx) {
                    final i = ctr.maintenances[idx];
                    MaterialColor colorStatus = Colors.brown;
                    // if(i.status == 'On Process') colorStatus = Colors.blue;
                    // if(i.status == 'Approved' || i.status == 'Complete') colorStatus = Colors.green;
                    // if(i.status == 'Rejected') colorStatus = Colors.red;
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.indigo.shade100
                                ),
                                child: const Icon(Icons.construction_outlined,
                                  color: Colors.indigo,
                                  size: 24,
                                ),
                              ),
                              Expanded(child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('maintenance'.tr,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(DateFormat('dd MMMM yyyy').format(DateTime.now()), style: const TextStyle(fontSize: 12, color: Colors.grey),),
                                  ],
                                ),
                              ),),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                    color: colorStatus.shade50,
                                    borderRadius: BorderRadius.circular(4)
                                ),
                                child: Text('On Process'.tr,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: colorStatus.shade700),),
                              ),
                            ],
                          ),
                          Divider(color: Colors.blue.shade100,),
                          Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: HtmlWidget('$i alat kantor',
                              textStyle: const TextStyle(fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    );
                  }
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14, right: 14, bottom: 20),
              child: TextButton(
                onPressed: () {
                  Get.to(const MonitoringPage(),
                    routeName: '/monitoring'
                  );
                },
                child: Text('see_all_monitoring_lists'.tr)
              ),
            )
            // Column(
            //   children: [
            //     if(!ctr.progressDashboard.value) Container(
            //         margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
            //         height: ctr.expandAC.value ? 260 : 64,
            //         child: Card(
            //           child: Column(
            //             children: [
            //               Padding(
            //                 padding: const EdgeInsets.all(10),
            //                 child: Row(
            //                   children: [
            //                     Expanded(
            //                       child: Text('asset_by_category'.tr,
            //                         style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
            //                     ),
            //                     GestureDetector(
            //                         onTap: () => ctr.expandPie('ac'),
            //                         child: Icon((ctr.expandAC.value) ? Icons.expand_less_outlined : Icons.expand_more_outlined,
            //                           size: 36,)
            //                     )
            //                   ],
            //                 ),
            //               ),
            //               if(ctr.expandAC.value) Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 0),
            //                 child: PieChart(
            //                   dataMap: {
            //                     for(final item in ctr.pieChartAssetByCategory)
            //                       item.name?.toString() ?? 'N/A': ((double.tryParse(item.total.toString()) ?? 0)/ctr.totalAsset.toDouble())*100,
            //                   },
            //                   colorList: const [
            //                     Color(0XFF3F87B9),
            //                     Color(0XFF75B7EC),
            //                     Color(0XFFFDC543),
            //                     Color(0XFFE08241),
            //                   ],
            //                   chartLegendSpacing: 20,
            //                   chartValuesOptions: const ChartValuesOptions(
            //                       chartValueStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            //                       decimalPlaces: 2,
            //                       showChartValueBackground: false,
            //                       showChartValuesInPercentage: true
            //                   ),
            //                   chartRadius: MediaQuery.of(context).size.width/2.4,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         )
            //     ) else skeletonPie(),
            //     if(!ctr.progressDashboard.value) Container(
            //         margin: const EdgeInsets.all(10),
            //         height: ctr.expandAS.value ? 260 : 64,
            //         alignment: Alignment.centerLeft,
            //         child: Card(
            //           child: Column(
            //             children: [
            //               Padding(
            //                 padding: const EdgeInsets.all(10),
            //                 child: Row(
            //                   children: [
            //                     Expanded(
            //                       child: Text('asset_by_status'.tr,
            //                         style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
            //                     ),
            //                     GestureDetector(
            //                         onTap: () => ctr.expandPie('as'),
            //                         child: Icon((ctr.expandAS.value) ? Icons.expand_less_outlined : Icons.expand_more_outlined,
            //                           size: 36,)
            //                     )
            //                   ],
            //                 ),
            //               ),
            //               if(ctr.expandAS.value) PieChart(
            //                 dataMap: {
            //                   for(final item in ctr.pieChartAssetByStatus)
            //                     item.name?.toString() ?? 'N/A': ((double.tryParse(item.total.toString()) ?? 0)/ctr.totalAsset.toDouble())*100,
            //                 },
            //                 colorList: const [
            //                   Color(0XFF3F87B9),
            //                   Color(0XFF75B7EC),
            //                   Color(0XFFFDC543),
            //                   Color(0XFFE08241),
            //                 ],
            //                 chartLegendSpacing: 20,
            //                 chartValuesOptions: const ChartValuesOptions(
            //                     chartValueStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            //                     decimalPlaces: 2,
            //                     showChartValueBackground: false,
            //                     showChartValuesInPercentage: true
            //                 ),
            //                 chartRadius: MediaQuery.of(context).size.width/2.4,
            //
            //               ),
            //             ],
            //           ),
            //         )
            //     ) else skeletonPie(),
            //     // Card(
            //     //   margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            //     //   color: Colors.white,
            //     //   child: Column(
            //     //     crossAxisAlignment: CrossAxisAlignment.start,
            //     //     children: [
            //     //       Padding(
            //     //         padding: const EdgeInsets.all(10),
            //     //         child: Text('submission'.tr,
            //     //           textAlign: TextAlign.start,
            //     //           style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            //     //       ),
            //     //       if(ctr.submission.isNotEmpty) Padding(
            //     //         padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            //     //         child: Table(
            //     //           columnWidths: const {
            //     //             0: FlexColumnWidth(1),
            //     //             1: FlexColumnWidth(0.5),
            //     //             2: FlexColumnWidth(0.5),
            //     //           },
            //     //           border: TableBorder(
            //     //             horizontalInside: BorderSide(color: Colors.grey.shade200),
            //     //             // bottom:
            //     //           ),
            //     //           children: [
            //     //             TableRow(
            //     //               children: [
            //     //                 Text('asset'.tr,
            //     //                     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            //     //                 Text('priority'.tr,
            //     //                     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            //     //                 Text('date'.tr,
            //     //                   textAlign: TextAlign.center,
            //     //                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
            //     //               ]
            //     //             ),
            //     //             ...ctr.submission.map((item) => TableRow(
            //     //               children: [
            //     //                 Padding(
            //     //                   padding: const EdgeInsets.symmetric(vertical: 2),
            //     //                   child: Text(item.name ?? '-',
            //     //                       style: const TextStyle(fontSize: 13)),
            //     //                 ),
            //     //                 Container(
            //     //                   alignment: Alignment.center,
            //     //                   margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
            //     //                   decoration: BoxDecoration(
            //     //                       color: const Color(0xFF3f87b9),
            //     //                       borderRadius: BorderRadius.circular(4)
            //     //                   ),
            //     //                   child: Text(item.description ?? '-',
            //     //                       style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold)),
            //     //                 ),
            //     //                 Padding(
            //     //                   padding: const EdgeInsets.symmetric(vertical: 2),
            //     //                   child: Text(item.date ?? '-',
            //     //                     textAlign: TextAlign.right,
            //     //                     style: const TextStyle(fontSize: 13)),
            //     //                 ),
            //     //               ]
            //     //             ))
            //     //           ],
            //     //         ),
            //     //       ) else Row(
            //     //         mainAxisAlignment: MainAxisAlignment.center,
            //     //         children: [
            //     //           Padding(
            //     //             padding: const EdgeInsets.only(bottom: 14),
            //     //             child: Column(
            //     //               children: [
            //     //                 const Icon(Icons.folder_off_outlined, color: Color(0xFF3f87b9), size: 50,),
            //     //                 const Divider(height: 10,),
            //     //                 Text('no_data_available'.tr)
            //     //               ],
            //     //             ),
            //     //           ),
            //     //         ],
            //     //       ),
            //     //     ],
            //     //   )
            //     // ),
            //     Card(
            //         margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Padding(
            //               padding: const EdgeInsets.all(10),
            //               child: Text('recent_asset_activity'.tr,
            //                 textAlign: TextAlign.start,
            //                 style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            //             ),
            //             if(ctr.recentAssets.isNotEmpty) Padding(
            //               padding: const EdgeInsets.only(bottom: 10),
            //               child: Table(
            //                 columnWidths: const {
            //                   0: FlexColumnWidth(1),
            //                   1: FlexColumnWidth(0.5),
            //                   2: FlexColumnWidth(0.5),
            //                 },
            //                 border: TableBorder(
            //                   horizontalInside: BorderSide(color: Colors.grey.shade200),
            //                   // bottom:
            //                 ),
            //                 children: [
            //                   TableRow(
            //                       children: [
            //                         Padding(
            //                           padding: const EdgeInsets.symmetric(horizontal: 10),
            //                           child: Text('asset'.tr,
            //                               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            //                         ),
            //                         Padding(
            //                           padding: const EdgeInsets.symmetric(horizontal: 10),
            //                           child: Text('status'.tr,
            //                               textAlign: TextAlign.center,
            //                               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            //                         ),
            //                         Padding(
            //                           padding: const EdgeInsets.symmetric(horizontal: 10),
            //                           child: Text('date'.tr,
            //                             textAlign: TextAlign.center,
            //                             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
            //                         ),
            //                       ]
            //                   ),
            //                   ...ctr.recentAssets.map((item) => TableRow(
            //                       children: [
            //                         Padding(
            //                           padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 8),
            //                           child: Text(item.asset ?? '-',
            //                               style: const TextStyle(fontSize: 13)),
            //                         ),
            //                         Container(
            //                           alignment: Alignment.center,
            //                           margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            //                           decoration: BoxDecoration(
            //                               color: const Color(0xFF3f87b9),
            //                               borderRadius: BorderRadius.circular(4)
            //                           ),
            //                           child: Text(item.statusName ?? '-',
            //                               style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold)),
            //                         ),
            //                         Padding(
            //                           padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            //                           child: Text(item.date ?? '-',
            //                               textAlign: TextAlign.right,
            //                               style: const TextStyle(fontSize: 13)),
            //                         ),
            //                       ]
            //                   ))
            //                 ],
            //               ),
            //             ) else Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Padding(
            //                   padding: const EdgeInsets.only(bottom: 14),
            //                   child: Column(
            //                     children: [
            //                       const Icon(Icons.folder_off_outlined, color: Color(0xFF3f87b9), size: 50,),
            //                       const Divider(height: 10,),
            //                       Text('no_data_available'.tr)
            //                     ],
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         )
            //     ),
            //     Card(
            //         margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            //         // color: Colors.white,
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Padding(
            //               padding: const EdgeInsets.all(10),
            //               child: Text('recent_component_activity'.tr,
            //                 textAlign: TextAlign.start,
            //                 style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            //             ),
            //             if(ctr.recentComponents.isNotEmpty) Padding(
            //               padding: const EdgeInsets.only(bottom: 10),
            //               child: Table(
            //                 columnWidths: const {
            //                   0: FlexColumnWidth(1),
            //                   1: FlexColumnWidth(0.5),
            //                   2: FlexColumnWidth(0.5),
            //                 },
            //                 border: TableBorder(
            //                   horizontalInside: BorderSide(color: Colors.grey.shade200),
            //                   // bottom:
            //                 ),
            //                 children: [
            //                   TableRow(
            //                       children: [
            //                         Padding(
            //                           padding: const EdgeInsets.symmetric(horizontal: 10),
            //                           child: Text('asset'.tr,
            //                               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            //                         ),
            //                         Padding(
            //                           padding: const EdgeInsets.symmetric(horizontal: 10),
            //                           child: Text('status'.tr,
            //                               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            //                         ),
            //                         Padding(
            //                           padding: const EdgeInsets.symmetric(horizontal: 10),
            //                           child: Text('date'.tr,
            //                             textAlign: TextAlign.center,
            //                             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
            //                         ),
            //                       ]
            //                   ),
            //                   ...ctr.recentComponents.map((item) => TableRow(
            //                       children: [
            //                         Padding(
            //                           padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            //                           child: Text(item.component ?? '-',
            //                               style: const TextStyle(fontSize: 13)),
            //                         ),
            //                         Container(
            //                           alignment: Alignment.center,
            //                           margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
            //                           decoration: BoxDecoration(
            //                               color: const Color(0xFF3f87b9),
            //                               borderRadius: BorderRadius.circular(4)
            //                           ),
            //                           child: Text(item.statusName ?? '-',
            //                               style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold)),
            //                         ),
            //                         Padding(
            //                           padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            //                           child: Text(item.date ?? '-',
            //                               textAlign: TextAlign.right,
            //                               style: const TextStyle(fontSize: 13)),
            //                         ),
            //                       ]
            //                   ))
            //                 ],
            //               ),
            //             ) else Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Padding(
            //                   padding: const EdgeInsets.only(bottom: 14),
            //                   child: Column(
            //                     children: [
            //                       const Icon(Icons.folder_off_outlined, color: Color(0xFF3f87b9), size: 50,),
            //                       const Divider(height: 10,),
            //                       Text('no_data_available'.tr)
            //                     ],
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         )
            //     ),
            //   ],
            // ),
          ],
        ),
      // )
    ))
  );
}