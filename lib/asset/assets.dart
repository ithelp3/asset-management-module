import 'package:asset_management_module/asset/item.dart';
import 'package:asset_management_module/component_widget/skeleton_asset.dart';
import 'package:asset_management_module/home/controller.dart';
import 'package:asset_management_module/model/asset.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

@override
Widget assets(BuildContext context, HomeController ctr) {
  return Scaffold(
    key: const ValueKey(1),
    appBar: AppBar(
        title: Text('asset'.tr,),
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
                border: Border(bottom: BorderSide(color: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade300 : const Color(0xFF272d34)))
            ),
            child: TextFormField(
              enableInteractiveSelection: false,
              decoration: InputDecoration(
                hintText: 'what_are_you_looking_for'.tr,
                prefixIcon: Icon(Icons.search, color: Colors.grey.shade700, size: 22,),
                fillColor: Theme.of(context).brightness == Brightness.light
                    ? const Color(0xFFE1EAF0)
                    : const Color(0xFF272d34),
                suffixIcon: ctr.fieldSearchAsset.value.value.text != '' ? GestureDetector(
                  onTap: () => ctr.clearSearchAsset(),
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
              controller: ctr.fieldSearchAsset.value,
              onChanged: (value) => ctr.onSearchAsset(value),
            ),
          ),
        )
    ),
    body: (!ctr.progressAsset.value && ctr.assets.isNotEmpty &&
        ctr.fieldSearchAsset.value.value.text == '') ? RefreshIndicator(
        backgroundColor: Colors.white,
        child: ListView.builder(
          itemCount: ctr.assets.length,
          itemBuilder: (context, index) {
            Asset item = ctr.assets[index];
            return itemAsset(context, ctr, item);
          },
        ),
        onRefresh: () async => ctr.getAssets()
    ) : (!ctr.progressAsset.value && ctr.assetSearch.isNotEmpty
        && ctr.fieldSearchAsset.value.value.text != '') ? ListView.builder(
      itemCount: ctr.assetSearch.length,
      itemBuilder: (context, index) {
        Asset item = ctr.assetSearch[index];
        return itemAsset(context, ctr, item);
      },
    ) : ctr.progressAsset.value ?
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
    floatingActionButton: Visibility(
      visible: !(MediaQuery.of(context).viewInsets.bottom != 0),
      child: FloatingActionButton(
        onPressed: () => ctr.assetAddEdit('add', null),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40)
        ),
        backgroundColor: const Color(0xFF3f87b9),
        child: const Icon(Icons.add, size: 34, color: Colors.white,),
      )
    ),
  );
}