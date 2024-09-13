import 'package:asset_management_module/model/asset_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget components(BuildContext context, List<AssetComponent> components) {
  return components.isNotEmpty ? ListView.builder(
    itemCount: components.length,
    itemBuilder: (ctx, idx) {
      AssetComponent item = components[idx];
      return Container(
        margin: const EdgeInsets.only(top: 14, left: 14, right: 14),
        padding: const EdgeInsets.only(top: 20, left: 14, right: 14, bottom: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: const Color(0xFF3f87b9))
        ),
        child: Column(
          children: [
            SizedBox(
              child: Image.network(item.pictures!.replaceAll('192.168.1.135:8400', 'asset.fingerspot.net',),
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
                  {'label': 'Name', 'value': item.name},
                  {'label': 'Type', 'value': item.categoryName},
                  {'label': 'Brand', 'value': item.brand},
                  {'label': 'Component Quantity', 'value': item.componentQuantity},
                  {'label': 'Available Quantity', 'value': item.availableQuantity},
                ].map((i) => TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(i['label'].toString(), style: const TextStyle(fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
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