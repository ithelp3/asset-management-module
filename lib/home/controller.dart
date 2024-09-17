import 'package:asset_management_module/Model/user_auth.dart';
import 'package:asset_management_module/asset/add_edit_asset/view.dart';
import 'package:asset_management_module/asset/assign_unassign/view.dart';
import 'package:asset_management_module/component_widget/loading.dart';
import 'package:asset_management_module/model/asset.dart';
import 'package:asset_management_module/model/depreciation.dart';
import 'package:asset_management_module/model/pie_cart.dart';
import 'package:asset_management_module/model/recent_component.dart';
import 'package:asset_management_module/model/recent_status.dart';
import 'package:asset_management_module/model/submission.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:asset_management_module/utils/data/nav_key.dart';
import 'package:asset_management_module/component_widget/dialog_info_delete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt navbarBottomIdx = 0.obs;
  UserAuth user = NavKey.user!;
  RxList<PieChart> pieChartAssetByCategory = <PieChart>[].obs;
  RxList<PieChart> pieChartAssetByStatus = <PieChart>[].obs;
  RxList<RecentAsset> recentAssets = <RecentAsset>[].obs;
  RxList<RecentComponent> recentComponents = <RecentComponent>[].obs;
  RxList<Submission> submission = <Submission>[].obs;
  RxBool progressDashboard = false.obs;

  RxList<Asset> assets = <Asset>[].obs;
  RxList<Asset> assetSearch = <Asset>[].obs;
  Rx<TextEditingController> fieldSearchAsset = TextEditingController().obs;
  RxBool progressAsset = false.obs;

  RxList<Depreciation> depreciations = <Depreciation>[].obs;
  RxList<Depreciation> depreciationSearch = <Depreciation>[].obs;
  Rx<TextEditingController> fieldSearchDep = TextEditingController().obs;
  RxBool progressDep = false.obs;

  RxBool errorBanner = false.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    progressDashboard.value = true;
    getDashboard();
  }

  void selectNavbarBottomIdx(int idx) {
    navbarBottomIdx.value = idx;
    if(idx == 0){
      getDashboard();
    } else if(idx == 1) {
      if(assets.isEmpty) getAssets();
    } else if(idx == 2) {

     }else if(idx == 3) {
      if(depreciations.isEmpty) getDepreciations();
    }
    update();
  }

  void getDashboard() async {
    await DioClient().get('/dashboard/data-total',).then((res) {
      pieChartAssetByCategory.value = List.from(res['data']['asset_by_category'].map((json) => PieChart.fromJson(json)));
      pieChartAssetByStatus.value = List.from(res['data']['asset_by_status'].map((json) => PieChart.fromJson(json)));
      recentAssets.value = List.from(res['data']['recent_asset'].map((json) => RecentAsset.fromJson(json)));
      recentComponents.value = List.from(res['data']['recent_component'].map((json) => RecentComponent.fromJson(json)));
      submission.value = List.from(res['data']['submission'].map((json) => Submission.fromJson(json)));
    });
    progressDashboard.value = false;
    update();
  }

  void getAssets() async {
    progressAsset.value = true;
    await DioClient().get('/asset/list').then((res) {
      assets.value = List.from(res['data'].map((json) => Asset.fromJson(json)));
    });
    progressAsset.value = false;
    update();
  }

  void getDepreciations() async {
    progressDep.value = true;
    await DioClient().get('/depreciation/list').then((res) {
      depreciations.value = List.from(res['data'].map((json) => Depreciation.fromJson(json)));
    });
    progressDep.value = false;
    update();
  }

  //Asset
  void onSearchAsset(String key) {
    assetSearch.value = assets.where((item) =>
        item.name!.toLowerCase().contains((key.toLowerCase()))).toList();
    update();
  }

  void assetAddEdit(String label, Asset? asset) async {
    final result = await Get.to(const AddEditAssetPage(),
      routeName: '/assets/${label == 'add' ? 'add' : 'edit'}',
      arguments: {
        'type': label == 'add' ? 'add' : 'edit',
        if(label == 'edit') 'data': asset
      },
    );

    if(result == null) return;
    getAssets();
  }

  void assetDelete(context, Asset asset) async {
    final result = await Get.dialog(dialogInfoDelete(context,
      height: 160 ,
      title: 'delete_asset'.tr,
      info: 'Are you going to delete the {name} Asset data?'.trParams({'value': asset.assetName!})
    ));
    
    if(result == null || !result) return;
    LoadingFullscreen.startLoading();
    await DioClient().delete('/asset/delete',
      data: {
        'id': asset.id
      }
    ).then((res) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.lightBlue,
          content: Text('successful_'.trParams({'value': 'delete_asset'.tr})),
          behavior: SnackBarBehavior.floating,
        )
      );
      getAssets();
    }).catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('Oppss..!!'),
          behavior: SnackBarBehavior.floating,
        )
      );
    });
    LoadingFullscreen.stopLoading();
  }

  void assignUnassign(Asset item) async {
    final result = await Get.to(const AssignUnassignPage(),
      routeName: (item.status == '2') ? '/asset/un-assign' : '/asset/assign',
      arguments: {
        'data': item
      }
    );

    if(result == null) return;
    getAssets();
  }

  //Depreciation
  void onSearchDep(String key) {
    depreciationSearch.value = depreciations.where((item) =>
        item.name!.toLowerCase().contains((key.toLowerCase()))).toList();
    update();
  }
}
