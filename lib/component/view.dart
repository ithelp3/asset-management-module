import 'package:asset_management_module/component/item.dart';
import 'package:asset_management_module/component_widget/skeleton_asset.dart';
import 'package:asset_management_module/model/component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ComponentPage extends StatelessWidget {
  const ComponentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ComponentController(),
      builder: (ctr) => Obx(() => Scaffold(
        appBar: AppBar(
            title: Text('component'.tr,),
            centerTitle: true,
            backgroundColor: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : const Color(0xFF272d34),
            leading: GestureDetector(
              onTap: () => Get.back(),
              child: const Icon(Icons.arrow_back_ios,)),
            bottom: PreferredSize(
              preferredSize: const Size(double.infinity, 80),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade300 : const Color(0xFF272d34)))
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'what_are_you_looking_for'.tr,
                    prefixIcon: Icon(Icons.search, color: Colors.grey.shade700, size: 22,),
                    fillColor: Theme.of(context).brightness == Brightness.light
                        ? const Color(0xFFE1EAF0)
                        : const Color(0xFF272d34),
                    suffixIcon: ctr.fieldSearch.value.value.text != '' ? GestureDetector(
                      onTap: () => ctr.clearSearch(),
                      child: Icon(Icons.highlight_remove_outlined, color: Colors.grey.shade700, size: 22,),
                    ) : null,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color(0xFF6DC0ED)
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: const TextStyle(fontSize: 14),
                  controller: ctr.fieldSearch.value,
                  onChanged: (value) => ctr.onSearch(value),
                ),
              ),
            )
        ),
        body: (!ctr.progress.value && ctr.components.isNotEmpty &&
            ctr.fieldSearch.value.value.text == '') ? RefreshIndicator(
            backgroundColor: Colors.white,
            child: ListView.builder(
              itemCount: ctr.components.length,
              itemBuilder: (context, index) {
                Component item = ctr.components[index];
                return itemComponent(context, ctr, item);
              },
            ),
            onRefresh: () async => ctr.onInit()
        ) : (!ctr.progress.value && ctr.componentSearch.isNotEmpty
            && ctr.fieldSearch.value.value.text != '') ? ListView.builder(
          itemCount: ctr.componentSearch.length,
          itemBuilder: (context, index) {
            Component item = ctr.componentSearch[index];
            return itemComponent(context, ctr, item);
          },
        ) : ctr.progress.value ?
        ListView.builder(
          itemCount: 8,
          itemBuilder: (context, idx) => skeletonAssetItem(),
        ) : Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/4),
          child: Column(
              children: [
                const Icon(Icons.folder_off_outlined, size: 80, color: Color(0xFF3f87b9),),
                const Divider(height: 10,),
                Text('no_data_available'.tr,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF3f87b9)),)
              ]
          ),
        ),
      ))
    );
  }
}
