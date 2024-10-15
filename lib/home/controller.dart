import 'dart:convert';

import 'package:asset_management_module/Model/user_auth.dart';
import 'package:asset_management_module/asset/add_edit_asset/view.dart';
import 'package:asset_management_module/asset/assign_unassign/view.dart';
import 'package:asset_management_module/component_widget/loading.dart';
import 'package:asset_management_module/depreciation/add_edit_depreciation/view.dart';
import 'package:asset_management_module/model/asset.dart';
import 'package:asset_management_module/model/depreciation.dart';
import 'package:asset_management_module/model/pie_cart.dart';
import 'package:asset_management_module/model/profile.dart';
import 'package:asset_management_module/model/purchase_order_submission.dart';
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
  // RxList<PieChart> pieChartAssetByCategory = <PieChart>[].obs;
  // RxList<PieChart> pieChartAssetByStatus = <PieChart>[].obs;
  // RxList<RecentAsset> recentAssets = <RecentAsset>[].obs;
  // RxList<RecentComponent> recentComponents = <RecentComponent>[].obs;
  // RxList<Submission> submission = <Submission>[].obs;
  // RxInt totalAsset = 0.obs;
  // RxInt totalComponent = 0.obs;
  // RxInt totalMaintenance = 0.obs;
  // RxInt totalEmployee = 0.obs;
  RxList allMonitoring = [].obs;
  RxList<PurchaseOrderSubmission> itemPO = <PurchaseOrderSubmission>[].obs;
  RxList lendings = ['Pinjaman 1', 'Pinjaman 2', 'Pinjaman 3', 'Pinjaman 4', 'Pinjaman 5',].obs;
  RxList maintenances = ['Maintenance 1', 'Maintenance 2', 'Maintenance 3', 'Maintenance 4', 'Maintenance 5', ].obs;
  // RxBool expandAC = true.obs;
  // RxBool expandAS = true.obs;
  RxBool progressDashboard = false.obs;
  RxBool errorBanner = false.obs;

  RxString capsule = 'Semua'.obs;

  RxList<Asset> assets = <Asset>[].obs;
  RxList<Asset> assetSearch = <Asset>[].obs;
  Rx<TextEditingController> fieldSearchAsset = TextEditingController().obs;
  RxBool progressAsset = false.obs;

  RxList<Depreciation> depreciations = <Depreciation>[].obs;
  RxList<Depreciation> depreciationSearch = <Depreciation>[].obs;
  Rx<TextEditingController> fieldSearchDep = TextEditingController().obs;
  RxBool progressDep = false.obs;

  Rx<Profile> profile = Profile().obs;
  RxBool progressProfile = false.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    if((user.logo ?? '') == '') errorBanner.value = true;
    progressDashboard.value = true;
    getDashboard();
  }

  void selectedCapsule(String key) {
    capsule.value = key;
  }

  void selectNavbarBottomIdx(int idx) {
    navbarBottomIdx.value = idx;
    if(idx == 0){
      getDashboard();
    } else if(idx == 1) {
      if(assets.isEmpty) getAssets();
    } else if(idx == 2) {

    } else if(idx == 3) {
      if(depreciations.isEmpty) getDepreciations();
    } else if(idx == 4) {
      if(profile.value.id == null) getProfile();
    }
    update();
  }

  void getDashboard() async {
    // await DioClient().get('/dashboard/data-total',).then((res) {
    //   pieChartAssetByCategory.value = List.from(res['data']['asset_by_category'].map((json) => PieChart.fromJson(json)));
    //   pieChartAssetByStatus.value = List.from(res['data']['asset_by_status'].map((json) => PieChart.fromJson(json)));
    //   recentAssets.value = List.from(res['data']['recent_asset'].map((json) => RecentAsset.fromJson(json)));
    //   recentComponents.value = List.from(res['data']['recent_component'].map((json) => RecentComponent.fromJson(json)));
    //   totalAsset.value = res['data']['asset'];
    //   totalComponent.value = res['data']['component'];
    //   totalMaintenance.value = res['data']['maintenance'];
    //   totalEmployee.value = res['data']['employee'];
      // submission.value = List.from(res['data']['submission'].map((json) => Submission.fromJson(json)));
    // });
    await DioClient().get('/purchaseorder/submissionlist')
        .then((res) {
          itemPO.value = List.from(res['data'].map((json) => PurchaseOrderSubmission.fromJson(json)));
          allMonitoring.value = List.from(res['data'].map((json) => PurchaseOrderSubmission.fromJson(json)));
        });
    // allMonitoring.addAll([
    //   PurchaseOrderSubmission(
    //       subject: 'peminjaman',
    //       submissionDetail: 'Peminjaman alat 1',
    //       status: 'On Process'
    //   ),
    //   PurchaseOrderSubmission(
    //       subject: 'peminjaman',
    //       submissionDetail: 'Peminjaman alat 2',
    //       status: 'On Process'
    //   ),
    //   PurchaseOrderSubmission(
    //       subject: 'peminjaman',
    //       submissionDetail: 'Peminjaman alat 3',
    //       status: 'On Process'
    //   ),
    // ]);
    // allMonitoring.addAll([
    //   PurchaseOrderSubmission(
    //     subject: 'maintenance',
    //     submissionDetail: 'Maintenance alat 1',
    //     status: 'On Process'
    //   ),
    //   PurchaseOrderSubmission(
    //     subject: 'maintenance',
    //     submissionDetail: 'Maintenance alat 2',
    //       status: 'On Process'
    //   ),
    //   PurchaseOrderSubmission(
    //     subject: 'maintenance',
    //     submissionDetail: 'Maintenance alat 3',
    //       status: 'On Process'
    //   ),
    // ]);
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

  void getProfile() async {
    progressProfile.value = true;
    await DioClient().get('/user/profile').then((res) =>
      profile.value = Profile.fromJson(res['data']));
    progressProfile.value = false;
    update();
  }

  //Dashboard
  // void expandPie(String key){
  //   if(key == 'ac') expandAC.value = !expandAC.value;
  //   if(key == 'as') expandAS.value = !expandAS.value;
  //   update();
  // }

  //Asset
  void onSearchAsset(String key) {
    assetSearch.value = assets.where((item) =>
        item.name!.toLowerCase().contains((key.toLowerCase()))).toList();
    update();
  }

  void clearSearchAsset() {
    fieldSearchAsset.value = TextEditingController();
    assetSearch.value = [];
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
      info: 'dialog_delete_depreciation'.trParams({'value': asset.assetName!})
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
      transition: Transition.rightToLeft,
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

  void clearSearchDep() {
    fieldSearchDep.value = TextEditingController();
    depreciationSearch.value = [];
    update();
  }

  void addEditDep(String label, Depreciation? dep) async {
    final result = await Get.to(const AddEditDepreciationPage(),
      routeName: '/depreciations/${label == 'add' ? 'add' : 'edit'}',
      arguments: {
        'type': label == 'add' ? 'add' : 'edit',
        if(label == 'edit') 'data': dep
      },
    );

    if(result == null) return;
    getDepreciations();
  }

  void deleteDep(context, Depreciation dep) async {
    final result = await Get.dialog(dialogInfoDelete(context,
        height: 160 ,
        title: 'delete_depreciation'.tr,
        info: 'dialog_delete_depreciation'.trParams({'value': dep.name!})
    ));

    if(result == null || !result) return;
    LoadingFullscreen.startLoading();
    await DioClient().delete('/depreciation/delete',
        data: {
          'id': dep.id
        }
    ).then((res) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.lightBlue,
            content: Text('successful_'.trParams({'value': 'delete_depreciation'.tr})),
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
}
