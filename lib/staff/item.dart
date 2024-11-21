import 'package:asset_management_module/model/employee.dart';
import 'package:asset_management_module/staff/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget itemStaff(BuildContext context, StaffController ctr, Employee item) {
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
              Expanded(child: Text(item.fullName ?? 'N/A',
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3f87b9)),),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: const Color(0xFF3f87b9)
                ),
                child: Text(item.statusName ?? 'N/A', style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),),
              )
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
              0: FlexColumnWidth(0.3),
              1: IntrinsicColumnWidth(),
              2: FlexColumnWidth(),
            },
            children: [
              {'label': 'email'.tr, 'value': item.email ?? 'N/A'},
              {'label': 'department'.tr, 'value': item.departmentName ?? 'N/A'},
              {'label': 'position'.tr, 'value': item.position ?? 'N/A'},
              {'label': 'address'.tr, 'value': item.address ?? 'N/A'},
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