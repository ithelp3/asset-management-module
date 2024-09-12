import 'package:asset_management_module/home/controller.dart';
import 'package:flutter/material.dart';

Widget account(BuildContext context, HomeController ctr) {
  return Scaffold(
    body: CustomScrollView(
      slivers: [
        SliverAppBar(
            title: Text('Account',),
            centerTitle: true,
            backgroundColor: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : const Color(0xFF272d34),
            automaticallyImplyLeading: false,
        ),
      ],
    ),
  );
}