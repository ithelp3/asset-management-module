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
        if(ctr.dataPo.value.status == 'On Process') colorStatus = Colors.blue;
        if(ctr.dataPo.value.status == 'Approve' || ctr.dataPo.value.status == 'Complete') colorStatus = Colors.green;
        if(ctr.dataPo.value.status == 'Rejected') colorStatus = Colors.red;
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
          body: ScrollConfiguration(
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
                                          child: Icon(ctr.dataPo.value.step == 2
                                              ? Icons.radio_button_checked
                                              : Icons.check_circle,
                                              color: Colors.blue
                                          )
                                      ),
                                      Text('submission_step_2'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 10, fontWeight: ctr.dataPo.value.step == 2 ? FontWeight.bold : FontWeight.normal),)
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
                                          child: Icon(ctr.dataPo.value.step == 3
                                              ? Icons.radio_button_checked
                                              : ctr.dataPo.value.step! < 3
                                              ? Icons.radio_button_off
                                              : Icons.check_circle,
                                            color: Colors.blue,)
                                      ),
                                      Text('submission_step_3'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 10, fontWeight: ctr.dataPo.value.step == 3 ? FontWeight.bold : FontWeight.normal),)
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
                                          child: Icon(ctr.dataPo.value.step == 4 || ctr.dataPo.value.step == 5
                                              ? Icons.radio_button_checked
                                              : ctr.dataPo.value.step! < 5
                                              ? Icons.radio_button_off
                                              : Icons.check_circle,
                                            color: Colors.blue,)
                                      ),
                                      Text('submission_step_4&5'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 10, fontWeight: ctr.dataPo.value.step == 4 || ctr.dataPo.value.step == 5 ? FontWeight.bold : FontWeight.normal),)
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
                                          child: Icon(ctr.dataPo.value.step == 6
                                              ? Icons.radio_button_checked
                                              : ctr.dataPo.value.step! < 6
                                              ? Icons.radio_button_off
                                              : Icons.check_circle,
                                            color: Colors.blue,
                                          )
                                      ),
                                      Text('submission_step_6'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 10, fontWeight: ctr.dataPo.value.step == 6 ? FontWeight.bold : FontWeight.normal),)
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
                                          child: Icon(ctr.dataPo.value.step == 0
                                              ? Icons.check_circle
                                              : ctr.dataPo.value.step! < 5
                                              ? Icons.radio_button_off
                                              : Icons.check_circle,
                                            color: Colors.blue,
                                          )
                                      ),
                                      Text('submission_step_0'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 10, fontWeight: ctr.dataPo.value.step == 0 ? FontWeight.bold : FontWeight.normal),)
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
                            Expanded(child: Text(ctr.dataPo.value.submissionId!,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                  color: colorStatus.shade50,
                                  borderRadius: BorderRadius.circular(4)
                              ),
                              child: Text(ctr.dataPo.value.status?.tr ?? '',
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
                            {'label': 'added_from'.tr, 'value': ctr.dataPo.value.username!},
                            {'label': 'priority'.tr, 'value': ctr.dataPo.value.priority},
                            {'label': 'date_used'.tr, 'value': DateFormat('dd MMMM yyyy').format(DateFormat('dd-MM-yyyy').parse(ctr.dataPo.value.dateUsed!))},
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
                            ? ctr.dataPo.value.submissionDetail!
                            : ctr.dataPo.value.submissionDetail!.substring(0, 120),
                          textStyle: const TextStyle(fontSize: 12,),),
                        if(ctr.dataPo.value.submissionDetail!.length > 120) GestureDetector(
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
                  margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
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
                                        Text('${log.translatedActivity} - ${log.fullName}', style: const TextStyle(fontSize: 12),)
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
          ),
        ));
      }
    );
  }
}
