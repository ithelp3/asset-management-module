import 'package:asset_management_module/asset/asset_details/view.dart';
import 'package:asset_management_module/home/controller.dart';
import 'package:asset_management_module/model/asset.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget itemAsset(BuildContext context, HomeController ctr, Asset item) {
  return GestureDetector(
    onTap: () => Get.to(const AssetDetailsPage(),
      routeName: '/assets/details',
      arguments: {
        'data': item
      },
      transition: Transition.rightToLeft
    ),
    child: Container(
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : const Color(0xFF272d34),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFF3f87b9))
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Image.network(item.pictures!.replaceAll('192.168.1.135:8400', 'asset.fingerspot.net',),
                    width: 90,
                    height: 60,
                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                      return Image.network('http://asset.fingerspot.net/images/pic.png',
                        width: 90,
                        height: 60,
                      );
                    },
                  ),
                ),
                const VerticalDivider(width: 10,),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name ?? 'N/A',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3f87b9)),),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        margin: const EdgeInsets.only(top: 2),
                        decoration: BoxDecoration(
                            color: const Color(0xFF3f87b9),
                            borderRadius: BorderRadius.circular(4)
                        ),
                        child: Text(item.statusName ?? 'N/A',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),))
                  ],
                )),
                PopupMenuButton(
                  itemBuilder: (ctx) => [
                    {'label': 'assign'.tr, 'icon': Icons.file_present_outlined},
                    {'label': 'edit'.tr, 'icon': Icons.edit},
                    {'label': 'delete'.tr, 'icon': Icons.delete_outline_outlined},
                  ].map((i) {
                    String label = i['label'].toString();
                    IconData icon = i['icon'] as IconData;
                    return PopupMenuItem(
                        onTap: () {
                          if(label == 'edit'.tr) ctr.assetAddEdit('edit', item);
                        },
                        child: Row(
                          children: [
                            Icon(icon, color: const Color(0xFF3f87b9),),
                            const VerticalDivider(width: 10,),
                            Text(label, style: const TextStyle(color: Color(0xFF3f87b9)),),
                          ],
                        )
                    );
                  }).toList(),
                  style: const ButtonStyle(
                    iconColor: WidgetStatePropertyAll(Color(0xFF3f87b9)),
                  ),
                  icon: const Icon(Icons.more_vert_outlined),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final boxWidth = constraints.constrainWidth();
                double dashWidth = 6;
                double dashHeight = 1;
                final dashCount = (boxWidth / (2 * dashWidth)).floor();
                return Flex(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  direction: Axis.horizontal,
                  children: List.generate(dashCount, (_) {
                    return SizedBox(
                      width: dashWidth,
                      height: dashHeight,
                      child: const DecoratedBox(
                        decoration: BoxDecoration(color: Colors.grey),
                      ),);
                  }),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(0.3),
                1: IntrinsicColumnWidth(),
                2: FlexColumnWidth(),
              },
              children: [
                {'label': 'Tag Asset', 'value': item.assetTag},
                {'label': 'Category', 'value': item.categoryName},
                {'label': 'Assignment', 'value': item.assign},
                {'label': 'Location', 'value': item.locations},
              ].map((i) => TableRow(
                  children: [
                    Text(i['label'].toString(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                    const Text(': '),
                    Text(i['value'] ?? 'N/A',
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 12),)
                  ]
              )).toList(),
            ),
          )
        ],
      ),
    ),
  );
}