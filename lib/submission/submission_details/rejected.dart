import 'package:asset_management_module/submission/submission_details/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget rejected(BuildContext context, SubmissionDetailsController ctr) {
  return Card(
    margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
    color: Colors.yellow.shade100,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('reason'.tr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          const Divider(height: 6,),
          Text(ctr.submission.value.reason ?? 'N/A', style: const TextStyle(fontSize: 12),),
        ],
      ),
    ),
  );
}