import 'package:asset_management_module/component_widget/skeleton_submission.dart';
import 'package:asset_management_module/submission/submission_details/activity_logs.dart';
import 'package:asset_management_module/submission/submission_details/head_and_status.dart';
import 'package:asset_management_module/submission/submission_details/rejected.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/data/nav_key.dart';
import 'controller.dart';

class SubmissionDetailsPage extends StatelessWidget {
  const SubmissionDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SubmissionDetailsController(),
      builder: (ctr) {
        return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text('submission_details'.tr),
            centerTitle: true,
            leading: IconButton(
              onPressed: () => Get.back(result: true),
              icon: Icon(Icons.arrow_back_ios,
                color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,),
            ),
          ),
          body: !ctr.progress.value ? ScrollConfiguration(
            behavior: const ScrollBehavior(),
            child: ListView(
              children: [
                headAndStatus(context, ctr),
                if(ctr.submission.value.status == 'Rejected') rejected(context, ctr),
                activityLog(context, ctr),
              ],
            ),
          ) : skeletonDetailSubmission(),
          bottomNavigationBar: ctr.progress.value ? null : (ctr.submission.value.status != 'Rejected')
            ? ((ctr.submission.value.step == 2 && NavKey.user!.approverLevel1!.contains(NavKey.user!.userId))
              || (ctr.submission.value.step == 5 && NavKey.user!.approverLevel3!.contains(NavKey.user!.userId)))
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
              : (ctr.submission.value.step == 3 || (ctr.submission.value.step == 4 && NavKey.user!.approverLevel2!.contains(NavKey.user!.userId)) || ctr.submission.value.step == 6)
                ? Container(
            padding: const EdgeInsets.only(bottom: 20, top: 18, left: 10, right: 10),
            width: double.infinity,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : const Color(0xFF272d34),
            child: ElevatedButton(
              onPressed: () {
                if(ctr.submission.value.step == 3) ctr.findSupplier('add');
                if(ctr.submission.value.step == 4) ctr.chooseApprovedSupplier();
                if(ctr.submission.value.step == 6) ctr.createPurchaseOrder();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3f87b9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 20),
              ),
              child: Text(ctr.submission.value.step == 3
                  ? 'find_supplier'.tr
                  : ctr.submission.value.step == 4
                      ? 'choose_approved_supplier'.tr
                      : 'create_purchase_order'.tr,
                style: const TextStyle(color: Colors.white),)
          ),
        )
                : null
            : Container(
            padding: const EdgeInsets.only(bottom: 20, top: 18, left: 10, right: 10),
            width: double.infinity,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : const Color(0xFF272d34),
            child: ElevatedButton(
                onPressed: () {
                  if(ctr.submission.value.step == 2) ctr.resubmission();
                  if(ctr.submission.value.step == 4 || ctr.submission.value.step == 5) ctr.findSupplier('edit');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF04747),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
                child: Text('resubmission'.tr,
                  style: const TextStyle(color: Colors.white),)
            ),
          ),
        ));
      }
    );
  }
}