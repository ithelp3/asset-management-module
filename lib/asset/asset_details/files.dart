import 'package:asset_management_module/asset/asset_details/controller.dart';
import 'package:asset_management_module/model/asset_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget files(BuildContext context, AssetDetailsController ctr) {
  return Scaffold(
    body: ctr.files.isNotEmpty ? ListView.builder(
        itemCount: ctr.files.length,
        itemBuilder: (ctx, idx) {
          AssetFile item = ctr.files[idx];
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
                  child: Text(item.name ?? 'N/A',
                    style: const TextStyle(fontWeight: FontWeight.bold),),
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
                      {'label': 'date'.tr, 'value': item.updatedAt},
                      {'label': 'file'.tr, 'value': item.filename},
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
    ),
    floatingActionButton: Visibility(
        visible: !(MediaQuery.of(context).viewInsets.bottom != 0),
        child: FloatingActionButton(
          onPressed: () => ctr.addFile(),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40)
          ),
          backgroundColor: const Color(0xFF3f87b9),
          child: const Icon(Icons.add, size: 34, color: Colors.white,),
        )
    ),
  );
}