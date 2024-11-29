import 'package:asset_management_module/Model/pwa.dart';
import 'package:asset_management_module/Model/user_auth.dart';
import 'package:asset_management_module/model/permissions.dart';
import 'package:flutter/cupertino.dart';

class NavKey{
  static final navKey = GlobalKey<NavigatorState>();
  static String? data;static UserAuth? user;
  static Pwa? pwa;
  static List<Permission>? permissions;
}