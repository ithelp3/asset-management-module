import 'package:asset_management_module/splash_screen/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SplashScreenController(),
      builder: (ctr) => const SafeArea(child: Center(
        child: CircularProgressIndicator(),
      ))
    );
  }
}