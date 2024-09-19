import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'dart:js' as js;

import 'controller.dart';

class UnauthorizePage extends StatelessWidget {
  const UnauthorizePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: UnauthorizeController(),
      builder: (ctr) => Obx(() => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
              onTap: () {
                // js.context.callMethod('backToMainApp');
              },
              child: const Icon(Icons.arrow_back_ios, color: Colors.black,)),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/img_no_data.png',
                width: 100,
                height: 100,
              ),
              const Divider(height: 20,),
              Text(ctr.message.value,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400, fontSize: 16),
              )
            ],
          ),
        ),
      ))
    );
  }
}
