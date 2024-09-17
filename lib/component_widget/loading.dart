import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingFullscreen {

  static void startLoading() {
    Get.dialog(
        const SimpleDialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          children: <Widget>[
            Center(
              // child: CircularProgressIndicator.adaptive(),
              child: CircularProgressIndicator(),
            )
          ],
        )
    );
  }

  static stopLoading() {
    Get.close(1);
  }
}