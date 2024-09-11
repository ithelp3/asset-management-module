import 'package:asset_management_module/Model/user_auth.dart';
import 'package:asset_management_module/model/pie_cart.dart';
import 'package:asset_management_module/model/recent_component.dart';
import 'package:asset_management_module/model/recent_status.dart';
import 'package:asset_management_module/model/submission.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:asset_management_module/utils/data/nav_key.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt navbarBottomIdx = 0.obs;
  UserAuth user = NavKey.user!;
  RxList<PieChart> pieChartAssetByCategory = <PieChart>[].obs;
  RxList<PieChart> pieChartAssetByStatus = <PieChart>[].obs;
  RxList<RecentAsset> recentAssets = <RecentAsset>[].obs;
  RxList<RecentComponent> recentComponents = <RecentComponent>[].obs;
  RxList<Submission> submission = <Submission>[].obs;

  RxBool errorBanner = false.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await DioClient().get('/dashboard/data-total',).then((res) {
      pieChartAssetByCategory.value = List.from(res['data']['asset_by_category'].map((json) => PieChart.fromJson(json)));
      pieChartAssetByStatus.value = List.from(res['data']['asset_by_status'].map((json) => PieChart.fromJson(json)));
      recentAssets.value = List.from(res['data']['recent_asset'].map((json) => RecentAsset.fromJson(json)));
      recentComponents.value = List.from(res['data']['recent_component'].map((json) => RecentComponent.fromJson(json)));
      submission.value = List.from(res['data']['submission'].map((json) => Submission.fromJson(json)));
    });
  }

  void selectNavbarBottomIdx(int idx) {
    navbarBottomIdx.value = idx;
  }
}
