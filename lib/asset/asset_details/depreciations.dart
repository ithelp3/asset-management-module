import 'package:asset_management_module/component_widget/formates.dart';
import 'package:asset_management_module/model/asset_depreciation.dart';
import 'package:flutter/material.dart';

Widget depreciations(BuildContext context, List<AssetDepreciation> depreciations) {
  return depreciations.isNotEmpty ? ListView.builder(
    itemCount: depreciations.length,
    itemBuilder: (ctx, idx) {
      AssetDepreciation item = depreciations[idx];
      return Container(
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        padding: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: const Color(0xFF3f87b9))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Period#${item.period} ${item.periodMonth}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
                  Text(double.tryParse(item.bookValue ?? '0.0')!.toIdr(),
                    style: const TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
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
                  0: FlexColumnWidth(1),
                  2: FlexColumnWidth(),
                },
                children: [
                  {'label': 'Depreciation Percentage', 'value': '${item.depreciationPercentage ?? '0.0'} %'},
                  {'label': 'Amount', 'value': double.tryParse(item.amount ?? '0.0')!.toIdr()},
                  {'label': 'Accumulated Depreciation', 'value': double.tryParse(item.accumulatedDepreciation ?? '0.0')!.toIdr()},
                  {'label': 'Ending Book Value', 'value': double.tryParse(item.endingBookValue ?? '0.0')!.toIdr()},
                ].map((i) => TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                        child: Text(i['label'].toString(), style: const TextStyle(fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                        child: Text(i['value'].toString(),
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