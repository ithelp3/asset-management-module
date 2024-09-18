import 'dart:io';

import 'package:asset_management_module/component_widget/dialog_item_select.dart';
import 'package:asset_management_module/component_widget/loading.dart';
import 'package:asset_management_module/model/asset.dart';
import 'package:asset_management_module/model/brand.dart';
import 'package:asset_management_module/model/building.dart';
import 'package:asset_management_module/model/category.dart';
import 'package:asset_management_module/model/floor.dart';
import 'package:asset_management_module/model/group.dart';
import 'package:asset_management_module/model/office.dart';
import 'package:asset_management_module/model/room.dart';
import 'package:asset_management_module/model/status.dart';
import 'package:asset_management_module/model/supplier.dart';
import 'package:asset_management_module/model/user.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_file_selector/flutter_web_file_selector.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:intl/intl.dart';

class AddEditAssetController extends GetxController {
  RxString type = ''.obs;
  Rx<Asset> asset = Asset().obs;
  Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;
  Rx<TextEditingController> fieldName = TextEditingController().obs;
  Rx<TextEditingController> fieldStatus = TextEditingController().obs;
  Rx<TextEditingController> fieldPersonOnCharger = TextEditingController().obs;
  Rx<TextEditingController> fieldOffice = TextEditingController().obs;
  Rx<TextEditingController> fieldBuilding = TextEditingController().obs;
  Rx<TextEditingController> fieldFloor = TextEditingController().obs;
  Rx<TextEditingController> fieldRoom = TextEditingController().obs;
  Rx<TextEditingController> fieldGroup = TextEditingController().obs;
  Rx<TextEditingController> fieldCategory = TextEditingController().obs;
  Rx<TextEditingController> fieldSubCategory = TextEditingController().obs;
  Rx<TextEditingController> fieldTagAsset = TextEditingController().obs;
  Rx<TextEditingController> fieldSupplier = TextEditingController().obs;
  Rx<TextEditingController> fieldBrand = TextEditingController().obs;
  Rx<TextEditingController> fieldSerial = TextEditingController().obs;
  Rx<TextEditingController> fieldPurchaseDate = TextEditingController().obs;
  Rx<TextEditingController> fieldWarranty = TextEditingController().obs;
  Rx<TextEditingController> fieldCost = TextEditingController().obs;
  Rx<TextEditingController> fieldDescription = TextEditingController().obs;
  RxList<Status> statuses = <Status>[].obs;
  Rx<Status> status = Status().obs;
  RxList<User> users = <User>[].obs;
  Rx<User> user = User().obs;
  RxList<Office> offices = <Office>[].obs;
  Rx<Office> office = Office().obs;
  RxList<Building> buildings = <Building>[].obs;
  Rx<Building> building = Building().obs;
  RxList<Floor> floors = <Floor>[].obs;
  Rx<Floor> floor = Floor().obs;
  RxList<Room> rooms = <Room>[].obs;
  Rx<Room> room = Room().obs;
  RxList<Group> groups = <Group>[].obs;
  Rx<Group> group = Group().obs;
  RxList<Category> categories = <Category>[].obs;
  Rx<Category> category = Category().obs;
  RxList<Category> subCategories = <Category>[].obs;
  Rx<Category> subCategory = Category().obs;
  RxList<Supplier> suppliers = <Supplier>[].obs;
  Rx<Supplier> supplier = Supplier().obs;
  RxList<Brand> brands = <Brand>[].obs;
  Rx<Brand> brand = Brand().obs;
  DateTime? selectedDate;
  List warrantyTypes = ['days', 'months', 'Years'];
  RxInt warrantyType = 1.obs;
  XFile? imageFile;
  RxString imageName = ''.obs;
  RxBool showAlertImage = false.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    type.value = Get.arguments['type'];
    await DioClient().get('/asset/data-before-create').then((res) {
      statuses.value = List.from(res['data']['statuses'].map((json) => Status.fromJson(json)));
      users.value = List.from(res['data']['users'].map((json) => User.fromJson(json)));
      offices.value = List.from(res['data']['offices'].map((json) => Office.fromJson(json)));
      groups.value = List.from(res['data']['groups'].map((json) => Group.fromJson(json)));
      suppliers.value = List.from(res['data']['suppliers'].map((json) => Supplier.fromJson(json)));
      brands.value = List.from(res['data']['brands'].map((json) => Brand.fromJson(json)));
    });
    if(type.value == 'edit') {
      asset.value = Get.arguments['data'];
      fieldName.value.value = TextEditingValue(text: asset.value.assetName ?? '');
      status.value = statuses.firstWhere((i) => i.id.toString() == asset.value.status);
      fieldStatus.value.value = TextEditingValue(text: status.value.name!);
      user.value = users.firstWhere((i) => i.fullName == asset.value.assign!);
      fieldPersonOnCharger.value.value = TextEditingValue(text: user.value.fullName!);
      office.value = offices.firstWhere((i) => i.id == asset.value.officeId);
      fieldOffice.value.value = TextEditingValue(text: office.value.name!);
      group.value = groups.firstWhere((i) => i.id == asset.value.groupId);
      fieldGroup.value.value = TextEditingValue(text: group.value.name!);
      supplier.value = suppliers.firstWhere((i) => i.id == asset.value.supplierId);
      fieldSupplier.value.value = TextEditingValue(text: supplier.value.name!);
      brand.value = brands.firstWhere((i) => i.id == asset.value.brandId);
      fieldBrand.value.value = TextEditingValue(text: brand.value.name!);
      Future.wait({
         DioClient().get('/location/building-by-office/${asset.value.officeId}').then((res) {
           buildings.value = List.from(res['data'].map((i) => Building.fromJson(i)));
           building.value = buildings.firstWhere((i) => i.id == asset.value.buildingId);
           fieldBuilding.value.value = TextEditingValue(text: building.value.name!);
         }),
        DioClient().get('/location/floor-by-building/${asset.value.buildingId}').then((res) {
           floors.value = List.from(res['data'].map((i) => Floor.fromJson(i)));
           floor.value = floors.firstWhere((i) => i.id == asset.value.floorId);
           fieldFloor.value.value = TextEditingValue(text: floor.value.name!);
         }),
        DioClient().get('/location/room-by-floor/${asset.value.floorId}').then((res) {
           rooms.value = List.from(res['data'].map((i) => Room.fromJson(i)));
           room.value = rooms.firstWhere((i) => i.id == asset.value.roomId);
           fieldRoom.value.value = TextEditingValue(text: room.value.name!);
         }),
        DioClient().get('/category/by-group/${asset.value.groupId}').then((res) {
           categories.value = List.from(res['data'].map((i) => Category.fromJson(i)));
           category.value = categories.firstWhere((i) => i.id == asset.value.categoryId);
           fieldCategory.value.value = TextEditingValue(text: category.value.name!);
         }),
        DioClient().get('/category/sub-category-by-category/${asset.value.categoryId}').then((res) {
           subCategories.value = List.from(res['data'].map((i) => Category.fromJson(i)));
           subCategory.value = subCategories.firstWhere((i) => i.id == asset.value.subcategoryId);
           fieldSubCategory.value.value = TextEditingValue(text: subCategory.value.name!);
         }),
      });
      fieldTagAsset.value.value = TextEditingValue(text: asset.value.assetTag ?? 'N/A');
      fieldSerial.value.value = TextEditingValue(text: asset.value.serial ?? 'N/A');
      fieldPurchaseDate.value.value = TextEditingValue(text: asset.value.purchaseDate ?? 'N/A');
      fieldWarranty.value.value = TextEditingValue(text: asset.value.warranty ?? 'N/A');
      fieldCost.value.value = TextEditingValue(text: asset.value.cost ?? '0.0');
      fieldDescription.value.value = TextEditingValue(text: asset.value.description ?? '');
      warrantyType.value = asset.value.warrantyType != 0 ? asset.value.warrantyType! : 0;
      fieldWarranty.value.value = TextEditingValue(text: asset.value.warranty ?? '0');
      imageName.value = asset.value.picture ?? 'N/A';
    }
  }

  void selectItem(context, String key) async {
    String label = '';
    List<Item> items = [];
    if(key == 'status') {
      label = 'select_item_label'.trParams({'value': 'status'.tr});
      items = statuses.map((i) => Item(
        label: i.name,
        value: i.id
      )).toList();
    } else if(key == 'person') {
      label = 'select_item_label'.trParams({'value': 'person_on_charge'.tr});
      items = users.map((i) => Item(
          label: i.fullName,
          value: i.id
      )).toList();
    } else if(key == 'office') {
      label = 'select_item_label'.trParams({'value': 'office'.tr});
      items = offices.map((i) => Item(
          label: i.name,
          value: i.id
      )).toList();
    } else if(key == 'building') {
      label = 'select_item_label'.trParams({'value': 'building'.tr});
      items = buildings.map((i) => Item(
          label: i.name,
          value: i.id
      )).toList();
    } else if(key == 'floor') {
      label = 'select_item_label'.trParams({'value': 'floor'.tr});
      items = floors.map((i) => Item(
          label: i.name,
          value: i.id
      )).toList();
    } else if(key == 'room') {
      label = 'select_item_label'.trParams({'value': 'room'.tr});
      items = rooms.map((i) => Item(
          label: i.name,
          value: i.id
      )).toList();
    } else if(key == 'group') {
      label = 'select_item_label'.trParams({'value': 'group'.tr});
      items = groups.map((i) => Item(
          label: i.name,
          value: i.id
      )).toList();
    } else if(key == 'category') {
      label = 'select_item_label'.trParams({'value': 'category'.tr});
      items = categories.map((i) => Item(
          label: i.name,
          value: i.id
      )).toList();
    } else if(key == 'sub-category') {
      label = 'select_item_label'.trParams({'value': 'sub-category'.tr});
      items = subCategories.map((i) => Item(
          label: i.name,
          value: i.id
      )).toList();
    } else if(key == 'supplier') {
      label = 'select_item_label'.trParams({'value': 'supplier'.tr});
      items = suppliers.map((i) => Item(
          label: i.name,
          value: i.id
      )).toList();
    } else if(key == 'brand') {
      label = 'select_item_label'.trParams({'value': 'brand'.tr});
      items = brands.map((i) => Item(
          label: i.name,
          value: i.id
      )).toList();
    } else if(key == 'warranty') {
      label = 'select_item_label'.trParams({'value': 'warranty_type'.tr});
      items = [
        {'label': 'days'.tr, 'value': 1},
        {'label': 'months'.tr, 'value': 2},
        {'label': 'years'.tr, 'value': 3}
      ].map((i) => Item(
          label: i['label'].toString(),
          value: i['value']
      )).toList();
    }

    dynamic result = await showDialog(
      context: context,
      builder: (context) => dialogItemSelect(context,
        label: label,
        items: items
      )
    );
    if(result == null) return;

    if(key == 'status') {
      status.value = statuses.firstWhere((i) => i.id == result['value']);
      fieldStatus.value.value = TextEditingValue(text: status.value.name!);
    } else if(key == 'person') {
      user.value = users.firstWhere((i) => i.id == result['value']);
      fieldPersonOnCharger.value.value = TextEditingValue(text: user.value.fullName!);
    } else if(key == 'office') {
      office.value = offices.firstWhere((i) => i.id == result['value']);
      fieldOffice.value.value = TextEditingValue(text: office.value.name!);
      DioClient().get('/location/building-by-office/${office.value.id}').then((res) =>
        buildings.value = List.from(res['data'].map((i) => Building.fromJson(i)))
      );
    } else if(key == 'building') {
      building.value = buildings.firstWhere((i) => i.id == result['value']);
      fieldBuilding.value.value = TextEditingValue(text: building.value.name!);
      DioClient().get('/location/floor-by-building/${building.value.id}').then((res) {
        floors.value = List.from(res['data'].map((i) => Floor.fromJson(i)));
      });
    } else if(key == 'floor') {
      floor.value = floors.firstWhere((i) => i.id == result['value']);
      fieldFloor.value.value = TextEditingValue(text: floor.value.name!);
      DioClient().get('/location/room-by-floor/${floor.value.id}').then((res) {
        rooms.value = List.from(res['data'].map((i) => Room.fromJson(i)));
      });
    } else if(key == 'room') {
      room.value = rooms.firstWhere((i) => i.id == result['value']);
      fieldRoom.value.value = TextEditingValue(text: room.value.name!);
    } else if(key == 'group') {
      group.value = groups.firstWhere((i) => i.id == result['value']);
      fieldGroup.value.value = TextEditingValue(text: group.value.name!);
      DioClient().get('/category/by-group/${group.value.id}').then((res) {
        categories.value = List.from(res['data'].map((i) => Category.fromJson(i)));
      });
    } else if(key == 'category') {
      category.value = categories.firstWhere((i) => i.id == result['value']);
      fieldCategory.value.value = TextEditingValue(text: category.value.name!);
      DioClient().get('/category/sub-category-by-category/${category.value.id}').then((res) {
        subCategories.value = List.from(res['data'].map((i) => Category.fromJson(i)));
      });
    } else if(key == 'sub-category') {
      subCategory.value = subCategories.firstWhere((i) => i.id == result['value']);
      fieldSubCategory.value.value = TextEditingValue(text: subCategory.value.name!);
      DioClient().post('/asset/generate-code',
        data: {
          'office': office.value.id,
          'floor': floor.value.id,
          'room': room.value.id,
          'group': group.value.id,
          'category': category.value.id,
          'subcategory': subCategory.value.id
        }
      ).then((res) => fieldTagAsset.value.value = TextEditingValue(text: res['code']));
    } else if(key == 'supplier') {
      supplier.value = suppliers.firstWhere((i) => i.id == result['value']);
      fieldSupplier.value.value = TextEditingValue(text: supplier.value.name!);
    } else if(key == 'brand') {
      brand.value = brands.firstWhere((i) => i.id == result['value']);
      fieldBrand.value.value = TextEditingValue(text: brand.value.name!);
    } else if(key == 'warranty') {
      warrantyType.value = result['value'];
    }
  }

  void selectDate(context) async {
    final date = await showDatePicker(
        context: context,
        firstDate: DateTime(2005),
        initialDate: DateTime.now(),
        lastDate: DateTime(2100)
    );

    if(date == null) return;
    String selectDate = DateFormat('yyyy-MM-dd').format(date);
    fieldPurchaseDate.value.value = TextEditingValue(text: selectDate);
    selectedDate = date;
  }

  void selectedImage(List<XFile> files) async {
    showAlertImage.value = false;
    if(files.isEmpty) return;

    imageFile = files.first;
    imageName.value = files.first.name;
    final bytes = await files.first.readAsBytes();
    if((bytes.lengthInBytes/(1024 *1024)) > 4) showAlertImage.value = true;
    update();
  }

  void save(context) async {
    LoadingFullscreen.startLoading();
    dynamic bytes;
    if(imageFile != null ) bytes = await imageFile!.readAsBytes();
    final payload = FormData.fromMap({
      if(type.value == 'edit') 'id': asset.value.id,
      'picture': imageFile != null
          ? MultipartFile.fromBytes(bytes, filename: imageFile!.name, contentType: DioMediaType('image', 'jpeg'))
          : null,
      'office': office.value.toJson(),
      'building': building.value.toJson(),
      'floor': floor.value.toJson(),
      'room': room.value.toJson(),
      'group': group.value.toJson(),
      'category': category.value.toJson(),
      'subcategory': subCategory.value.toJson(),
      'message': fieldTagAsset.value.value.text,
      'name': fieldName.value.value.text,
      'supplierid': supplier.value.id,
      'brandid': brand.value.id,
      'serial': fieldSerial.value.value.text,
      if(type.value == 'add') 'quantity': 1,
      'purchasedate': (type.value == 'edit' && selectedDate == null)
          ? DateFormat('yyyy-MM-dd').format(DateFormat('dd-MM-yyyy').parse(asset.value.purchaseDate!))
          : selectedDate,
      'cost': fieldCost.value.value.text,
      'warranty_type': warrantyType.value,
      'warranty': fieldWarranty.value.value.text,
      'status': status.value.id,
      'description': fieldDescription.value.value.text,
      'pic': user.value.id,
      'tax_report': '0',
    });

    dynamic response;
    if(type.value == 'add') {
      response = await DioClient().post('/asset/add',
          data: payload
      );
    } else {
      response = await DioClient().post('/asset/update',
          data: payload
      );
    }

    LoadingFullscreen.stopLoading();
    if(response['success'] ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.lightBlue,
            content: Text('successful_'.trParams({'value': 'add_asset'.tr})),
            behavior: SnackBarBehavior.floating,
          )
      );
      Get.back(result: true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text('Oppss..!!'),
            behavior: SnackBarBehavior.floating,
          )
      );
    }
  }
}
