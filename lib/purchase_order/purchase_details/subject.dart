import 'package:asset_management_module/purchase_order/purchase_details/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Widget subject(BuildContext context, PurchaseDetailsController ctr) {
  return Card(
    margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
          child: Row(
            children: [
              const RotationTransition(
                turns: AlwaysStoppedAnimation(40 /360),
                child: Icon(Icons.attach_file_outlined, color: Color(0xFF3f87b9),)),
              const VerticalDivider(width: 8,),
              Expanded(
                child: Text(ctr.purchase.value.purchaseCode!,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                    color: ctr.purchase.value.status == 1 ? Colors.blue.shade50 : Colors.green.shade50,
                    borderRadius: BorderRadius.circular(4)
                ),
                child: Text(ctr.purchase.value.status == 1 ? 'un_paid'.tr : 'paid'.tr,
                  style: TextStyle(
                      fontSize: 12,
                      color: ctr.purchase.value.status == 1 ? Colors.blue.shade700 : Colors.green.shade700),),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
          child: Column(
            children: [
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(1.4),
                  1: FlexColumnWidth(0.2),
                  2: FlexColumnWidth(3),
                },
                children: [
                  {'label': 'subject'.tr, 'value': ctr.purchase.value.subject ?? 'N/A'},
                  {'label': 'added_from'.tr, 'value': ctr.purchase.value.addedFromName ?? 'N/A'},
                  // {'label': 'priority'.tr, 'value': ctr.submission.value.priority ?? 'N/A'},
                  {'label': 'date_used'.tr, 'value': DateFormat('dd MMMM yyyy').format(DateFormat('dd-MM-yyyy').parse(ctr.purchase.value.date!))},
                ].map((i) => TableRow(
                    children: [
                      Text(i['label'].toString(),
                          style : const TextStyle(fontSize: 12, height: 1.4)),
                      const Text(' : ', style: TextStyle(fontSize: 12, height: 1.4),),
                      Text(i['value']!,
                        style: const TextStyle(fontSize: 12, height: 1.4),
                      ),
                    ]
                )).toList(),
              ),
            ],
          ),
        ),
        if((ctr.purchase.value.notes ?? '') != '') Padding(
          padding: const EdgeInsets.only(top: 6, bottom: 12, left: 12, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${'note'.tr} : ', style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),),
              Text(ctr.purchase.value.notes?.replaceAll(RegExp(r"<[^>]*>",), '') ?? 'N/A',
                  style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic))
            ],
          ),
        )
      ],
    ),
  );
}