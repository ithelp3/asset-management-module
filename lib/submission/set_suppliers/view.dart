import 'package:asset_management_module/submission/set_suppliers/dialog_supplier_add/controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'controller.dart';

class SetSuppliersPage extends StatelessWidget {
  const SetSuppliersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SetSuppliersController(),
      builder: (ctr) => Scaffold(
        appBar: AppBar(
          title: Text('find_supplier'.tr),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios,
              color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,),
          ),
          centerTitle: true,
        ),
        body: Obx(() => Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Color(0xFF3f87b9)
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(ctr.submission.value.subject!,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.green.shade100
                        ),
                        child: Text(ctr.submission.value.status!.tr, style: const TextStyle(color: Colors.green, fontSize: 12),),
                      )
                    ],
                  ),
                  const Divider(color: Colors.white,),
                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1.1),
                      1: FlexColumnWidth(0.1),
                      2: FlexColumnWidth(2),
                    },
                    children: [
                      {'label': 'added_from'.tr, 'value': ctr.submission.value.username},
                      {'label': 'priority'.tr, 'value': ctr.submission.value.priority},
                      {'label': 'date_used'.tr, 'value': DateFormat('dd MMMM yyyy').format(DateFormat('yyyy-MM-dd').parse(ctr.submission.value.dateUsed!))},
                    ].map((i) => TableRow(
                        children: [
                          Text(i['label'].toString(), style : const TextStyle(color: Colors.white)),
                          const Text(':', style: TextStyle(color: Colors.white),),
                          Text((i['value'] ?? '') != '' ? i['value'].toString() : 'N/A',
                            textAlign: TextAlign.left,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ]
                    )).toList(),
                  ),
                ],
              ),
            ),
            if(ctr.selectedSuppliers.isNotEmpty) Padding(
              padding: const EdgeInsets.only(top: 10, left: 14, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('data_supplier'.tr,
                  style: const TextStyle(fontSize: 16, color: Color(0xFF3f87b9), fontWeight: FontWeight.bold),),
              ),
            ),
            Expanded(
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior(),
                  child: ctr.selectedSuppliers.isNotEmpty ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: ctr.selectedSuppliers.length,
                      itemBuilder: (ctx, idx) {
                        SupplierSelected supplier = ctr.selectedSuppliers[idx];
                        return Container(
                          margin: const EdgeInsets.only(left: 14, right: 14, bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: const Color(0xFF3f87b9))
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Text(supplier.supplier?.name ?? 'N/A'),
                                      ),
                                    ),
                                    PopupMenuButton(
                                      itemBuilder: (ctx) => [
                                        {'label': 'edit'.tr, 'icon': Icons.edit_note_outlined},
                                        {'label': 'delete'.tr, 'icon': Icons.delete_outline_outlined},
                                        // {'label': 'download'.tr, 'icon': Icons.download},
                                      ].map((i) {
                                        String label = i['label'].toString();
                                        IconData icon = i['icon'] as IconData;
                                        return PopupMenuItem(
                                            onTap: () {
                                              if(label == 'edit'.tr) ctr.editSupplier(supplier, idx);
                                              if(label == 'delete'.tr) ctr.deleteSupplier(supplier, idx);
                                              // if(label == 'assign'.tr || label == 'un_assign'.tr) ctr.assignUnassign(item);
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
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
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
                                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 8),
                                child: Row(
                                  children: [
                                    Icon(Icons.file_copy_outlined, color: Colors.blue.shade200, size: 18,),
                                    const VerticalDivider(width: 6,),
                                    Expanded(child: Text(supplier.fileName ?? 'N/A'))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                  ) : Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height/4,
                        left: 40,
                        right: 40
                    ),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: 'saat ini Anda belum memilik data supplier yang akan diajukan. '.tr,
                              style: const TextStyle(color: Colors.grey, fontStyle: FontStyle.italic, fontSize: 13, height: 1.2)
                          ),
                          TextSpan(
                              text: 'klik disini',
                              style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontStyle: FontStyle.italic, fontSize: 13, height: 1.2),
                              recognizer: TapGestureRecognizer()..onTap = () => ctr.addSupplier()
                          ),
                          TextSpan(
                              text: ' atau tanda + dibawah untuk membuat data supplier'.tr,
                              style: const TextStyle(color: Colors.grey, fontStyle: FontStyle.italic, fontSize: 13, height: 1.2)
                          ),
                        ]
                      )
                    ),
                  ),
                )
            ),
          ],
        )),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(bottom: 30, top: 14, left: 10, right: 10),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : const Color(0xFF272d34)
          ),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)
                  ),
                  backgroundColor: const Color(0xFF3f87b9),
                  foregroundColor: Colors.white
              ),
              onPressed: () => ctr.save(context),
              child: Text('save'.tr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
          ),
        ),
        floatingActionButton: Visibility(
            visible: !(MediaQuery.of(context).viewInsets.bottom != 0),
            child: FloatingActionButton(
              onPressed: () => ctr.addSupplier(),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)
              ),
              backgroundColor: const Color(0xFF3f87b9),
              child: const Icon(Icons.add, size: 34, color: Colors.white,),
            )
        ),
      )
    );
  }
}
