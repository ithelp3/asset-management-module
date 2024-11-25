import 'package:asset_management_module/component_widget/skeleton_monitoring.dart';
import 'package:asset_management_module/home/controller.dart';
import 'package:asset_management_module/model/recent_asset.dart';
import 'package:asset_management_module/model/recent_component.dart';
import 'package:asset_management_module/monitoring/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Widget dashboardRecent(BuildContext context, HomeController ctr) {
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
          children: ['recent_assets'.tr, 'recent_components'.tr,
            // 'lending'.tr, 'maintenance'.tr,
          ].map((i) {
            return GestureDetector(
              onTap: () => ctr.selectedCapsule(i),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                margin: EdgeInsets.only(left: 8,),
                decoration: BoxDecoration(
                  color: ctr.filterRecent.value == i ? Colors.blue.shade100 : null,
                  borderRadius: BorderRadius.circular(16),
                  // border: Border.all(color: const Color(0xFF3f87b9))
                ),
                child: Text(i,
                  style: TextStyle(
                      color: ctr.filterRecent.value == i ? Colors.blue.shade700 : Colors.black,
                      fontWeight: ctr.filterRecent.value == i ? FontWeight.bold : FontWeight.normal
                  ),),
              ),
            );
          }).toList(),
        ),
      ),
      if(ctr.filterRecent.value == 'recent_assets'.tr) Padding(
        padding: const EdgeInsets.only(top: 10, left: 14, right: 14, bottom: 10),
        child: ctr.progressDashboard.value
            ? skeletonMonitoringItemDashboard()
            : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: ctr.itemSubmission.length <= 10 ? ctr.itemSubmission.length : 10,
            itemBuilder: (ctx, idx) {
              RecentAsset i = ctr.recentAssets[idx];
              return Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
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
                  onTap: () => {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, left: 2, right: 2),
                        child: Row(
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
                                  Text('asset'.tr,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(DateFormat('dd MMMM yyyy').format(DateFormat('yyyy-MM-dd').parse(i.date!)),
                                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),),
                          ],
                        ),
                      ),
                      Divider(color: Colors.blue.shade50, height: 0,),
                      Padding(
                        padding: const EdgeInsets.only(left: 4, top: 6, right: 2),
                        child: Table(
                          columnWidths: const {
                            0: FlexColumnWidth(0.7),
                            1: FlexColumnWidth(0.1),
                            2: FlexColumnWidth(),
                          },
                          children: [
                            {'label': 'employee'.tr, 'value': i.employeeName},
                            {'label': 'asset_name'.tr, 'value': i.asset},
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
                      )
                    ],
                  ),
                ),
              );
            }
        ),
      ),
      if(ctr.filterRecent.value == 'recent_components'.tr) Padding(
        padding: const EdgeInsets.only(top: 10, left: 14, right: 14, bottom: 10),
        child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: ctr.recentAssets.length,
            itemBuilder: (ctx, idx) {
              RecentComponent i = ctr.recentComponents[idx];
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
                  onTap: () {},
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
                                Text('component'.tr,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(DateFormat('dd MMMM yyyy').format(DateFormat('yyyy-MM-dd').parse(i.date!)),
                                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),),
                        ],
                      ),
                      Divider(color: Colors.blue.shade100,),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 2),
                      //   child: Text(i. ?? '',
                      //     style: const TextStyle(fontSize: 12),
                      //   ),
                      // )
                    ],
                  ),
                ),
              );
            }
        ),
      ),
      if(ctr.progressDashboard.value) Container(color: Colors.transparent,)
      else if((ctr.filterRecent.value == 'recent_assets'.tr && ctr.recentAssets.isNotEmpty) ||
          (ctr.filterRecent.value == 'recent_components'.tr && ctr.recentComponents.isNotEmpty)) Padding(
        padding: const EdgeInsets.only(left: 14, right: 14, bottom: 20),
        child: TextButton(
            onPressed: () {},
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