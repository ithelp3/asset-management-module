import 'package:asset_management_module/monitoring/controller.dart';
import 'package:asset_management_module/purchase_order/purchase_details/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_file_selector/flutter_web_file_selector.dart';
import 'package:get/get.dart';

Widget bottomSheet(BuildContext context, MonitoringController ctr) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        padding: const EdgeInsets.only(left: 16, right: 18, top: 10, bottom: 10),
        decoration: BoxDecoration(
            border: Border.symmetric(horizontal: BorderSide(color: Colors.blue.shade400)) ,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24)
            ),
            color: Colors.blue.shade50
        ),
        child: Row(children: [
          GestureDetector(
              onTap: () => ctr.showUploadInvoice.value = !ctr.showUploadInvoice.value,
              child: const Icon(Icons.close, size: 20,)),
          const VerticalDivider(width: 8,),
          Expanded(child: Text('upload_invoice'.tr)),
        ],),
      ),
      Container(
        width: double.infinity,
        height: 100,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        margin: const EdgeInsets.only(left: 12, right: 12, top: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF3f87b9))
        ),
        child: ctr.file == null ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(ctr.file == null) WebFileSelector(
              onData: (files) => ctr.setFile(files),
              multiple: false,
              accept: '.pdf, .doc, .docx, .xls, .xlsx, .jpeg, .png, .jpg',
              child: const Icon(Icons.add,
                color: Color(0xFF3f87b9),
                size: 20,
              ),
            ),
            const VerticalDivider(width: 6,),
            if(ctr.file == null) WebFileSelector(
                onData: (files) => ctr.setFile(files),
                multiple: false,
                accept: '.pdf, .doc, .docx, .xls, .xlsx, .jpeg, .png, .jpg',
                child: Text('choose_file'.tr,
                  style: const TextStyle(color: Color(0xFF3f87b9)),)
            ),
          ],
        ) : WebFileSelector(
          onData: (files) => ctr.setFile(files),
          multiple: false,
          accept: '.pdf, .doc, .docx, .xls, .xlsx, .jpeg, .png, .jpg',
          child: Text(ctr.file!.name,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Color(0xFF3f87b9)),),
        ),
      ),
    ],
  );
}