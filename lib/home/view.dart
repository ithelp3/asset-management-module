import 'package:asset_management_module/dashboard/dashboard.dart';
import 'package:asset_management_module/home/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder(
      init: HomeController(),
      builder: (ctr) => Obx(() => Scaffold(
        body: [
          dashboard(context, ctr),
          Text('asset'),
          Text('reminder'),
          Text('depresiasi'),
          Text('akun'),
        ][ctr.navbarBottomIdx.value],
        bottomNavigationBar: Container(
          color: Colors.white,
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
                            : Colors.black45,),
                      Text('dashboard',
                        style: TextStyle(
                          fontSize: 12,
                          color: ctr.navbarBottomIdx.value == 0
                              ? const Color(0xFF3f87b9)
                              : Colors.black45
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
                      Icon(Icons.assignment_outlined,
                        color: ctr.navbarBottomIdx.value == 1
                            ? const Color(0xFF3f87b9)
                            : Colors.black45,),
                      Text('asset',
                        style: TextStyle(
                          fontSize: 12,
                          color: ctr.navbarBottomIdx.value == 1
                              ? const Color(0xFF3f87b9)
                              : Colors.black45
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
                      Icon(Icons.notifications_active_outlined,
                        color: ctr.navbarBottomIdx.value == 2
                            ? const Color(0xFF3f87b9)
                            : Colors.black45,),
                      Text('reminder',
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
                            : Colors.black45,),
                      Text('depreciation',
                        style: TextStyle(
                          fontSize: 12,
                          color: ctr.navbarBottomIdx.value == 3
                              ? const Color(0xFF3f87b9)
                              : Colors.black45
                        ),)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => ctr.selectNavbarBottomIdx(4),
                child: Container(
                  width: width/5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person,
                        color: ctr.navbarBottomIdx.value == 4
                            ? const Color(0xFF3f87b9)
                            : Colors.black45,),
                      Text('akun',
                        style: TextStyle(
                          fontSize: 12,
                          color: ctr.navbarBottomIdx.value == 4
                              ? const Color(0xFF3f87b9)
                              : Colors.black45
                        ),)
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ))
    );
  }
}
