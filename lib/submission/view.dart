import 'package:asset_management_module/component_widget/skeleton_submission.dart';
import 'package:asset_management_module/model/submission.dart';
import 'package:asset_management_module/submission/submission_details/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'controller.dart';

class SubmissionPage extends StatelessWidget {
  const SubmissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SubmissionController(),
      builder: (ctr) => Obx(() => Scaffold(
        appBar: AppBar(
          title: Text('submission'.tr),
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : const Color(0xFF272d34),
          leading: IconButton(
            onPressed: () => Get.back(result: true),
            icon: Icon(Icons.arrow_back_ios,
              color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,),
          ),
          centerTitle: true,
        ),
        body: ScrollConfiguration(
          behavior: const ScrollBehavior(),
          child: ctr.progress.value
            ? skeletonSubmissionItem()
            : ListView.builder(
              itemCount: ctr.submissions.length,
              itemBuilder: (ctx, idx) {
                Submission i = ctr.submissions[idx];
                MaterialColor colorStatus = Colors.brown;
                if(i.status == 'On Process') colorStatus = Colors.blue;
                if(i.status == 'Approved' || i.status == 'Complete') colorStatus = Colors.green;
                if(i.status == 'Rejected') colorStatus = Colors.red;
                return Container(
                  margin: EdgeInsets.only(top: 8, left: 12, right: 12, bottom: idx+1 == ctr.submissions.length ? 20 : 0),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue.shade100),
                      boxShadow: [BoxShadow(
                        color: Colors.blue.withOpacity(0.1),
                        blurRadius: 2,
                        spreadRadius: 2,
                        offset: const Offset(1, 2),
                      )]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.yellow.shade100
                            ),
                            child: Icon(Icons.data_exploration,
                              color: Colors.yellow.shade700,
                              size: 24,
                            ),
                          ),
                          Expanded(child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(i.submissionId ?? '',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                                color: colorStatus.shade50,
                                borderRadius: BorderRadius.circular(4)
                            ),
                            child: Text(i.status?.tr ?? '',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: colorStatus.shade700),),
                          ),
                        ],
                      ),
                      Divider(color: Colors.blue.shade100,),
                      Padding(
                        padding: const EdgeInsets.only(left: 2, bottom: 8, top: 8),
                        child: Table(
                          columnWidths: {
                            0: FlexColumnWidth((i.status == null) ? 1 : 1.2),
                            1: const FlexColumnWidth(0.1),
                            2: const FlexColumnWidth(2),
                          },
                          children: [
                            {'label': 'added_from'.tr, 'value': i.username ?? 'N/A'},
                            {'label': 'subject'.tr, 'value': i.subject ?? 'N/A'},
                            {'label': 'priority'.tr, 'value': i.priority ?? 'N/A'},
                            {'label': 'date_used'.tr, 'value': DateFormat('dd MMMM yyyy').format(DateFormat('dd-MM-yyyy').parse(i.dateUsed!))},
                          ].map((i) => TableRow(
                              children: [
                                Text(i['label'].toString(), style : const TextStyle(fontSize: 12, height: 1.2)),
                                const Text(':', style: TextStyle(height: 1.2),),
                                Text((i['value'] ?? '') != '' ? i['value'].toString() : 'N/A',
                                   textAlign: TextAlign.left,
                                  style: const TextStyle(fontSize: 12, height: 1.2),
                                ),
                              ]
                          )).toList(),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () => Get.to(const SubmissionDetailsPage(),
                                arguments: {
                                  'id': i.id
                                },
                                routeName: '/submission/details'
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF3f87b9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.zero
                            ),
                            child: Text('details'.tr, style: const TextStyle(color: Colors.white),)
                        ),
                      )
                    ],
                  ),
                );
              }
          ),
        ),
        floatingActionButton: Visibility(
            visible: !(MediaQuery.of(context).viewInsets.bottom != 0),
            child: FloatingActionButton(
              onPressed: () => ctr.addSubmission(context),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)
              ),
              backgroundColor: const Color(0xFF3f87b9),
              child: const Icon(Icons.add, size: 34, color: Colors.white,),
            )
        ),
      ))
    );
  }
}
