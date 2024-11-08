import 'package:asset_management_module/submission/submission_details/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

Widget activityLog(BuildContext context, SubmissionDetailsController ctr) {
  return Card(
    margin: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 10),
    child: Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, top: 10, bottom: 18),
            child: Row(
              children: [
                const Icon(Icons.history_outlined, color: Color(0xFF3f87b9),),
                const VerticalDivider(width: 8,),
                Expanded(
                  child: Text('log_activity'.tr,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
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
                          HtmlWidget(log.translatedActivity!, textStyle: const TextStyle(fontSize: 12),),
                          // Text(log.translatedActivity!, style: const TextStyle(fontSize: 12),)
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
  );
}