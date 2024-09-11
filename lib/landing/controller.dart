import 'package:asset_management_module/home/view.dart';
import 'package:asset_management_module/utils/themes/dart.dart';
import 'package:asset_management_module/utils/themes/light.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingController extends GetxController {

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
  void onInit() {
    // TODO: implement onInit
    super.onInit();
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
    Get.to(const HomePage(),
      transition:Transition.rightToLeft,
      routeName: '/home',
    );
  }

}
