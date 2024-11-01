import 'package:asset_management_module/component_widget/formates.dart';
import 'package:asset_management_module/submission/submission_details/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget purchase(BuildContext context, SubmissionDetailsController ctr) {
  MaterialColor colorStatus = Colors.brown;
  if(ctr.submissionDetails.value.status == 'On Process') colorStatus = Colors.blue;
  if(ctr.submissionDetails.value.status == 'Approved' || ctr.submissionDetails.value.status == 'Complete') colorStatus = Colors.green;
  if(ctr.submissionDetails.value.status == 'Rejected') colorStatus = Colors.red;
  return Card(
    margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
    child: Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text('purchase'.tr,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                    color: colorStatus.shade50,
                    borderRadius: BorderRadius.circular(4)
                ),
                child: Text(ctr.purchase.value.status == 1 ? 'un_paid'.tr : 'paid'.tr,
                  style: TextStyle(
                      fontSize: 12,
                      color: colorStatus.shade700),),
              )
            ],
          ),
          ...ctr.items.map((item) {
            double subTotal = item.qty! * double.parse(item.cost ?? '0.0');
            return Container(
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF3f87b9)),
                  borderRadius: BorderRadius.circular(6)
              ),
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name!),
                  Divider(height: 6, color: Colors.grey.shade200,),
                  if(item.description != '') Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${'description'.tr}:', style: const TextStyle(fontSize: 12),),
                      Text(item.description ?? 'N/A', style: const TextStyle(fontSize: 12, color: Colors.grey),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${'brand'.tr} :', style: const TextStyle(fontSize: 12),),
                            Text(item.brandName ?? 'N/A', style: const TextStyle(fontSize: 12, color: Colors.grey),),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${'quantity'.tr} :', style: const TextStyle(fontSize: 12),),
                            Text('${item.qty?.toString() ?? '0'} Pcs', style: const TextStyle(fontSize: 12, color: Colors.grey),),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(': ${'cost'.tr}', style: const TextStyle(fontSize: 12),),
                            Text(double.parse(item.cost ?? '0').toIdr(), style: const TextStyle(fontSize: 12, color: Colors.grey),),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 8, color: Colors.grey.shade200,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${'total'.tr}: ',
                        textAlign: TextAlign.start,
                        style: const TextStyle(fontSize: 12),),
                      Text(subTotal.toIdr(), style: const TextStyle(fontSize: 12),),
                    ],
                  )
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
                        style : const TextStyle(fontSize: 12,)),
                    Text(double.parse(i['value'] ?? '0.0').toIdr(),
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontSize: 12),
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