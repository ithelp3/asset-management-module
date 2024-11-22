import 'package:asset_management_module/home/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget dashboardMenu(BuildContext context, HomeController ctr) {
  return Column(
    children: [
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 14, top: 14),
        child: Text('menu'.tr,
          // textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 20,),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 0,
          mainAxisSpacing: 10,
          crossAxisCount: 4,
          childAspectRatio: 1,
          children: [
            {'label': 'purchase'.tr, 'icon': Icons.assignment_rounded},
            {'label': 'lending'.tr, 'icon': Icons.real_estate_agent_rounded},
            {'label': 'maintenance'.tr, 'icon': Icons.construction_outlined},
            // {'label': 'reminder'.tr, 'icon': Icons.notifications_active_outlined},
            {'label': 'component'.tr, 'icon': Icons.interests_outlined},
            {'label': 'submission'.tr, 'icon': Icons.data_exploration},
            {'label': 'staff'.tr, 'icon': Icons.supervisor_account_sharp},
            {'label': 'supplier'.tr, 'icon': Icons.trolley},
            {'label': 'brand'.tr, 'icon': Icons.discount},
          ].map((i) {
            IconData icon = i['icon'] as IconData;
            String label = i['label'].toString();
            return GestureDetector(
              onTap: () => ctr.selectItemIcon(context, label),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8,),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40),
                            boxShadow: [BoxShadow(
                              color: Colors.blue.withOpacity(0.2),
                              blurRadius: 4,
                              spreadRadius: 2,
                              offset: const Offset(2, 4),
                            )]
                        ),
                        child: Icon(icon, size: 34, color: const Color(0xFF3f87b9),)),
                    Text(label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    ],
  );
}