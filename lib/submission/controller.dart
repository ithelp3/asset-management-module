import 'package:asset_management_module/model/submission.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:get/get.dart';

class SubmissionController extends GetxController {
  RxList<Submission> submissions = <Submission>[].obs;
  RxBool progress = false.obs;
  
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    progress.value = true;
    await DioClient().get('/submission/list').then((res)
      => submissions.value = List.from(res['data'].map((json)
      => Submission.fromJson(json))));

    progress.value = false;
  }
}
