import 'package:asset_management_module/dashboard/dashboard_menu.dart';
import 'package:asset_management_module/dashboard/dashboard_monitoring.dart';
import 'package:asset_management_module/dashboard/dashboard_recent.dart';
import 'package:asset_management_module/home/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:js' as js;

@override
Widget dashboard(BuildContext context, HomeController ctr) {
  return Scaffold(
    key: const ValueKey(0),
    appBar: AppBar(
      title: Text('asset_management'.tr,
        style: const TextStyle(fontSize: 18,),
      ),
      centerTitle: true,
      leading: GestureDetector(
          onTap: () {
            js.context.callMethod('backToMainApp');
          },
          child: const Icon(Icons.arrow_back_ios, color: Colors.black,)),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Container(
          height: 56,
          color: const Color(0xFF3f87b9),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Icon(Icons.home_work_outlined, color: Colors.white, size: 26,),
              ),
              Expanded(
                child: Text(ctr.user.company ?? '',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
              ),
            ],
          ),
        )
      ),
    ),
    body:  Obx(() => ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: ListView(
          children: [
            dashboardMenu(context, ctr),
            dashboardRecent(context, ctr),
            dashboardMonitoring(context, ctr)
          ],
        ),
      // )
    ))
  );
}