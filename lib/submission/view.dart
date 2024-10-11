import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'controller.dart';

class SubmissionPage extends StatelessWidget {
  const SubmissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SubmissionController(),
      builder: (ctr) {
        print('~~ ${ctr.dataPo.value.step}');
        MaterialColor colorStatus = Colors.brown;
        if(ctr.dataPo.value.status == 'On Process') colorStatus = Colors.blue;
        if(ctr.dataPo.value.status == 'Approve' || ctr.dataPo.value.status == 'Complete') colorStatus = Colors.green;
        if(ctr.dataPo.value.status == 'Rejected') colorStatus = Colors.red;
        return Scaffold(
          appBar: AppBar(
            title: Text(ctr.dataPo.value.submissionId!),
            titleTextStyle: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.arrow_back_ios,
                color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,),
            ),
            actions: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                margin: const EdgeInsets.only(right: 18),
                decoration: BoxDecoration(
                    color: colorStatus.shade50,
                    borderRadius: BorderRadius.circular(4)
                ),
                child: Text(ctr.dataPo.value.status?.tr ?? '',
                  style: TextStyle(
                      fontSize: 12,
                      color: colorStatus.shade700),),
              )
            ],
          ),
          body: Column(
            children: [
              Card(
                margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, top: 10, bottom: 14),
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
                                      padding: const EdgeInsets.all(2),
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
                                      style: TextStyle(fontSize: 10),)
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width/6,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(2),
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
                                      style: TextStyle(fontSize: 10),)
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width/6,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(2),
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
                                      style: TextStyle(fontSize: 10),)
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width/6,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(2),
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
                                      style: TextStyle(fontSize: 10),)
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                width: MediaQuery.of(context).size.width/6,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(2),
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
                                      style: TextStyle(fontSize: 10),)
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
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, top: 10, bottom: 14),
                        child: Text('tracking'.tr,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                  ],
                ),
              )
              // Container(
              //   color: Colors.white,
              //   child: Column(
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 14),
              //         child: Row(
              //           children: [
              //             Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text(ctr.dataPo.value.username!,
              //                   textAlign: TextAlign.left,
              //                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              //                 Text('${ctr.dataPo.value.priority!}, ${DateFormat('dd MMMM yyyy').format(DateFormat('dd-MM-yyyy').parse(ctr.dataPo.value.dateUsed!))}',
              //                   style: TextStyle(fontSize: 12),
              //                 ),
              //                 // Text(DateFormat('dd MMMM yyyy').format(DateFormat('dd-MM-yyyy').parse(ctr.dataPo.value.dateUsed!)),
              //                 //   style: TextStyle(fontWeight: FontWeight.bold),),
              //               ],
              //             ),
              //           ],
              //         ),
              //       ),
              //       const Divider(height: 10,),
              //       Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 14),
              //         child: HtmlWidget(ctr.dataPo.value.submissionDetail ?? '',
              //           textStyle: const TextStyle(fontSize: 12),),
              //       ),
              //       // const Divider(height: 10,),
              //       // Table(
              //       //   columnWidths: const {
              //       //     0: FlexColumnWidth(1),
              //       //     1: FlexColumnWidth(),
              //       //   },
              //       //   border: TableBorder(
              //       //       horizontalInside: BorderSide(color: Colors.grey.shade200),
              //       //       bottom: BorderSide(color: Colors.grey.shade200)
              //       //   ),
              //       //   children: [
              //       //     {'label': 'added_from'.tr, 'value': ctr.dataPo.value.username},
              //       //     {'label': 'priority'.tr, 'value': ctr.dataPo.value.priority},
              //       //     {'label': 'date_used'.tr, 'value': DateFormat('dd MMMM yyyy').format(DateFormat('dd-MM-yyyy').parse(ctr.dataPo.value.dateUsed!))},
              //       //   ].map((i) => TableRow(
              //       //       children: [
              //       //         Padding(
              //       //           padding: const EdgeInsets.only(top: 2, bottom: 2, left: 14, right: 14),
              //       //           child: Text(i['label'].toString()),
              //       //         ),
              //       //         Padding(
              //       //           padding: const EdgeInsets.only(top: 2, bottom: 2, left: 14, right: 14),
              //       //           child: Text((i['value'] ?? '') != '' ? i['value'].toString() : 'N/A',
              //       //             textAlign: TextAlign.right,
              //       //           ),
              //       //         ),
              //       //       ]
              //       //   )).toList(),
              //       // ),
              //     ],
              //   ),
              // ),
              // Container(
              //   color: Colors.white,
              //   child: TabBar(
              //       controller: ctr.tabController,
              //       dividerColor: Colors.transparent,
              //       tabs: ['tracking'.tr, 'log_activity'.tr].map((i) => Tab(
              //         child: Text(i),
              //       )).toList()
              //   ),
              // )
            ],
          ),
      );
      }
    );
  }
}
