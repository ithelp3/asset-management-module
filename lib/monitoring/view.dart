import 'package:asset_management_module/component_widget/skeleton_monitoring.dart';
import 'package:asset_management_module/monitoring/purchase_item.dart';
import 'package:asset_management_module/monitoring/submission_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class MonitoringPage extends StatelessWidget {
  const MonitoringPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MonitoringController(),
      builder: (ctr) => Obx(() {
        return Scaffold(
          appBar: AppBar(
            title: Text('monitoring'.tr),
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.arrow_back_ios,
                color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,),
            ),
            centerTitle: true,
            bottom: PreferredSize(
                preferredSize: const Size(double.infinity, 40),
                child: TabBar(
                    onTap: (idx) => ctr.update(),
                    controller: ctr.tabController,
                    dividerColor: Colors.transparent,
                    tabs: ['submission'.tr, 'purchase_order'.tr, ].map((i) => Tab(
                      child: Text(i),
                    )).toList()
                )
            ),
          ),
          body: TabBarView(
            controller: ctr.tabController,
            children: [
              !ctr.progress.value
                ? ctr.itemSubmissions.isNotEmpty
                  ? submissionItem(context, ctr)
                  : Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/4),
                    child: Column(
                        children: [
                          const Icon(Icons.folder_off_outlined, size: 80, color: Color(0xFF3f87b9),),
                          const Divider(height: 10,),
                          Text('no_data_available'.tr,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF3f87b9)),)
                        ]
                    ),
                  )
                : skeletonMonitoringItem(),
              !ctr.progress.value
                ? ctr.itemPurchases.isNotEmpty
                  ? purchaseItem(context, ctr)
                  : Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/4),
                child: Column(
                    children: [
                      const Icon(Icons.folder_off_outlined, size: 80, color: Color(0xFF3f87b9),),
                      const Divider(height: 10,),
                      Text('no_data_available'.tr,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF3f87b9)),)
                    ]
                ),
              )
                : skeletonMonitoringItem()
            ],
          ),
        );
      }),
    );
  }
}
