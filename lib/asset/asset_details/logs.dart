import 'package:asset_management_module/model/asset_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget logs(BuildContext context, List<AssetLog> logs) {
  return logs.isNotEmpty ? ListView.builder(
    itemCount: logs.length,
    itemBuilder: (ctx, idx) {
      AssetLog log = logs[idx];
      return IntrinsicHeight(
        child:  Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 14),
              width: 4,
              color: Colors.blue.shade200,
            ),
            Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 11, right: 14, top: 10),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        color: const Color(0xFF3f87b9),
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(top: 10, right: 10),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(color: const Color(0xFF3f87b9))
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(log.createdAt ?? 'N/A', style: const TextStyle(fontWeight: FontWeight.bold),),
                            Text('${log.description} - ${log.fullName}', style: const TextStyle(fontSize: 12),)
                          ],
                        ),
                      ),
                  ),
                ],
              ),
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