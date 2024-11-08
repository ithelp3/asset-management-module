import 'package:asset_management_module/component_widget/formates.dart';
import 'package:asset_management_module/purchase_order/purchase_details/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget purchase(BuildContext context, PurchaseDetailsController ctr) {
  return Card(
    margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
    child: Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon( Icons.trolley, color: Color(0xFF3f87b9),),
              const VerticalDivider(width: 8,),
              Expanded(
                child: Text(ctr.purchase.value.supplierName ?? 'N/A',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(0.5),
                1: FlexColumnWidth(0.1),
                2: FlexColumnWidth(3),
              },
              children: [
                {'label': 'address'.tr, 'value': ctr.purchase.value.supplierAddress?? 'N/A'},
                {'label': 'phone'.tr, 'value': ctr.purchase.value.supplierPhone ?? 'N/A'},
                {'label': 'email'.tr, 'value': ctr.purchase.value.supplierEmail ?? 'N/A'},
              ].map((i) => TableRow(
                children: [
                  Text(i['label'].toString(),
                    style : const TextStyle(fontSize: 12, height: 1.4)),
                  const Text(':', style: TextStyle(fontSize: 12, height: 1.4),),
                  Text(i['value']!,
                    style: const TextStyle(fontSize: 12, height: 1.4),
                  ),
                ]
              )).toList(),
            ),
          ),
          ...ctr.items.map((item) {
            double subTotal = item.qty! * double.parse(item.cost ?? '0.0');
            return Container(
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF3f87b9)),
                  borderRadius: BorderRadius.circular(6)
              ),
              margin: const EdgeInsets.only(top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6, bottom: 4, left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.name!, style: const TextStyle(fontWeight: FontWeight.bold),),
                        if(item.description != '') Text('${'description'.tr} : ${item.description!.replaceAll(RegExp(r"<[^>]*>",), '') }',
                          style: const TextStyle(fontSize: 12, height: 1.2, fontStyle: FontStyle.italic),)
                      ],
                    ),
                  ),
                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(3),
                    },
                    border: TableBorder(
                      horizontalInside: BorderSide(color: Colors.blue.shade100,),
                      bottom: BorderSide(color: Colors.blue.shade100)
                    ),
                    children: [
                      {'label': 'brand'.tr, 'value': item.brandName ?? 'N/A'},
                      {'label': 'sub_category'.tr, 'value': item.subCategoryName ?? 'N/A'},
                      {'label': 'cost'.tr, 'value': "${item.qty ?? 0}  x  ${double.parse(item.cost ?? '0').toIdr()}"},
                    ].map((i) => TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(i['label'].toString(),
                                textAlign: TextAlign.left,
                                style : const TextStyle(fontSize: 12, height: 1.6)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Text(i['value']!,
                              textAlign: TextAlign.right,
                              style: const TextStyle(fontSize: 12, height: 1.6),
                            ),
                          ),
                        ]
                    )).toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8, top: 6, bottom: 6),
                    child: Table(
                      columnWidths: const {
                        0: FlexColumnWidth(0.96),
                        1: FlexColumnWidth(),
                      },
                      children: [
                        {'label': '${'total'.tr} :', 'value': subTotal.toIdr()},
                      ].map((i) => TableRow(
                          children: [
                            Text(i['label'].toString(),
                                textAlign: TextAlign.right,
                                style : const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            Text(i['value']!,
                              textAlign: TextAlign.right,
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ]
                      )).toList(),
                    ),
                  ),
                ],
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.only(right: 8, top: 8),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(),
              },
              children: [
                {'label': '${'sub_total'.tr} :', 'value': ctr.purchase.value.subtotal},
                {'label': 'Discount (${ctr.purchase.value.discount}%) :', 'value': ctr.purchase.value.discountTotal},
                {'label': '${'tax'.tr} (${ctr.purchase.value.tax}%) :', 'value': ctr.purchase.value.taxTotal},
                {'label': '${'total'.tr} :', 'value': ctr.purchase.value.total},
              ].map((i) => TableRow(
                  children: [
                    Text(i['label'].toString(),
                        textAlign: TextAlign.right,
                        style : TextStyle(
                            fontSize: 12,
                            fontWeight: i['label'].toString().contains('total'.tr) ? FontWeight.bold : FontWeight.normal
                        )),
                    Text(double.parse(i['value'] ?? '0.0').toIdr(),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: i['label'].toString().contains('total'.tr) ? FontWeight.bold : FontWeight.normal
                      ),
                    ),
                  ]
              )).toList(),
            ),
          ),
        ],
      ),
    ),
  );
}