import 'package:asset_management_module/submission/submission_details/controller.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Widget headAndStatus(BuildContext context, SubmissionDetailsController ctr) {
  MaterialColor colorStatus = Colors.brown;
  if(ctr.submission.value.status == 'On Process') colorStatus = Colors.blue;
  if(ctr.submission.value.status == 'Approved' || ctr.submission.value.status == 'Complete') colorStatus = Colors.green;
  if(ctr.submission.value.status == 'Rejected') colorStatus = Colors.red;
  return Card(
    margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RotationTransition(
                  turns: AlwaysStoppedAnimation(40 /360),
                  child: Icon(Icons.attach_file_outlined, color: Color(0xFF3f87b9),)),
              const VerticalDivider(width: 8,),
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
                      fontSize: 12,
                      color: colorStatus.shade700),),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(0.1),
              2: FlexColumnWidth(2),
            },
            children: [
              {'label': 'added_from'.tr, 'value': ctr.submission.value.username!},
              {'label': 'subject'.tr, 'value': ctr.submission.value.subject!},
              {'label': 'priority'.tr, 'value': ctr.submission.value.priority},
              {'label': 'date_used'.tr, 'value': DateFormat('dd MMMM yyyy').format(DateFormat('yyyy-MM-dd').parse(ctr.submission.value.dateUsed!))},
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
        ),
        if(ctr.expandHead.value) Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${'description'.tr} : ', style: const TextStyle(fontWeight: FontWeight.bold,),),
              const Divider(height: 4,),
              HtmlWidget(ctr.submission.value.submissionDetail!,
                textStyle: const TextStyle(fontSize: 12,),),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 12),
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
                            child: ctr.submission.value.step == 2 ? AvatarGlow(
                                startDelay: const Duration(milliseconds: 600),
                                glowColor: (ctr.submission.value.status == 'Rejected')
                                    ? Colors.red.shade200
                                    : Colors.blue.shade200,
                                animate: true,
                                curve: Curves.fastEaseInToSlowEaseOut,
                              child: CircleAvatar(
                                radius: 12,
                                child: Icon(ctr.submission.value.status != 'Rejected'
                                    ? Icons.radio_button_checked
                                    : Icons.highlight_remove_outlined,
                                    color: ctr.submission.value.status != 'Rejected' ? Colors.blue : Colors.red
                                ),
                              )
                            ) : const Icon(Icons.check_circle, color: Colors.blue,)
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
                            child: ctr.submission.value.step == 3
                                ? AvatarGlow(
                                startDelay: const Duration(milliseconds: 600),
                                glowColor: (ctr.submission.value.status == 'Rejected' && ctr.submission.value.step == 3)
                                    ? Colors.red.shade200
                                    : Colors.blue.shade200,
                                animate: true,
                                curve: Curves.fastEaseInToSlowEaseOut,
                                child: CircleAvatar(
                                  radius: 12,
                                  child: Icon( ctr.submission.value.status != 'Rejected'
                                      ? Icons.radio_button_checked
                                      : Icons.highlight_remove_outlined,
                                    color: (ctr.submission.value.status == 'Rejected' && ctr.submission.value.step == 3)
                                        ? Colors.red
                                        : Colors.blue,
                                  ),
                                )
                            ) : Icon(ctr.submission.value.step! > 3 || ctr.submission.value.step! == 0
                                ? Icons.check_circle
                                : Icons.radio_button_off,
                              color: Colors.blue,
                            )
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
                            padding: const EdgeInsets.only(left: 2, right: 2, bottom: 8, top: 0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: ctr.submission.value.step == 4 ? AvatarGlow(
                              startDelay: const Duration(milliseconds: 600),
                              glowColor: (ctr.submission.value.status == 'Rejected' && ctr.submission.value.step == 4)
                                  ? Colors.red.shade400
                                  : Colors.blue.shade400,
                              animate: true,
                              glowRadiusFactor: 0.6,
                              curve: Curves.fastEaseInToSlowEaseOut,
                              child: CircleAvatar(
                                radius: 12,
                                child: Icon( ctr.submission.value.status != 'Rejected'
                                    ? Icons.radio_button_checked
                                    : Icons.highlight_remove_outlined,
                                  color: (ctr.submission.value.status == 'Rejected' && ctr.submission.value.step == 4)
                                      ? Colors.red
                                      : Colors.blue,
                                ),
                              )
                            ) : Icon(ctr.submission.value.step! > 4 || ctr.submission.value.step! == 0
                                ? Icons.check_circle
                                : Icons.radio_button_off,
                              color: Colors.blue,
                            )
                        ),
                        Text('submission_step_4'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: ctr.submission.value.step! == 4
                                  ? FontWeight.bold
                                  : FontWeight.normal
                          ),)
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
                            child: ctr.submission.value.step == 5
                                ? AvatarGlow(
                                startDelay: const Duration(milliseconds: 600),
                                glowColor: Colors.blue.shade400,
                                animate: true,
                                glowRadiusFactor: 0.6,
                                curve: Curves.fastEaseInToSlowEaseOut,
                                child: const CircleAvatar(
                                  radius: 12,
                                  child: Icon(Icons.radio_button_checked, color: Colors.blue,
                                  ),
                                )
                            )
                                : Icon(ctr.submission.value.step! > 5 || ctr.submission.value.step! == 0
                                  ? Icons.check_circle
                                  : Icons.radio_button_off,
                              color: Colors.blue,
                            )
                        ),
                        Text('submission_step_5'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10, fontWeight: ctr.submission.value.step! == 5
                              ? FontWeight.bold
                              : FontWeight.normal
                          ),)
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
                            child: ctr.submission.value.step == 6 ? AvatarGlow(
                                startDelay: const Duration(milliseconds: 600),
                                glowColor: Colors.blue.shade400,
                                animate: true,
                                glowRadiusFactor: 0.6,
                                curve: Curves.fastEaseInToSlowEaseOut,
                                child: const CircleAvatar(
                                  radius: 12,
                                  child: Icon(Icons.radio_button_checked, color: Colors.blue,
                                  ),
                                )
                            ) : Icon((ctr.submission.value.step! > 6 || ctr.submission.value.step! == 0)
                                ? Icons.check_circle
                                : Icons.radio_button_off,
                              color: Colors.blue,
                            )
                        ),
                        Text('submission_step_6'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: (ctr.submission.value.step! > 6 || ctr.submission.value.step! == 0)
                                  ? FontWeight.bold
                                  : FontWeight.normal
                          ),)
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: GestureDetector(
            onTap: () => ctr.selectExpand('head'),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(ctr.expandHead.value ? 'Lebih sedikit'.tr : 'Lainnya'.tr,
                  style: const TextStyle(fontSize: 12, color: Color(0xFF3f87b9)),),
                const VerticalDivider(width: 4,),
                RotationTransition(
                  turns: Tween(
                    begin: 0.0,
                    end: 1.0,
                  ).animate(ctr.animationControllerRotation1!),
                  child: const Icon(Icons.expand_more_outlined,
                    color:Color(0xFF3f87b9),
                    size: 22,),
                )
              ],
            ),
          ),
        )
      ],
    ),
  );
}