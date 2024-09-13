import 'package:asset_management_module/model/asset.dart';
import 'package:get/get.dart';

class AddEditAssetController extends GetxController {
  RxString type = ''.obs;
  Rx<Asset> asset = Asset().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    type.value = Get.arguments('type');
    if(type.value == 'add') {
       
    } else {
      asset.value = Get.arguments('data');
    }
  }
}
