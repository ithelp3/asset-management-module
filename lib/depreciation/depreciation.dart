import 'package:asset_management_module/component_widget/skeleton_depreciation.dart';
import 'package:asset_management_module/depreciation/item.dart';
import 'package:asset_management_module/home/controller.dart';
import 'package:asset_management_module/model/depreciation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget depreciation(BuildContext context, HomeController ctr) {
  return Scaffold(
    key: const ValueKey(3),
    appBar: AppBar(
        title: Text('depreciation'.tr,),
        centerTitle: true,
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : const Color(0xFF272d34),
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 80),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Colors.grey.shade300))
            ),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'what_are_you_looking_for'.tr,
                prefixIcon: Icon(Icons.search, color: Colors.grey.shade700, size: 22,),
                fillColor: const Color(0xFFE1EAF0),
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
              controller: ctr.fieldSearchDep.value,
              onChanged: (value) => ctr.onSearchDep(value),
            ),
          ),
        )
    ),
    body: (!ctr.progressDep.value && ctr.depreciations.isNotEmpty &&
        ctr.fieldSearchDep.value.value.text == '') ? RefreshIndicator(
        backgroundColor: Colors.white,
        child: ListView.builder(
          itemCount:  ctr.depreciations.length,
          itemBuilder: (context, index) {
            Depreciation item = ctr.depreciations[index];
            return itemDepreciation(context, ctr, item);
          },
        ),
        onRefresh: () async => ctr.getDepreciations()
    ) : (!ctr.progressDep.value &&( ctr.depreciationSearch.isNotEmpty && ctr.fieldSearchDep.value.value.text != '')) ? ListView.builder(
          itemCount: ctr.depreciationSearch.length,
          itemBuilder: (context, index) {
            Depreciation item = ctr.depreciationSearch[index];
            return itemDepreciation(context, ctr, item);
          }
        ) : ctr.progressDep.value ? ListView.builder(
            itemBuilder: (context, index) => skeletonDepreciationItem(),
            itemCount: 8
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
    floatingActionButton: Visibility(
        visible: !(MediaQuery.of(context).viewInsets.bottom != 0),
        child: FloatingActionButton(
          onPressed: () => ctr.addEditDep('add', null),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40)
          ),
          backgroundColor: const Color(0xFF3f87b9),
          child: const Icon(Icons.add, size: 30,),
        )
    ),
  );
}