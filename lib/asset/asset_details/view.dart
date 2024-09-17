import 'dart:convert';

import 'package:asset_management_module/asset/asset_details/components.dart';
import 'package:asset_management_module/asset/asset_details/depreciations.dart';
import 'package:asset_management_module/asset/asset_details/details.dart';
import 'package:asset_management_module/asset/asset_details/files.dart';
import 'package:asset_management_module/asset/asset_details/histories.dart';
import 'package:asset_management_module/asset/asset_details/logs.dart';
import 'package:asset_management_module/asset/asset_details/maintenances.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:asset_management_module/component_widget/skeleton_asset.dart';

import 'controller.dart';

class AssetDetailsPage extends StatelessWidget {
  const AssetDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AssetDetailsController(),
      builder: (ctr) => Obx(() => Scaffold(
        appBar: AppBar(
          title: Text('detail_asset'.tr,),
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back_ios, color: Colors.black,)),
          centerTitle: true,
          bottom: PreferredSize(
              preferredSize: const Size(double.infinity, 210),
              child: Column(
                children: [
                  !ctr.progress.value ? Column(
                    children: [
                      if(ctr.details.value.qr != '') Image.memory(const Base64Decoder().convert(ctr.details.value.qr!)),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text('${ctr.details.value.name} (${ctr.details.value.assetTag ?? 'N/A'})',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Table(
                          columnWidths: const {
                            0: FlexColumnWidth(0.5),
                            1: IntrinsicColumnWidth(),
                            2: FlexColumnWidth(),
                          },
                          children: [
                            {'label': 'type', 'value': ctr.details.value.categoryName},
                            {'label': 'status', 'value': ctr.details.value.statusName},
                          ].map((i) => TableRow(
                              children: [
                                Text(i['label'] ?? 'N/A', style: const TextStyle(fontWeight: FontWeight.bold),),
                                const Text(': '),
                                Text(i['value'] ?? 'N/A'),
                              ]
                          )).toList(),
                        ),
                      )
                    ],
                  ) : skeletonAssetDetailsHead(context),
                  TabBar(
                      controller: ctr.tabController,
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      dividerColor: Colors.transparent,
                      tabs: ['rincian', 'komponen', 'maintenance', 'riwayat', 'file', 'depresiasi', 'log activivitas'].map((i) => Tab(
                        child: Text(i),
                      )).toList()
                  )
                ],
              )
          ),
        ),
        body: TabBarView(
          controller: ctr.tabController,
          children: <Widget>[
            details(context, ctr),
            components(context, ctr.components),
            maintenances(context, ctr.maintenances),
            histories(context, ctr.histories),
            files(context, ctr),
            depreciations(context, ctr.depreciations),
            logs(context, ctr.logs),
          ],
        ),
      ))
    );
  }
}
