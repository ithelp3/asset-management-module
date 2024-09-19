import 'package:asset_management_module/asset/asset_details/dialog_asset_add_file/view.dart';
import 'package:asset_management_module/model/asset.dart';
import 'package:asset_management_module/model/asset_component.dart';
import 'package:asset_management_module/model/asset_depreciation.dart';
import 'package:asset_management_module/model/asset_details.dart';
import 'package:asset_management_module/model/asset_file.dart';
import 'package:asset_management_module/model/asset_history.dart';
import 'package:asset_management_module/model/asset_log.dart';
import 'package:asset_management_module/model/asset_maintenance.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssetDetailsController extends GetxController with GetTickerProviderStateMixin {
  TabController? tabController;
  RxBool progress = false.obs;
  Rx<Asset> asset = Asset().obs;
  Rx<AssetDetails> details = AssetDetails().obs;
  RxList<AssetComponent> components = <AssetComponent>[].obs;
  RxList<AssetDepreciation> depreciations = <AssetDepreciation>[].obs;
  RxList<AssetFile> files = <AssetFile>[].obs;
  RxList<AssetHistory> histories = <AssetHistory>[].obs;
  RxList<AssetLog> logs = <AssetLog>[].obs;
  RxList<AssetMaintenance> maintenances = <AssetMaintenance>[].obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    progress.value = true;
    asset.value = Get.arguments['data'];
    tabController = TabController(length: 7, vsync: this);
    await DioClient().post('/asset/details',
      data: {
        'id': asset.value.id,
      }
    ).then((res) {
      details.value = AssetDetails.fromJson(res['data']['details']);
      components.value = List.from(res['data']['components'].map((json) => AssetComponent.fromJson(json)));
      depreciations.value = List.from(res['data']['depreciations'].map((json) => AssetDepreciation.fromJson(json)));
      files.value = List.from(res['data']['files'].map((json) => AssetFile.fromJson(json)));
      histories.value = List.from(res['data']['histories'].map((json) => AssetHistory.fromJson(json)));
      logs.value = List.from(res['data']['logs'].map((json) => AssetLog.fromJson(json)));
      maintenances.value = List.from(res['data']['maintenances'].map((json) => AssetMaintenance.fromJson(json)));
    });
    progress.value = false;
  }

  void addFile() async {
    final result = await Get.dialog(const DialogAssetAddFilePage(),
      arguments: {
        'data': asset.value
      },
      name: '/asset-details/file/add'
    );
    if(result == null) return;
    onInit();
  }
}
