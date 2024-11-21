import 'package:asset_management_module/purchase_order/purchase_details/controller.dart';
import 'package:flutter/material.dart';

Widget invoice(BuildContext context, PurchaseDetailsController ctr) {
  return Card(
    margin: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 10, left: 12),
          child: Row(
            children: [
              Icon(Icons.description_outlined, color: Color(0xFF3f87b9),),
              VerticalDivider(width: 8,),
              Expanded(
                child: Text('Invoice',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6, left: 14, bottom: 12),
          child: Row(
            children: [
              Expanded(child: Padding(
                padding: const EdgeInsets.only(right: 2, left: 4),
                child: Text(ctr.purchase.value.fileName!,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, height: 1.2),),
              )),
              IconButton(
                  onPressed: () => ctr.downloadFile(),
                  icon: const Icon(Icons.file_download, color: Color(0xFF3f87b9))
              )
            ],
          ),
        ),
      ],
    ),
  );
}