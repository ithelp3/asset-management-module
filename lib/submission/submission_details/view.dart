import 'package:asset_management_module/component_widget/skeleton_submission.dart';
import 'package:asset_management_module/submission/submission_details/activity_logs.dart';
import 'package:asset_management_module/submission/submission_details/bottom_sheet.dart';
import 'package:asset_management_module/submission/submission_details/head_and_status.dart';
import 'package:asset_management_module/submission/submission_details/purchase.dart';
import 'package:asset_management_module/submission/submission_details/rejected.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                if(ctr.submissionDetails.value.status == 'Rejected') rejected(context, ctr),
                if(ctr.items.isNotEmpty) purchase(context, ctr),
                activityLog(context, ctr),
              ],
            ),
          ) : skeletonDetailSubmission(),
          bottomNavigationBar: ctr.progress.value ? null : (ctr.submissionDetails.value.status != 'Rejected')
            ? (ctr.submissionDetails.value.step == 2 || ctr.submissionDetails.value.step == 5)
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
              : (ctr.submissionDetails.value.step == 3 || ctr.submissionDetails.value.step == 4 || ctr.submissionDetails.value.step == 6)
                ? Container(
            padding: const EdgeInsets.only(bottom: 20, top: 18, left: 10, right: 10),
            width: double.infinity,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : const Color(0xFF272d34),
            child: ElevatedButton(
              onPressed: () {
                if(ctr.submissionDetails.value.step == 3) ctr.findSupplier('add');
                if(ctr.submissionDetails.value.step == 4) ctr.chooseApprovedSupplier();
                if(ctr.submissionDetails.value.step == 6) ctr.createPurchaseOrder();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3f87b9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 20),
              ),
              child: Text(ctr.submissionDetails.value.step == 3
                  ? 'find_supplier'.tr
                  : ctr.submissionDetails.value.step == 4
                      ? 'choose_approved_supplier'.tr
                      : 'create_purchase_order'.tr,
                style: const TextStyle(color: Colors.white),)
          ),
        )
                : (ctr.submissionDetails.value.step == 7 && ctr.purchase.value.status == 1) ? Container(
            padding: const EdgeInsets.only(bottom: 20, top: 18, left: 10, right: 10),
            width: double.infinity,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : const Color(0xFF272d34),
            child: ElevatedButton(
                onPressed: () => !ctr.showUploadInvoice.value
                    ? ctr.showUploadInvoice.value = !ctr.showUploadInvoice.value
                    : ctr.uploadInvoice(context),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3f87b9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
                child: Text(!ctr.showUploadInvoice.value ? 'upload_invoice'.tr : 'upload'.tr,
                  style: const TextStyle(color: Colors.white),)
            ),
          ) : null
            : Container(
            padding: const EdgeInsets.only(bottom: 20, top: 18, left: 10, right: 10),
            width: double.infinity,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : const Color(0xFF272d34),
            child: ElevatedButton(
                onPressed: () {
                  if(ctr.submissionDetails.value.step == 2) ctr.resubmission();
                  if(ctr.submissionDetails.value.step == 4 || ctr.submissionDetails.value.step == 5) ctr.findSupplier('edit');
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
          bottomSheet: ctr.showUploadInvoice.value
              ? bottomSheet(context, ctr)
              : null
        ));
      }
    );
  }
}