import 'package:asset_management_module/model/asset_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget components(BuildContext context, List<AssetComponent> components) {
  return components.isNotEmpty ? ListView.builder(
    itemCount: components.length,
    itemBuilder: (ctx, idx) {
      AssetComponent item = components[idx];
      return Container(
        margin: const EdgeInsets.only(top: 14, left: 14, right: 14),
        padding: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : const Color(0xFF272d34),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: const Color(0xFF3f87b9))
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Image.network(item.pictures ?? 'asset.fingerspot.net',
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
                  {'label': 'name'.tr, 'value': item.name},
                  {'label': 'type'.tr, 'value': item.categoryName},
                  {'label': 'brand'.tr, 'value': item.brand},
                  {'label': 'component_quantity'.tr, 'value': item.componentQuantity},
                  {'label': 'available_quantity'.tr, 'value': item.availableQuantity},
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