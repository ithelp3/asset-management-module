import 'package:asset_management_module/account/account.dart';
import 'package:asset_management_module/asset/assets.dart';
import 'package:asset_management_module/dashboard/dashboard.dart';
import 'package:asset_management_module/depreciation/depreciation.dart';
import 'package:asset_management_module/home/controller.dart';
import 'package:asset_management_module/purchase_order/view.dart';
import 'package:asset_management_module/reminder/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder(
      init: HomeController(),
      builder: (ctr) {
        return Scaffold(
          primary: true,
          body: <Widget>[
            dashboard(context, ctr),
            assets(context, ctr),
            reminder(context, ctr),
            depreciation(context, ctr),
            account(context, ctr),
          ][ctr.navbarBottomIdx.value],
        bottomNavigationBar: Container(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : const Color(0xFF272d34),
          height: 70,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => ctr.selectNavbarBottomIdx(0),
                child: SizedBox(
                  width: width/5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.dashboard_customize_outlined,
                        color: ctr.navbarBottomIdx.value == 0
                            ? const Color(0xFF3f87b9)
                            : Theme.of(context).brightness == Brightness.light ? Colors.black45 : Colors.white,),
                      Text('dashboard'.tr,
                        style: TextStyle(
                          fontSize: 12,
                          color: ctr.navbarBottomIdx.value == 0
                              ? const Color(0xFF3f87b9)
                              : Theme.of(context).brightness == Brightness.light ? Colors.black45 : Colors.white
                        ),)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => ctr.selectNavbarBottomIdx(1),
                child: SizedBox(
                  width: width/5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.feed_outlined,
                        color: ctr.navbarBottomIdx.value == 1
                            ? const Color(0xFF3f87b9)
                            : Theme.of(context).brightness == Brightness.light ? Colors.black45 : Colors.white,),
                      Text('asset'.tr,
                        style: TextStyle(
                          fontSize: 12,
                          color: ctr.navbarBottomIdx.value == 1
                              ? const Color(0xFF3f87b9)
                              : Theme.of(context).brightness == Brightness.light ? Colors.black45 : Colors.white
                        ),)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => ctr.selectNavbarBottomIdx(2),
                child: SizedBox(
                  width: width/5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.notifications,
                        color: ctr.navbarBottomIdx.value == 2
                            ? const Color(0xFF3f87b9)
                            : Theme.of(context).brightness == Brightness.light ? Colors.black45 : Colors.white,),
                      Text('reminder'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: ctr.navbarBottomIdx.value == 2
                              ? const Color(0xFF3f87b9)
                              : Colors.black45
                        ),)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => ctr.selectNavbarBottomIdx(3),
                child: SizedBox(
                  width: width/5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calculate_outlined,
                        color: ctr.navbarBottomIdx.value == 3
                            ? const Color(0xFF3f87b9)
                            : Theme.of(context).brightness == Brightness.light ? Colors.black45 : Colors.white,),
                      Text('depreciation'.tr,
                        style: TextStyle(
                          fontSize: 12,
                          color: ctr.navbarBottomIdx.value == 3
                              ? const Color(0xFF3f87b9)
                              : Theme.of(context).brightness == Brightness.light ? Colors.black45 : Colors.white
                        ),)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => ctr.selectNavbarBottomIdx(4),
                child: SizedBox(
                  width: width/5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person,
                        color: ctr.navbarBottomIdx.value == 4
                            ? const Color(0xFF3f87b9)
                            : Theme.of(context).brightness == Brightness.light ? Colors.black45 : Colors.white,),
                      Text('account'.tr,
                        style: TextStyle(
                          fontSize: 12,
                          color: ctr.navbarBottomIdx.value == 4
                              ? const Color(0xFF3f87b9)
                              : Theme.of(context).brightness == Brightness.light ? Colors.black45 : Colors.white
                        ),)
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      );
      }
    );
  }
}
