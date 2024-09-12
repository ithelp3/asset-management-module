import 'package:asset_management_module/asset/item.dart';
import 'package:asset_management_module/component_widget/skeleton_asset.dart';
import 'package:asset_management_module/home/controller.dart';
import 'package:asset_management_module/model/asset.dart';
import 'package:flutter/material.dart';

@override
Widget assets(BuildContext context, HomeController ctr) {
  return Scaffold(
    key: const ValueKey(1),
    body: CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text('Asset',),
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
                    hintText: 'Kamu lagi cari apa?',
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
                  style: const TextStyle(fontSize: 14),
                  controller: ctr.fieldSearchAsset.value,
                  // onChanged: (value) => ctr.onSearch(value),
                ),
              ),
            )
        ),
        if(!ctr.progressAsset.value) SliverList(delegate: SliverChildBuilderDelegate(
          childCount: ctr.assets.length,
          (context, index) {
            Asset item = ctr.assets[index];
            return itemAsset(context, ctr, item);
          },
        )) else SliverList(delegate: SliverChildBuilderDelegate(
          (context, idx) => skeletonAssetItem(),
          childCount: 8,
        ))
      ],
    ),
    floatingActionButton: Visibility(
      visible: !(MediaQuery.of(context).viewInsets.bottom != 0),
      child: FloatingActionButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40)
        ),
        backgroundColor: Color(0xFF3f87b9),
        child: const Icon(Icons.add, size: 30,),
      )
    ),
  );
}