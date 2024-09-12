import 'dart:async';

import 'package:asset_management_module/Model/pwa.dart';
import 'package:asset_management_module/Model/user_auth.dart';
import 'package:asset_management_module/home/view.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:asset_management_module/utils/data/nav_key.dart';
import 'package:asset_management_module/utils/themes/dart.dart';
import 'package:asset_management_module/utils/themes/light.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingController extends GetxController {
  dynamic response;
  RxString language = ''.obs;
  RxString theme = ''.obs;
  List languages = [
    {
      'id': 'id',
      'label': 'Indonesia'
    },
    {
      'id': 'en',
      'label': 'English'
    }
  ];
  List themes = ['Light', 'Dark'];


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
      if(response?['success'] ?? false) {
        NavKey.user = UserAuth.fromJson(response['data']);
        NavKey.pwa = Pwa.fromJson(response['pwa']);
      }
    });
  }

  void changeLanguage(String value) {
    language.value = value;
    Locale local;
    if(value.toLowerCase() == 'en') {
      local = const Locale('en', 'US');
    } else {
      local = const Locale('id', 'ID');
    }
    Get.updateLocale(local);

  }

  void changeTheme(String value) {
    theme.value = value;
    if(value.toLowerCase() == 'light') {
      Get.changeTheme(lightTheme);
    } else {
      Get.changeTheme(darkTheme);
    }
  }


  void next(ctx) async {
    Get.off(const HomePage(),
      transition: Transition.rightToLeft,
      routeName: '/home',
    );
  }

}
