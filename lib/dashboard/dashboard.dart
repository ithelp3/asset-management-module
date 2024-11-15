import 'package:asset_management_module/home/controller.dart';
import 'package:asset_management_module/model/monitoring.dart';
import 'package:asset_management_module/monitoring/view.dart';
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
    body:  Obx(() => ScrollConfiguration(
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
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(40),
                                  boxShadow: [BoxShadow(
                                    color: Colors.blue.withOpacity(0.2),
                                    blurRadius: 4,
                                    spreadRadius: 2,
                                    offset: const Offset(2, 4),
                                  )]
                              ),
                              child: Icon(icon, size: 34, color: const Color(0xFF3f87b9),)),
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
                  children: ['submission'.tr, 'purchase'.tr, 'lending'.tr, 'maintenance'.tr,].map((i) {
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
            if(ctr.capsule.value == 'submission'.tr) Padding(
              padding: const EdgeInsets.only(top: 10, left: 14, right: 14, bottom: 10),
              child: ListView.builder(
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
                    arguments: { 'type': ctr.capsule.value },
                    routeName: '/monitoring'
                  );
                },
                child: Text('see_all_monitoring_lists'.tr)
              ),
            )
          ],
        ),
      // )
    ))
  );
}