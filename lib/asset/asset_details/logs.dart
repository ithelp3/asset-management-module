import 'package:asset_management_module/model/asset_log.dart';
import 'package:flutter/material.dart';

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
                        // width: double.infinity,
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
    child: const Column(
      children: [
        Icon(Icons.folder_off_outlined, color: Color(0xFF3f87b9), size: 80,),
        Divider(height: 10,),
        Text('No Data Available', style: TextStyle(fontWeight: FontWeight.bold),)
      ],
    ),
  );
}