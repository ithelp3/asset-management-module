import 'package:asset_management_module/component_widget/skeleton_submission.dart';
import 'package:asset_management_module/utils/data/nav_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'controller.dart';

class SubmissionDetailsPage extends StatelessWidget {
  const SubmissionDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SubmissionDetailsController(),
      builder: (ctr) {
        MaterialColor colorStatus = Colors.brown;
        if(ctr.submission.value.status == 'On Process') colorStatus = Colors.blue;
        if(ctr.submission.value.status == 'Approved' || ctr.submission.value.status == 'Complete') colorStatus = Colors.green;
        if(ctr.submission.value.status == 'Rejected') colorStatus = Colors.red;
        return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text('submission_details'.tr),
            centerTitle: true,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.arrow_back_ios,
                color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,),
            ),
          ),
          body: !ctr.progress.value ? ScrollConfiguration(
            behavior: const ScrollBehavior(),
            child: ListView(
              children: [
                Card(
                  margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12, top: 10, bottom: 12),
                          child: Text('tracking'.tr,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 12),
                              height: 3,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  color: Colors.blue
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  width: MediaQuery.of(context).size.width/6,
                                  child: Column(
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.only(left: 2, right: 2, bottom: 8),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(20)
                                          ),
                                          child: Icon(ctr.submission.value.step == 2
                                              ? Icons.radio_button_checked
                                              : Icons.check_circle,
                                              color: Colors.blue
                                          )
                                      ),
                                      Text('submission_step_2'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 10, fontWeight: ctr.submission.value.step == 2 ? FontWeight.bold : FontWeight.normal),)
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width/6,
                                  child: Column(
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.only(left: 2, right: 2, bottom: 8),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(20)
                                          ),
                                          child: Icon(ctr.submission.value.step == 3
                                              ? Icons.radio_button_checked
                                              : ctr.submission.value.step! < 3
                                                ? Icons.radio_button_off
                                                : Icons.check_circle,
                                            color: Colors.blue,)
                                      ),
                                      Text('submission_step_3'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 10, fontWeight: ctr.submission.value.step == 3 ? FontWeight.bold : FontWeight.normal),)
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width/6,
                                  child: Column(
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.only(left: 2, right: 2, bottom: 8),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(20)
                                          ),
                                          child: Icon(ctr.submission.value.step == 4 || ctr.submission.value.step == 5
                                              ? Icons.radio_button_checked
                                              : ctr.submission.value.step! < 5
                                              ? Icons.radio_button_off
                                              : Icons.check_circle,
                                            color: Colors.blue,)
                                      ),
                                      Text('submission_step_4&5'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 10, fontWeight: ctr.submission.value.step == 4 || ctr.submission.value.step == 5 ? FontWeight.bold : FontWeight.normal),)
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width/6,
                                  child: Column(
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.only(left: 2, right: 2, bottom: 8),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(20)
                                          ),
                                          child: Icon(ctr.submission.value.step == 6
                                              ? Icons.radio_button_checked
                                              : ctr.submission.value.step! < 6
                                              ? Icons.radio_button_off
                                              : Icons.check_circle,
                                            color: Colors.blue,
                                          )
                                      ),
                                      Text('submission_step_6'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 10, fontWeight: ctr.submission.value.step == 6 ? FontWeight.bold : FontWeight.normal),)
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  width: MediaQuery.of(context).size.width/6,
                                  child: Column(
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.only(left: 2, right: 2, bottom: 8),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(20)
                                          ),
                                          child: Icon(ctr.submission.value.step == 7
                                              ? Icons.radio_button_checked
                                              : ctr.submission.value.step! != 0
                                              ? Icons.radio_button_off
                                              : Icons.check_circle,
                                            color: Colors.blue,
                                          )
                                      ),
                                      Text('submission_step_0'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 10, fontWeight: ctr.submission.value.step == 0 ? FontWeight.bold : FontWeight.normal),)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: Text(ctr.submission.value.submissionId!,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                  color: colorStatus.shade50,
                                  borderRadius: BorderRadius.circular(4)
                              ),
                              child: Text(ctr.submission.value.status?.tr ?? '',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: colorStatus.shade700),),
                            )
                          ],
                        ),
                        const Divider(height: 6,),
                        Table(
                          columnWidths: const {
                            0: FlexColumnWidth(1),
                            1: FlexColumnWidth(0.1),
                            2: FlexColumnWidth(2),
                          },
                          children: [
                            {'label': 'added_from'.tr, 'value': ctr.submission.value.username!},
                            {'label': 'priority'.tr, 'value': ctr.submission.value.priority},
                            {'label': 'date_used'.tr, 'value': DateFormat('dd MMMM yyyy').format(DateFormat('dd-MM-yyyy').parse(ctr.submission.value.dateUsed!))},
                          ].map((i) => TableRow(
                              children: [
                                Text(i['label'].toString(), style : const TextStyle(fontSize: 12,)),
                                const Text(':'),
                                Text((i['value'] ?? '') != '' ? i['value'].toString() : 'N/A',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ]
                          )).toList(),
                        ),
                        const Divider(height: 12,),
                        Text('description'.tr, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                        const Divider(height: 4,),
                        HtmlWidget(ctr.expand.value
                            ? ctr.submission.value.submissionDetail!
                            : ctr.submission.value.submissionDetail!.substring(0, 120),
                          textStyle: const TextStyle(fontSize: 12,),),
                        if(ctr.submission.value.submissionDetail!.length > 120) GestureDetector(
                          onTap: () => ctr.selectExpand(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(ctr.expand.value ? 'Lebih sedikit'.tr : 'Lainnya'.tr,
                                style: const TextStyle(fontSize: 12, color: Color(0xFF3f87b9)),),
                              const VerticalDivider(width: 4,),
                              RotationTransition(
                                turns: Tween(
                                  begin: 0.0,
                                  end: 1.0,
                                ).animate(ctr.animationController!),
                                child: const Icon(Icons.expand_more_outlined,
                                  color:Color(0xFF3f87b9),
                                  size: 22,),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 10),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Text('purchase'.tr,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Table(
                          columnWidths: const {
                            0: FlexColumnWidth(1),
                            // 1: FlexColumnWidth(0.1),
                            1: FlexColumnWidth(),
                          },
                          children: [
                            {'label': 'added_from'.tr, 'value': ctr.submission.value.username!},
                            {'label': 'priority'.tr, 'value': ctr.submission.value.priority},
                            {'label': 'date_used'.tr, 'value': DateFormat('dd MMMM yyyy').format(DateFormat('dd-MM-yyyy').parse(ctr.submission.value.dateUsed!))},
                          ].map((i) => TableRow(
                              children: [
                                Text(i['label'].toString(), style : const TextStyle(fontSize: 12,)),
                                // const Text(':'),
                                Text((i['value'] ?? '') != '' ? i['value'].toString() : 'N/A',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ]
                          )).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 10),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12, top: 10, bottom: 18),
                          child: Text('log_activity'.tr,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      ...ctr.logs.map((log) => IntrinsicHeight(
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 14),
                              width: 4,
                              color: Colors.blue.shade200,
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 11, right: 14, bottom: 10),
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF3f87b9),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 10, right: 10),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).brightness == Brightness.light
                                            ? Colors.white
                                            : const Color(0xFF272d34),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: const Color(0xFF3f87b9))
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(log.createdAt ?? 'N/A', style: const TextStyle(fontWeight: FontWeight.bold),),
                                        Text(log.translatedActivity!, style: const TextStyle(fontSize: 12),)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                      const Divider(height: 12,)
                    ],
                  ),
                )
              ],
            ),
          ) : skeletonDetailSubmission(),
          bottomNavigationBar: (ctr.submission.value.addedFromId != NavKey.user!.userId)
            ? (ctr.submission.value.step == 2 || ctr.submission.value.step == 5)
              ? Container(
                padding: const EdgeInsets.only(bottom: 20, top: 18),
                width: double.infinity,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : const Color(0xFF272d34),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 5),
                        child: ElevatedButton(
                            onPressed: () => ctr.reject(),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Color(0xFF3f87b9)),
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 20)
                            ),
                            child: Text('Rejected'.tr, style: const TextStyle(color: Color(0xFF3f87b9), fontWeight: FontWeight.bold),)
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12, left: 5),
                        child: ElevatedButton(
                            onPressed: () => ctr.approve(),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF3f87b9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 20)
                            ),
                            child: Text('yes,approved'.tr, style: const TextStyle(color: Colors.white),)
                        ),
                      ),
                    ),
                  ],
                ),
              )
              : (ctr.submission.value.step == 3)
                ? Container(
            padding: const EdgeInsets.only(bottom: 20, top: 18, left: 10, right: 10),
            width: double.infinity,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : const Color(0xFF272d34),
            child: ElevatedButton(
              onPressed: () => ctr.findSupplier(),
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3f87b9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 20),
              ),
              child: Text('find_supplier'.tr, style: const TextStyle(color: Colors.white),)
          ),
        )
                : (ctr.submission.value.step == 4)
                  ? Container(
            padding: const EdgeInsets.only(bottom: 20, top: 18, left: 10, right: 10),
            width: double.infinity,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : const Color(0xFF272d34),
            child: ElevatedButton(
                onPressed: () => ctr.chooseApprovedSupplier(),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3f87b9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
                child: Text('choose_approved_supplier'.tr, style: const TextStyle(color: Colors.white),)
            ),
          )
                  : (ctr.submission.value.step == 6)
                    ? Container(
            padding: const EdgeInsets.only(bottom: 20, top: 18, left: 10, right: 10),
            width: double.infinity,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : const Color(0xFF272d34),
            child: ElevatedButton(
                onPressed: () => ctr.createPurchaseOrder(),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3f87b9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
                child: Text('create_purchase_order'.tr, style: const TextStyle(color: Colors.white),)
            ),
          )
                    : (ctr.submission.value.step == 7) ? Container(
            padding: const EdgeInsets.only(bottom: 20, top: 18, left: 10, right: 10),
            width: double.infinity,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : const Color(0xFF272d34),
            child: ElevatedButton(
                onPressed: () => ctr.uploadInvoice(),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3f87b9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
                child: Text('upload_invoice'.tr, style: const TextStyle(color: Colors.white),)
            ),
          ) : null
            : null
        ));
      }
    );
  }
}
