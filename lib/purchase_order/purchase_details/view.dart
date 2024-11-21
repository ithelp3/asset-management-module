import 'package:asset_management_module/component_widget/skeleton_submission.dart';
import 'package:asset_management_module/purchase_order/purchase_details/bottom_sheet.dart';
import 'package:asset_management_module/purchase_order/purchase_details/invoice.dart';
import 'package:asset_management_module/purchase_order/purchase_details/purchase.dart';
import 'package:asset_management_module/purchase_order/purchase_details/subject.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class PurchaseDetailsPage extends StatelessWidget {
  const PurchaseDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PurchaseDetailsController(),
      builder: (ctr) => Obx(() => Scaffold(
        appBar: AppBar(
          title: Text('purchase_details'.tr),
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
                subject(context, ctr),
                purchase(context, ctr),
                if((ctr.purchase.value.fileName ?? '' )!= '' && (ctr.purchase.value.fileUrl ?? '' ) != '') invoice(context, ctr),
              ],
            )
        ) : skeletonDetailSubmission(),
        bottomNavigationBar: ctr.purchase.value.status == 1
            ? Container(
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
        )
            : null,
        bottomSheet: ctr.showUploadInvoice.value
            ? bottomSheet(context, ctr)
            : null,
      ))
    );
  }
}
