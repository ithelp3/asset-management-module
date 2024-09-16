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
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
}
