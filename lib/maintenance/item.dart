import 'package:asset_management_module/maintenance/controller.dart';
import 'package:asset_management_module/model/maintenance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget itemMaintenance(BuildContext context, MaintenanceController ctr, Maintenance item) {
  return Container(
    margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
    decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : const Color(0xFF272d34),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFF3f87b9))
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 10, bottom: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(child: Text(item.assetTag ?? 'N/A',
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3f87b9)),),
              ),
              // PopupMenuButton(
              //   itemBuilder: (ctx) => [
              //     {'label': 'edit'.tr, 'icon': Icons.edit_note_outlined},
              //     {'label': 'delete'.tr, 'icon': Icons.delete_outline_outlined},
              //   ].map((i) {
              //     String label = i['label'].toString();
              //     IconData icon = i['icon'] as IconData;
              //     return PopupMenuItem(
              //       onTap: () {
              //         if(label == 'edit'.tr) ctr.addEditDep('edit', item);
              //         if(label == 'delete'.tr) ctr.deleteDep(context, item);
              //       },
              //       height: 34,
              //       child: Row(
              //         children: [
              //           Icon(icon, color: const Color(0xFF3f87b9),),
              //           const VerticalDivider(width: 10,),
              //           Text(label, style: const TextStyle(color: Color(0xFF3f87b9)),),
              //         ],
              //       ),
              //     );
              //   }).toList(),
              //   style: const ButtonStyle(
              //       iconColor: WidgetStatePropertyAll(Color(0xFF3f87b9)),
              //       padding: WidgetStatePropertyAll(EdgeInsets.zero)
              //   ),
              //   padding: EdgeInsets.zero,
              //   icon: const Icon(Icons.more_vert_outlined),
              // )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final boxWidth = constraints.constrainWidth();
              double dashWidth = 6;
              double dashHeight = 1;
              final dashCount = (boxWidth / (2 * dashWidth)).floor();
              return Flex(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                direction: Axis.horizontal,
                children: List.generate(dashCount, (_) {
                  return SizedBox(
                    width: dashWidth,
                    height: dashHeight,
                    child: const DecoratedBox(
                      decoration: BoxDecoration(color: Colors.grey),
                    ),);
                }),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(0.4),
              1: IntrinsicColumnWidth(),
              2: FlexColumnWidth(),
            },
            children: [
              {'label': 'asset'.tr, 'value': item.assetName ?? 'N/A'},
              {'label': 'supplier'.tr, 'value': item.supplierName ?? 'N/A'},
              {'label': 'type'.tr, 'value': item.type ?? 'N/A'},
              {'label': 'start_date'.tr, 'value': item.startDate ?? 'N/A'},
              {'label': 'end_date'.tr, 'value': item.endDate ?? 'N/A'},
            ].map((i) => TableRow(
                children: [
                  Text(i['label'].toString(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                  const Text(': '),
                  Text(i['value'] ?? 'N/A',
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 12),)
                ]
            )).toList(),
          ),
        )
      ],
    ),
  );
}