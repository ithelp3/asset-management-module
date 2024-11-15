import 'package:asset_management_module/model/purchase.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PurchaseOrderController extends GetxController {
  RxList<Purchase> purchases = <Purchase>[].obs;
  RxBool progress = false.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    progress.value = true;
    await DioClient().get('/purchase-order/list').then((res)
      => purchases.value = List.from(res['data'].map((json)
      => Purchase.fromJson(json))));
    progress.value = false;
  }
}
