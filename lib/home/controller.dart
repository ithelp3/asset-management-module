import 'package:asset_management_module/Model/user_auth.dart';
import 'package:asset_management_module/asset/add_edit_asset/view.dart';
import 'package:asset_management_module/asset/assign_unassign/view.dart';
import 'package:asset_management_module/component/view.dart';
import 'package:asset_management_module/component_widget/loading.dart';
import 'package:asset_management_module/component_widget/scaffold_message.dart';
import 'package:asset_management_module/depreciation/add_edit_depreciation/view.dart';
import 'package:asset_management_module/lending/view.dart';
import 'package:asset_management_module/maintenance/view.dart';
import 'package:asset_management_module/model/asset.dart';
import 'package:asset_management_module/model/depreciation.dart';
import 'package:asset_management_module/model/permissions.dart';
import 'package:asset_management_module/model/profile.dart';
import 'package:asset_management_module/model/monitoring.dart';
import 'package:asset_management_module/purchase_order/add_edit_purchase/view.dart';
import 'package:asset_management_module/purchase_order/purchase_details/view.dart';
import 'package:asset_management_module/purchase_order/view.dart';
import 'package:asset_management_module/staff/view.dart';
import 'package:asset_management_module/submission/add_edit_submission/view.dart';
import 'package:asset_management_module/submission/submission_details/view.dart';
import 'package:asset_management_module/submission/view.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:asset_management_module/utils/data/nav_key.dart';
import 'package:asset_management_module/component_widget/dialog_info_delete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt navbarBottomIdx = 0.obs;
  UserAuth user = NavKey.user!;
  List<Permission> permissions = NavKey.permissions!;
  RxList allMonitoring = [].obs;
  RxList<Monitoring> itemPurchases = <Monitoring>[].obs;
  RxList<Monitoring> itemSubmission = <Monitoring>[].obs;
  RxList lendings = ['Pinjaman 1', 'Pinjaman 2', 'Pinjaman 3', 'Pinjaman 4', 'Pinjaman 5',].obs;
  RxList maintenances = ['Maintenance 1', 'Maintenance 2', 'Maintenance 3', 'Maintenance 4', 'Maintenance 5', ].obs;
  RxBool progressDashboard = false.obs;
  RxBool errorBanner = false.obs;

  RxString capsule = 'submission'.tr.obs;

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

  void selectNavbarBottomIdx(context, int idx) {
    navbarBottomIdx.value = idx;
    if(idx == 0){
      getDashboard();
    } else if(idx == 1) {
      if(user.administrator!) {
        if(assets.isEmpty) getAssets();
      } else if(permissions.any((i) => i.feature == "asset")) {
        Permission permission = permissions.firstWhere((i) => i.feature == "asset");
        if(permission.permissions!.any((i) => i == 'view')) {
          if(assets.isEmpty) getAssets();
        } else if(permission.permissions!.any((i) => i == 'add')) {
          Get.to(const AddEditAssetPage(),
            routeName: '/assets/add',
            arguments: {
              'type': 'add',
            },
          );
        } else {
          scaffoldMessage(context, 'sorry_you_dont_have_access'.tr);
        }
      } else {
        scaffoldMessage(context, 'sorry_you_dont_have_access'.tr);
      }
    } else if(idx == 2) {

    } else if(idx == 3) {
      if(user.administrator!) {
        if(depreciations.isEmpty) getDepreciations();
      } else if(permissions.any((i) => i.feature == "depreciations")) {
        Permission permission = permissions.firstWhere((i) => i.feature == "depreciations");
        if(permission.permissions!.any((i) => i == 'view')) {
          if(depreciations.isEmpty) getDepreciations();
        } else if(permission.permissions!.any((i) => i == 'add')) {
          Get.to(const AddEditDepreciationPage(),
            routeName: '/depreciations/add',
            arguments: {
              'type': 'add',
            },
          );
        } else {
          scaffoldMessage(context, 'sorry_you_dont_have_access'.tr);
        }
      } else {
        scaffoldMessage(context, 'sorry_you_dont_have_access'.tr);
      }
    } else if(idx == 4) {
      if(profile.value.id == null) getProfile();
    }
    update();
  }

  void getDashboard() async {
    await DioClient().get('/monitoring/list')
      .then((res) {
        for(final findSupplier in res['find_supplier']) {
          for(final po in res['submission']) {
            Monitoring submission = Monitoring.fromJson(po);
            if(findSupplier == submission.findSupplierId) itemSubmission.add(submission);
          }
        }
        for(final approve in res['approval']) {
          for(final po in res['submission']) {
            Monitoring submission = Monitoring.fromJson(po);
            if(approve == submission.id) itemSubmission.add(submission);
          }
        }
        for(final purchase in res['purchases']) {
          for(final po in res['submission']) {
            Monitoring submissionPurchase = Monitoring.fromJson(po);
            if(purchase['find_supplier_id'] != 0 && purchase['find_supplier_id'] == submissionPurchase.findSupplierId) {
              submissionPurchase.status = purchase['status'] == 1 ? 'un_paid' : 'paid';
              submissionPurchase.submissionId = purchase['purchase_id'];
              itemPurchases.add(submissionPurchase);
            }
          }
        }
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

  void selectItemIcon(context, String key) async {
    dynamic result;
    if(key == 'purchase_order'.tr) {
      if(user.administrator!) {
        result = await Get.to(const PurchaseOrderPage(),
            routeName: '/purchase_order'
        );
      } else if(permissions.any((i) => i.feature == "purchase")) {
        Permission permission = permissions.firstWhere((i) => i.feature == "purchase");
        if(permission.permissions!.any((i) => i == 'view')) {
          result = await Get.to(const PurchaseOrderPage(),
              routeName: '/purchase_order'
          );
        } else if(permission.permissions!.any((i) => i == 'add')) {
          result = await Get.to(const AddEditPurchasePage(),
              routeName: '/purchase-order/add',
              arguments: {
                'type': 'add'
              }
          );
        } else {
          scaffoldMessage(context, 'sorry_you_dont_have_access'.tr);
        }
      } else {
        scaffoldMessage(context, 'sorry_you_dont_have_access'.tr);
      }
    }
    // if(key == 'lending'.tr) {
    //   Get.to(const LendingPage(),
    //       routeName: '/Lending/add'
    //   );
    // }
    if(key == 'component'.tr) {
      Permission permission = permissions.firstWhere((i) => i.feature == "component", orElse: () => Permission());
      if(user.administrator! || (permission.permissions?.isNotEmpty ?? false)) {
        result = Get.to(const ComponentPage(),
          routeName: '/component/list',
        );
        if(permission.permissions!.any((i) => i == 'view')) {
          result = Get.to(const ComponentPage(),
            routeName: '/component/list',
          );
        } else {
          scaffoldMessage(context, 'sorry_you_dont_have_access'.tr);
        }
      } else {
        scaffoldMessage(context, 'sorry_you_dont_have_access'.tr);
      }
    }
    if(key == 'maintenance'.tr) {
      Permission permission = permissions.firstWhere((i) => i.feature == "maintenance", orElse: () => Permission());
      if(user.administrator! || (permission.permissions?.isNotEmpty ?? false)) {
        result = Get.to(const MaintenancePage(),
          routeName: '/maintenance/list',
        );
        if(permission.permissions!.any((i) => i == 'view')) {
          result = Get.to(const MaintenancePage(),
            routeName: '/maintenance/list',
          );
        } else {
          scaffoldMessage(context, 'sorry_you_dont_have_access'.tr);
        }
      } else {
        scaffoldMessage(context, 'sorry_you_dont_have_access'.tr);
      }
    }
    if(key == 'submission'.tr) {
      if(user.administrator!) {
        result = await Get.to(const SubmissionPage(),
          routeName: '/submission',
        );
      } else if(permissions.any((i) => i.feature == "submission")) {
        Permission permission = permissions.firstWhere((i) => i.feature == "submission");
        if(permission.permissions!.any((i) => i == 'view')) {
          result = await Get.to(const SubmissionPage(),
            routeName: '/submission',
          );
        } else if(permission.permissions!.any((i) => i == 'add')) {
          result = await Get.to(const AddEditSubmissionPage(),
              arguments: {
                'type': 'add'
              },
              routeName: '/submission/add'
          );
        } else {
          scaffoldMessage(context, 'sorry_you_dont_have_access'.tr);
        }
      } else {
        scaffoldMessage(context, 'sorry_you_dont_have_access'.tr);
      }
    }
    if(key == 'staff'.tr) {
      Permission permission = permissions.firstWhere((i) => i.feature == "users", orElse: () => Permission());
      if(user.administrator! || (permission.permissions?.isNotEmpty ?? false)) {
        result = Get.to(const StaffPage(),
          routeName: '/staff/list',
        );
        if(permission.permissions!.any((i) => i == 'view')) {
          result = Get.to(const StaffPage(),
            routeName: '/staff/list',
          );
        } else {
          scaffoldMessage(context, 'sorry_you_dont_have_access'.tr);
        }
      } else {
        scaffoldMessage(context, 'sorry_you_dont_have_access'.tr);
      }
    }
    if(key == 'supplier'.tr || key == 'brand'.tr || key == 'lending'.tr) {
      scaffoldMessage(context, 'Coming soon..');
    }

    if(result == null) return;

    getDashboard();
  }

  void selectItemMonitoring(String key, dynamic data) async {
    dynamic result;
    Monitoring item = data;
    if(key == 'submission') {
      result = await Get.to(const SubmissionDetailsPage(),
          arguments: {
            'id': item.id
          },
          routeName: 'submission/details'
      );
    } else if(key == 'purchase') {
      result = await Get.to(const PurchaseDetailsPage(),
          arguments: {
            'findSupplierId': item.findSupplierId
          },
          routeName: '/purchase/details'
      );
    }
    if(result == null) return;

    getDashboard();
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
