import 'package:asset_management_module/model/asset_history.dart';
import 'package:flutter/material.dart';

Widget histories(BuildContext context, List<AssetHistory> histories){
  return histories.isNotEmpty ? ListView.builder(
      itemCount: histories.length,
      itemBuilder: (ctx, idx){
        AssetHistory item = histories[idx];
        return Container(
          margin: const EdgeInsets.only(top: 14, left: 14, right: 14),
          padding: const EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 12),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: const Color(0xFF3f87b9))
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text('#${item.date}',
                      style: const TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  Text(item.status ?? 'N/A',
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF3f87b9)))
                ],
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
                      )
                  ),
                  columnWidths: const {
                    0: FlexColumnWidth(1),
                    2: FlexColumnWidth(),
                  },
                  children: [
                    {'label': 'Asset', 'value': item.assetName ?? 'N/A'},
                    {'label': 'Employee', 'value': item.employeeName ?? 'N/A'},
                  ].map((i) => TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text(i['label'].toString(), style: const TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
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
  ): Padding(
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