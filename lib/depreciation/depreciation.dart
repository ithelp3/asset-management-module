import 'package:asset_management_module/component_widget/skeleton_depreciation.dart';
import 'package:asset_management_module/depreciation/item.dart';
import 'package:asset_management_module/home/controller.dart';
import 'package:asset_management_module/model/depreciation.dart';
import 'package:flutter/material.dart';

Widget depreciation(BuildContext context, HomeController ctr) {
  return Scaffold(
    key: const ValueKey(3),
    body: CustomScrollView(
      slivers: [
        SliverAppBar(
            title: Text('Depreciation',),
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
                  controller: ctr.fieldSearchDep.value,
                  onChanged: (value) => ctr.onSearchDep(value),
                ),
              ),
            )
        ),
        if(!ctr.progressDep.value && (ctr.depreciationSearch.isNotEmpty || ctr.depreciations.isNotEmpty)) SliverList(delegate: SliverChildBuilderDelegate(
          childCount: ctr.depreciationSearch.isEmpty
              ? ctr.depreciations.length
              : ctr.depreciationSearch.length,
              (context, index) {
            Depreciation item = ctr.depreciationSearch.isEmpty
                ? ctr.depreciations[index]
                : ctr.depreciationSearch[index];
            return itemDepreciation(context, ctr, item);
          },
        )) else if(ctr.progressDep.value) SliverList(delegate: SliverChildBuilderDelegate(
            (context, index) => skeletonDepreciationItem(),
            childCount: 8
        )) else const SliverToBoxAdapter(
          child: Column(
            children: [
              Icon(Icons.folder_off_outlined),
              Text('data is empty', style: TextStyle(fontWeight: FontWeight.bold),)
            ]
          ),
        )
      ],
    ),
    floatingActionButton: Visibility(
        visible: !(MediaQuery.of(context).viewInsets.bottom != 0),
        child: FloatingActionButton(
          onPressed: () {},
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40)
          ),
          backgroundColor: const Color(0xFF3f87b9),
          child: const Icon(Icons.add, size: 30,),
        )
    ),
  );
}