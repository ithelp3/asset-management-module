import 'package:asset_management_module/component_widget/formates.dart';
import 'package:asset_management_module/purchase_order/add_edit_purchase/controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

addItem(BuildContext context, AddEditPurchaseController ctr) {
  return ctr.items.isNotEmpty
      ? ListView(
    children: [
      ...ctr.items.map((item) => Container(
        margin: const EdgeInsets.only(left: 12, right: 12, top: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF3f87b9))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 14, bottom: (item.desc != null && item.desc != '') ? 0 : 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 4),
                        child: Text(item.name!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                      ),
                      Table(
                        columnWidths: const {
                          0: FlexColumnWidth(0.34),
                          1: IntrinsicColumnWidth(),
                          2: FlexColumnWidth(),
                        },
                        children: [
                          {'label': 'brand'.tr, 'value': item.brand!.name!},
                          {'label': 'sub_category'.tr, 'value': '${item.subCategory!.kode!} - ${item.subCategory!.name}'},
                          {'label': 'quantity'.tr, 'value': item.qty},
                          {'label': 'cost'.tr, 'value': item.cost!.toIdr()},
                        ].map((i) => TableRow(
                            children: [
                              Text(i['label'].toString(), style: const TextStyle(fontSize: 12, height: 1.2),),
                              const Text(': ', style: TextStyle(height: 1.2),),
                              Text(i['value'].toString(),
                                textAlign: TextAlign.left,
                                style: const TextStyle(fontSize: 12, height: 1.2),)
                            ]
                        )).toList(),
                      )
                    ],
                  )),
                  PopupMenuButton(
                    itemBuilder: (ctx) => [
                      {'label': 'edit'.tr, 'icon': Icons.edit_note_outlined},
                      {'label': 'delete'.tr, 'icon': Icons.delete_outline_outlined},
                    ].map((i) {
                      String label = i['label'].toString();
                      IconData icon = i['icon'] as IconData;
                      return PopupMenuItem(
                          onTap: () {
                            // if(label == 'edit'.tr) ctr.assetAddEdit('edit', item);
                            // if(label == 'delete'.tr) ctr.assetDelete(context, item);
                          },
                          height: 34,
                          child: Row(
                            children: [
                              Icon(icon, color: const Color(0xFF3f87b9),),
                              const VerticalDivider(width: 10,),
                              Text(label, style: const TextStyle(color: Color(0xFF3f87b9)),),
                            ],
                          )
                      );
                    }).toList(),
                    style: const ButtonStyle(
                      iconColor: WidgetStatePropertyAll(Color(0xFF3f87b9)),
                    ),
                    icon: const Icon(Icons.more_vert_outlined),
                  )
                ],
              ),
            ),
            if((item.desc ?? '') != '') Padding(
              padding: const EdgeInsets.all(10),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final boxWidth = constraints.constrainWidth();
                  double dashWidth = 4;
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
            if((item.desc ?? '') != '') Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${'description'.tr} :', style: const TextStyle(fontWeight: FontWeight.bold),),
                  Text(item.desc!, style: const TextStyle(fontSize: 12),)
                ],
              ),
            )
          ],
        ),
      )),
      TextButton(
          onPressed: () => ctr.addItem(context),
          child: Text('add_asset'.tr, style: const TextStyle(fontWeight: FontWeight.bold),)
      )
    ],
  )
      : Container(
    alignment: Alignment.center,
    child: Padding(
      padding: const EdgeInsets.only(
          left: 40,
          right: 40
      ),
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              children: [
                TextSpan(
                    text: 'info_create_purchase_order_1'.tr,
                    style: const TextStyle(color: Colors.grey, fontStyle: FontStyle.italic, fontSize: 13, height: 1.2)
                ),
                TextSpan(
                    text: 'info_create_purchase_order_2'.tr,
                    style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontStyle: FontStyle.italic, fontSize: 13, height: 1.2),
                    recognizer: TapGestureRecognizer()..onTap = () => ctr.addItem(context)
                ),
                TextSpan(
                    text: 'info_create_purchase_order_3'.tr,
                    style: const TextStyle(color: Colors.grey, fontStyle: FontStyle.italic, fontSize: 13, height: 1.2)
                ),
              ]
          )
      ),
    ),
  );
}