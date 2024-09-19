import 'package:asset_management_module/model/asset_maintenance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget maintenances(BuildContext context, List<AssetMaintenance> maintenances){
  return maintenances.isNotEmpty ? ListView.builder(
    itemCount: maintenances.length,
    itemBuilder: (ctx, idx) {
      AssetMaintenance item = maintenances[idx];
      return Container(
        margin: const EdgeInsets.only(top: 14, left: 14, right: 14),
        padding: const EdgeInsets.only(top: 10,),
        decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : const Color(0xFF272d34),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: const Color(0xFF3f87b9))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(item.asset ?? 'N/A',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Table(
                border: TableBorder(
                  horizontalInside: BorderSide(
                      color: Colors.grey.shade200
                  ),
                  bottom: BorderSide(
                      color: Colors.grey.shade200
                  ),
                  top: BorderSide(
                      color: Colors.grey.shade200
                  ),
                ),
                columnWidths: const {
                  0: FlexColumnWidth(0.4),
                  2: FlexColumnWidth(),
                },
                children: [
                  {'label': 'supplier'.tr, 'value': item.supplier},
                  {'label': 'type'.tr, 'value': item.type},
                  {'label': 'start_date'.tr, 'value': item.startDate},
                  {'label': 'end_date'.tr, 'value': item.endDate},
                ].map((i) => TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                        child: Text(i['label'].toString(),),
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
      );
    }
  ) : Padding(
    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/4),
    child: Column(
      children: [
        const Icon(Icons.folder_off_outlined, color: Color(0xFF3f87b9), size: 80,),
        const Divider(height: 10,),
        Text('no_data_available'.tr, style: const TextStyle(fontWeight: FontWeight.bold),)
      ],
    ),
  );
}