import 'dart:async';

import 'package:asset_management_module/Model/pwa.dart';
import 'package:asset_management_module/Model/user_auth.dart';
import 'package:asset_management_module/home/view.dart';
import 'package:asset_management_module/unauthorize/view.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:asset_management_module/utils/data/nav_key.dart';
import 'package:asset_management_module/utils/themes/dart.dart';
import 'package:asset_management_module/utils/themes/light.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  dynamic response;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    response = await DioClient().post('/login',
      params: {
        'data' : NavKey.data
      }
    );

    Timer(const Duration(milliseconds: 100), () {
      if(response?['success'] ?? false ) {
        NavKey.user = UserAuth.fromJson(response['data']);
        NavKey.pwa = Pwa.fromJson(response['pwa']);

        if(NavKey.pwa!.language!.toLowerCase() == 'en') {
          Get.updateLocale(const Locale('en', 'US'));
        } else {
          Get.updateLocale(const Locale('id', 'ID'));
        }

        if(NavKey.pwa!.theme!.toLowerCase() == 'light') {
          Get.changeTheme(lightTheme);
        } else {
          Get.changeTheme(darkTheme);
        }

        Get.off(const HomePage(),
          routeName: '/home'
        );

      } else {
        Get.off(const UnauthorizePage(),
          arguments: {
            'data': 'unauthorized'.tr
          },
          routeName: '/unauthorized'
        );
      }
    });

  }
}
