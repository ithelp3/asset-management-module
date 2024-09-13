import 'package:asset_management_module/asset/asset_details/controller.dart';
import 'package:asset_management_module/component_widget/skeleton_asset.dart';
import 'package:flutter/material.dart';


Widget details(BuildContext context, AssetDetailsController ctr) {
  return !ctr.progress.value ? Container(
    margin: const EdgeInsets.all(14),
    padding: const EdgeInsets.only(top: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: const Color(0xFF3f87b9))
    ),
    child: ListView(
      children: [
        SizedBox(
          child: Image.network(ctr.details.value.pictures!.replaceAll('192.168.1.135:8400', 'asset.fingerspot.net',),
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
              {'label': 'group', 'value': ctr.details.value.groupName},
              {'label': 'category', 'value': ctr.details.value.categoryName},
              {'label': 'sub-category', 'value': ctr.details.value.subcategoryName},
              {'label': 'status', 'value': ctr.details.value.statusName},
              {'label': 'person on charger', 'value': ctr.details.value.pic},
              {'label': 'Assigned', 'value': ctr.details.value.pic},
              {'label': 'serial', 'value': ctr.details.value.serial},
              {'label': 'brand', 'value': ctr.details.value.brand},
              {'label': 'location', 'value': ctr.details.value.locations},
              {'label': 'supplier', 'value': ctr.details.value.supplier},
              {'label': 'update at', 'value': ctr.details.value.updatedAt},
              {'label': 'update at', 'value': ctr.details.value.updatedAt},
              {'label': 'create at', 'value': ctr.details.value.createdAt},
              {'label': 'description', 'value': ctr.details.value.description},
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
  ) : skeletonAssetDetailsView(context);
}