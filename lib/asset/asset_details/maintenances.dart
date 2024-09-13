import 'package:asset_management_module/model/asset_maintenance.dart';
import 'package:flutter/material.dart';

Widget maintenances(BuildContext context, List<AssetMaintenance> maintenances){
  return maintenances.isNotEmpty ? ListView.builder(
    itemCount: maintenances.length,
    itemBuilder: (ctx, idx) {
      AssetMaintenance item = maintenances[idx];
      return Container(
        margin: const EdgeInsets.only(top: 14, left: 14, right: 14),
        padding: const EdgeInsets.only(top: 10,),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: const Color(0xFF3f87b9))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(item.asset ?? 'N/A',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
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
                  {'label': 'Supplier', 'value': item.supplier},
                  {'label': 'Type', 'value': item.type},
                  {'label': 'Start Date', 'value': item.startDate},
                  {'label': 'End Date', 'value': item.endDate},
                ].map((i) => TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                        child: Text(i['label'].toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),),
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
    child: const Column(
      children: [
        Icon(Icons.folder_off_outlined, color: Color(0xFF3f87b9), size: 80,),
        Divider(height: 10,),
        Text('No Data Available', style: TextStyle(fontWeight: FontWeight.bold),)
      ],
    ),
  );
}