import 'package:get/get.dart';

class UnauthorizeController extends GetxController {
  RxString message = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    message.value = Get.arguments['data'];
  }
}
