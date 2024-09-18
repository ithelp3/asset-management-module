import 'package:asset_management_module/asset/asset_details/controller.dart';
import 'package:asset_management_module/component_widget/skeleton_asset.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


Widget details(BuildContext context, AssetDetailsController ctr) {
  return !ctr.progress.value ? ListView(
    children: [
      Container(
        margin: const EdgeInsets.all(14),
        padding: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: const Color(0xFF3f87b9))
        ),
        child: Column(
          children: [
            SizedBox(
              child: Image.network(ctr.details.value.pictures ?? 'asset.fingerspot.net',
                width: 100,
                height: 80,
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                  return Image.network('http://asset.fingerspot.net/images/pic.png',
                    width: 100,
                    height: 80,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Table(
                border: TableBorder(
                    horizontalInside: BorderSide(
                        color: Colors.grey.shade200
                    ),
                    bottom: BorderSide(
                        color: Colors.grey.shade200
                    )
                ),
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  2: FlexColumnWidth(),
                },
                children: [
                  {'label': 'group'.tr, 'value': ctr.details.value.groupName},
                  {'label': 'category'.tr, 'value': ctr.details.value.categoryName},
                  {'label': 'sub_category'.tr, 'value': ctr.details.value.subcategoryName},
                  {'label': 'status'.tr, 'value': ctr.details.value.statusName},
                  {'label': 'person_on_charge'.tr, 'value': ctr.details.value.pic},
                  {'label': 'assigned'.tr, 'value': ctr.details.value.pic},
                  {'label': 'serial'.tr, 'value': ctr.details.value.serial},
                  {'label': 'brand'.tr, 'value': ctr.details.value.brand},
                  {'label': 'location'.tr, 'value': ctr.details.value.locations},
                  {'label': 'supplier'.tr, 'value': ctr.details.value.supplier},
                  {'label': 'update_at'.tr, 'value': ctr.details.value.updatedAt},
                  {'label': 'create_at'.tr, 'value': ctr.details.value.createdAt},
                  {'label': 'description'.tr, 'value': ctr.details.value.description},
                ].map((i) => TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                        child: Text(i['label'].toString(), style: const TextStyle(fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                        child: Text((i['value'] ?? '') != '' ? i['value'].toString() : 'N/A',
                          textAlign: TextAlign.right,
                        ),
                      )
                    ]
                )).toList(),
              ),
            )
          ],
        ),
      )
    ],
  ) : skeletonAssetDetailsView(context);
}