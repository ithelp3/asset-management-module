import 'package:asset_management_module/Model/pwa.dart';
import 'package:asset_management_module/Model/user_auth.dart';
import 'package:asset_management_module/model/permissions.dart';
import 'package:flutter/cupertino.dart';

class NavKey{
  static final navKey = GlobalKey<NavigatorState>();
  // static String? data = 'FINfQ==ICAgICJ1c2VyX2lkIjogMzY0NzMsDQogICAgInR5cGUiOiAyLA0KICAgICJjb21wYW55X2lkIjogMTI3NzYsDQogICAgInBhY2thZ2VfaWQiOiA2LA0KICAgICJlbXBfaWQiOiA5OTc4NSwNCiAgICAiZW1wX3BpbiI6ICIxIiwNCiAgICAibW9kdWxlX2lkIjogMywNCiAgICAiaXBfYWRkcmVzcyI6ICIxOTIuMTY4LjEuOTEiLA0KICAgICJwbGF0Zm9ybSI6ICJhbmRyb2lkIiwNCiAgICAibGFuZ3VhZ2UiOiAiaWQiLA0KICAgICJ0aGVtZSI6ICJsaWdodCIsDQogICAgImVtYWlsIjogIm5kdW5nZHVuZy54eXpAZ21haWwuY29tIg0Kew0KSPOT';
  // finance
  // static String? data = 'FINCn0=ICAgICJ1c2VyX2lkIjogMzY0NzMsDQogICAgInR5cGUiOiAyLA0KICAgICJjb21wYW55X2lkIjogMTI3NzYsDQogICAgInBhY2thZ2VfaWQiOiA2LA0KICAgICJlbXBfaWQiOiA5OTc4NSwNCiAgICAiZW1wX3BpbiI6ICIxIiwNCiAgICAibW9kdWxlX2lkIjogMywNCiAgICAiaXBfYWRkcmVzcyI6ICIxOTIuMTY4LjEuMTM1IiwNCiAgICAicGxhdGZvcm0iOiAiYW5kcm9pZCIsDQogICAgImxhbmd1YWdlIjogImlkIiwNCiAgICAidGhlbWUiOiAibGlnaHQiLA0KICAgICJlbWFpbCI6ICJmaW5hbmNlaXRoZWxwM0BmaW5nZXJzcG90LmNvbSINew0KSPOT';
  // BCS DB New
  // static String? data = 'FINCn0=ICAgICJ1c2VyX2lkIjogMzY0NzMsDQogICAgInR5cGUiOiAyLA0KICAgICJjb21wYW55X2lkIjogMTI3NzYsDQogICAgInBhY2thZ2VfaWQiOiA2LA0KICAgICJlbXBfaWQiOiA5OTc4NSwNCiAgICAiZW1wX3BpbiI6ICIxIiwNCiAgICAibW9kdWxlX2lkIjogMywNCiAgICAiaXBfYWRkcmVzcyI6ICIxOTIuMTY4LjEuOTEiLA0KICAgICJwbGF0Zm9ybSI6ICJhbmRyb2lkIiwNCiAgICAibGFuZ3VhZ2UiOiAiaWQiLA0KICAgICJ0aGVtZSI6ICJsaWdodCIsDQogICAgImVtYWlsIjogInBjcEBmaW5nZXJzcG90LmNvbSINew0KSPOT';
  // GA
  // static String? data = 'FINbSJ9c2VyX2lkIjozNjQ3MywidHlwZSI6MiwiY29tcGFueV9pZCI6MTI3NzYsInBhY2thZ2VfaWQiOjYsImVtcF9pZCI6OTk3ODUsImVtcF9waW4iOiIxIiwibW9kdWxlX2lkIjozLCJpcF9hZGRyZXNzIjoiMTkyLjE2OC4xLjkxIiwicGxhdGZvcm0iOiJhbmRyb2lkIiwibGFuZ3VhZ2UiOiJpZCIsInRoZW1lIjoibGlnaHQiLCJlbWFpbCI6ImdhLmJjc0BmaW5nZXJzcG90LmNveyJ1SPOT';

  // Alex
  // static String? data = 'FINfQ==c2VyX2lkIjozNjQ3MywidHlwZSI6MiwiY29tcGFueV9pZCI6MTI3NzYsInBhY2thZ2VfaWQiOjYsImVtcF9pZCI6OTk3ODUsImVtcF9waW4iOiIxIiwibW9kdWxlX2lkIjozLCJpcF9hZGRyZXNzIjoiMTkyLjE2OC4xLjkxIiwicGxhdGZvcm0iOiJhbmRyb2lkIiwibGFuZ3VhZ2UiOiJpZCIsInRoZW1lIjoibGlnaHQiLCJlbWFpbCI6ImFsZXguZmluZ2Vyc3BvdEBnbWFpbC5jb20ieyJ1SPOT';
  // Mas Agung Elit
  // static String? data = 'FINfQ==c2VyX2lkIjozNjQ3MywidHlwZSI6MiwiY29tcGFueV9pZCI6MTI3NzYsInBhY2thZ2VfaWQiOjYsImVtcF9pZCI6OTk3ODUsImVtcF9waW4iOiIxIiwibW9kdWxlX2lkIjozLCJpcF9hZGRyZXNzIjoiMTkyLjE2OC4xLjkxIiwicGxhdGZvcm0iOiJhbmRyb2lkIiwibGFuZ3VhZ2UiOiJpZCIsInRoZW1lIjoibGlnaHQiLCJlbWFpbCI6ImFhc3RoZW1lc0BnbWFpbC5jb20ieyJ1SPOT';

  // Andri
  // static String? data = 'FINbSJ9c2VyX2lkIjozNjQ3MywidHlwZSI6MiwiY29tcGFueV9pZCI6MTI3NzYsInBhY2thZ2VfaWQiOjYsImVtcF9pZCI6OTk3ODUsImVtcF9waW4iOiIxIiwibW9kdWxlX2lkIjozLCJpcF9hZGRyZXNzIjoiMTkyLjE2OC4xLjkxIiwicGxhdGZvcm0iOiJhbmRyb2lkIiwibGFuZ3VhZ2UiOiJpZCIsInRoZW1lIjoibGlnaHQiLCJlbWFpbCI6ImdhLmJjc0BmaW5nZXJzcG90LmNveyJ1SPOT';
  // Heru
  // static String? data = 'FINfQ==c2VyX2lkIjozNjQ3MywidHlwZSI6MiwiY29tcGFueV9pZCI6MTI3NzYsInBhY2thZ2VfaWQiOjYsImVtcF9pZCI6OTk3ODUsImVtcF9waW4iOiIxIiwibW9kdWxlX2lkIjozLCJpcF9hZGRyZXNzIjoiMTkyLjE2OC4xLjkxIiwicGxhdGZvcm0iOiJhbmRyb2lkIiwibGFuZ3VhZ2UiOiJpZCIsInRoZW1lIjoibGlnaHQiLCJlbWFpbCI6ImhlcnUuZmluZ2Vyc3BvdEBnbWFpbC5jb20ieyJ1SPOT';
  // local Heru
  // static String? data = 'FINbSJ9c2VyX2lkIjozNjQ3MywidHlwZSI6MiwiY29tcGFueV9pZCI6MTI3NzYsInBhY2thZ2VfaWQiOjYsImVtcF9pZCI6OTk3ODUsImVtcF9waW4iOiIxIiwibW9kdWxlX2lkIjozLCJpcF9hZGRyZXNzIjoiMTkyLjE2OC4xLjkxIiwicGxhdGZvcm0iOiJhbmRyb2lkIiwibGFuZ3VhZ2UiOiJpZCIsInRoZW1lIjoibGlnaHQiLCJlbWFpbCI6ImNvbXBhbnloZXJ1QGdtYWlsLmNveyJ1SPOT';
  // static String? data = 'FINDQp9ICAgICJ1c2VyX2lkIjogMzY0NzMsDQogICAgInR5cGUiOiAyLA0KICAgICJjb21wYW55X2lkIjogMTI3NzYsDQogICAgInBhY2thZ2VfaWQiOiA2LA0KICAgICJlbXBfaWQiOiA5OTc4NSwNCiAgICAiZW1wX3BpbiI6ICIxIiwNCiAgICAibW9kdWxlX2lkIjogMywNCiAgICAiaXBfYWRkcmVzcyI6ICIxOTIuMTY4LjEuMTM1IiwNCiAgICAicGxhdGZvcm0iOiAiYW5kcm9pZCIsDQogICAgImxhbmd1YWdlIjogImlkIiwNCiAgICAidGhlbWUiOiAibGlnaHQiLA0KICAgICJlbWFpbCI6ICJjb21wYW55aGVydUBnbWFpbC5jb20iew0KSPOT';
  // DIo
  static String? data = 'FINCn0=ICAgICJ1c2VyX2lkIjogMzY0NzMsDQogICAgInR5cGUiOiAyLA0KICAgICJjb21wYW55X2lkIjogMTI3NzYsDQogICAgInBhY2thZ2VfaWQiOiA2LA0KICAgICJlbXBfaWQiOiA5OTc4NSwNCiAgICAiZW1wX3BpbiI6ICIxIiwNCiAgICAibW9kdWxlX2lkIjogMywNCiAgICAiaXBfYWRkcmVzcyI6ICIxOTIuMTY4LjEuMTM1IiwNCiAgICAicGxhdGZvcm0iOiAiYW5kcm9pZCIsDQogICAgImxhbmd1YWdlIjogImlkIiwNCiAgICAidGhlbWUiOiAibGlnaHQiLA0KICAgICJlbWFpbCI6ICJpdC5maW5nZXJzcG90bWFnYW5nQGdtYWlsLmNvbSINew0KSPOT';
  static UserAuth? user;
  static Pwa? pwa;
  static List<Permission>? permissions;
}