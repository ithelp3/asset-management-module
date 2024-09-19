import 'package:asset_management_module/component_widget/formates.dart';
import 'package:asset_management_module/model/asset_depreciation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Widget depreciations(BuildContext context, List<AssetDepreciation> depreciations) {
  return depreciations.isNotEmpty ? ListView.builder(
    itemCount: depreciations.length,
    itemBuilder: (ctx, idx) {
      AssetDepreciation item = depreciations[idx];
      bool isTime = (DateFormat('MM-yyyy').format(DateTime.now()) == item.periodMonth);
      return Container(
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        padding: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: isTime
            ? const Color(0xFF3f87b9)
            : Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : const Color(0xFF272d34),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: isTime ? Colors.white : const Color(0xFF3f87b9))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${'period'.tr}#${item.period} ${DateFormat('MM-yyyy').format(DateTime.now())} ${item.periodMonth}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: isTime
                          ? Colors.white
                          : Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white
                    ),),
                  Text(double.tryParse(item.bookValue ?? '0.0')!.toIdr(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isTime
                          ? Colors.white
                          : Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white
                    ),),
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
                  {'label': 'depreciation_percentage'.tr, 'value': '${item.depreciationPercentage ?? '0.0'} %'},
                  {'label': 'amount'.tr, 'value': double.tryParse(item.amount ?? '0.0')!.toIdr()},
                  {'label': 'accumulated_depreciation'.tr, 'value': double.tryParse(item.accumulatedDepreciation ?? '0.0')!.toIdr()},
                  {'label': 'ending_book_value'.tr, 'value': double.tryParse(item.endingBookValue ?? '0.0')!.toIdr()},
                ].map((i) => TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                        child: Text(i['label'].toString(), style: TextStyle(color: isTime
                            ? Colors.white
                            : Theme.of(context).brightness == Brightness.light
                              ? Colors.black
                              : Colors.white
                        ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                        child: Text(i['value'].toString(),
                          textAlign: TextAlign.right,
                          style: TextStyle(color: isTime
                              ? Colors.white
                              : Theme.of(context).brightness == Brightness.light
                                ? Colors.black
                                : Colors.white
                          ),
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