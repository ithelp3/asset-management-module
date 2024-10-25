import 'package:asset_management_module/component_widget/skeleton_submission.dart';
import 'package:asset_management_module/model/submission_suppliers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ChooseApprovedSupplierPage extends StatelessWidget {
  const ChooseApprovedSupplierPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ChooseApprovedSupplierController(),
      builder: (ctr) => Scaffold(
        appBar: AppBar(
          title: Text('choose_supplier'.tr),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios,
              color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,),
          ),
        ),
        body: Obx(() => ctr.supplierData.value.id != null
            ? ScrollConfiguration(
          behavior: const ScrollBehavior(),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: Color(0xFF3f87b9), size: 26,),
                    const VerticalDivider(width: 10,),
                    Expanded(child: Text('info_choose_supplier'.tr,
                    ),),
                  ],
                ),
              ),
              ...ctr.supplierData.value.suppliers!.map((item) => RadioListTile(
                contentPadding: const EdgeInsets.only(right: 14, left: 2),
                dense: true,
                visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity,
                ),
                value: item,
                groupValue: ctr.selectedSupplier.value,
                onChanged: (selected) {
                  ctr.selectedSupplier.value = selected as SupplierRelations;
                },
                fillColor: const WidgetStatePropertyAll(Color(0xFF3f87b9)),
                title: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF3f87b9))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 8, top: 8),
                    child: Row(
                      children: [
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.supplierName ?? 'N/A', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                            const Divider(height: 8,),
                            Row(
                              children: [
                                Icon(Icons.file_copy_rounded, color: Colors.blue.shade400, size: 20,),
                                const VerticalDivider(width: 8,),
                                Expanded(
                                  child: Text(item.filename ?? 'N/A',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 12, height: 1, color: Colors.grey.shade600),),
                                ),
                              ],
                            )
                          ],
                        )),
                        IconButton(
                            onPressed: () {
                              ctr.downloadFile(item);
                            },
                            icon: const Icon(Icons.download, color: Color(0xFF3f87b9),)
                        ),
                      ],
                    ),
                  ),
                ),
              ))
            ],
          ),
        )
            : skeletonSelectedSupplier()
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(bottom: 30, top: 14, left: 10, right: 10),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : const Color(0xFF272d34)
          ),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)
                  ),
                  backgroundColor: const Color(0xFF3f87b9),
                  foregroundColor: Colors.white
              ),
              onPressed: () => ctr.save(),
              child: Text('save'.tr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
          ),
        ),
      )
    );
  }
}
