import 'package:asset_management_module/asset/add_edit_asset/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_file_selector/flutter_web_file_selector.dart';
import 'package:get/get.dart';

class AddEditAssetPage extends StatelessWidget {
  const AddEditAssetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AddEditAssetController(),
      builder: (ctr) => Obx(() => Scaffold(
        appBar: AppBar(
          title: Text('${ctr.type.toString().tr} Asset'),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios,
              color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,),
          ),
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : const Color(0xFF272d34),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Form(
                key: ctr.formKey.value,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'name'.tr,
                          hintText: 'write_in_field'.trParams({'value': 'name'.tr}),
                          prefixIcon: const Icon(Icons.web_asset_outlined, color: Color(0xFF3f87b9), size: 22,),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFF3f87b9)
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'please_in_field'.trParams({'value': 'name'.tr})
                            : null,
                        controller: ctr.fieldName.value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        onTap: () => ctr.selectItem(context, 'status'),
                        decoration: InputDecoration(
                          labelText: 'status'.tr,
                          hintText: 'select_item_field'.trParams({'value': 'status'.tr}),
                          prefixIcon: const Icon(Icons.sync, color: Color(0xFF3f87b9), size: 22,),
                          suffixIcon: const Icon(Icons.expand_more_outlined, color: Color(0xFF3f87b9),),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFF3f87b9)
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'please_in_field'.trParams({'value': 'status'.tr})
                            : null,
                        controller: ctr.fieldStatus.value,
                      ),
                    ),Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        onTap: () => ctr.selectItem(context, 'person'),
                        decoration: InputDecoration(
                          labelText: 'person_on_charge'.tr,
                          hintText: 'select_item_field'.trParams({'value': 'person_on_charge'.tr}),
                          prefixIcon: const Icon(Icons.person, color: Color(0xFF3f87b9), size: 22,),
                          suffixIcon: const Icon(Icons.expand_more_outlined, color: Color(0xFF3f87b9),),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFF3f87b9)
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'please_in_field'.trParams({'value': 'person_on_charge'.tr})
                            : null,
                        controller: ctr.fieldPersonOnCharger.value,
                      ),
                    ),Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        onTap: () => ctr.selectItem(context, 'office'),
                        decoration: InputDecoration(
                          labelText: 'office'.tr,
                          hintText: 'select_item_field'.trParams({'value': 'office'.tr}),
                          prefixIcon: const Icon(Icons.maps_home_work_outlined, color: Color(0xFF3f87b9), size: 22,),
                          suffixIcon: const Icon(Icons.expand_more_outlined, color: Color(0xFF3f87b9),),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFF3f87b9)
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'please_in_field'.trParams({'value': 'office'.tr})
                            : null,
                        controller: ctr.fieldOffice.value,
                      ),
                    ),Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        enabled: ctr.buildings.isNotEmpty,
                        onTap: () => ctr.selectItem(context, 'building'),
                        decoration: InputDecoration(
                          labelText: 'building'.tr,
                          hintText: 'select_item_field'.trParams({'value': 'building'.tr}),
                          prefixIcon: const Icon(Icons.maps_home_work_outlined, color: Color(0xFF3f87b9), size: 22,),
                          suffixIcon: const Icon(Icons.expand_more_outlined, color: Color(0xFF3f87b9),),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFF3f87b9)
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'please_in_field'.trParams({'value': 'building'.tr})
                            : null,
                        controller: ctr.fieldBuilding.value,
                      ),
                    ),Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        enabled: ctr.floors.isNotEmpty,
                        onTap: () => ctr.selectItem(context, 'floor'),
                        decoration: InputDecoration(
                          labelText: 'floor'.tr,
                          hintText: 'select_item_field'.trParams({'value': 'floor'.tr}),
                          prefixIcon: const Icon(Icons.door_back_door_outlined, color: Color(0xFF3f87b9), size: 22,),
                          suffixIcon: const Icon(Icons.expand_more_outlined, color: Color(0xFF3f87b9),),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFF3f87b9)
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        controller: ctr.fieldFloor.value,
                      ),
                    ),Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        enabled: ctr.rooms.isNotEmpty,
                        onTap: () => ctr.selectItem(context, 'room'),
                        decoration: InputDecoration(
                          labelText: 'room'.tr,
                          hintText: 'select_item_field'.trParams({'value': 'room'.tr}),
                          prefixIcon: const Icon(Icons.meeting_room_outlined, color: Color(0xFF3f87b9), size: 22,),
                          suffixIcon: const Icon(Icons.expand_more_outlined, color: Color(0xFF3f87b9),),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFF3f87b9)
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        controller: ctr.fieldRoom.value,
                      ),
                    ),Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        onTap: () => ctr.selectItem(context, 'group'),
                        decoration: InputDecoration(
                          labelText: 'group'.tr,
                          hintText: 'select_item_field'.trParams({'value': 'group'.tr}),
                          prefixIcon: const Icon(Icons.category_outlined, color: Color(0xFF3f87b9), size: 22,),
                          suffixIcon: const Icon(Icons.expand_more_outlined, color: Color(0xFF3f87b9),),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFF3f87b9)
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'please_in_field'.trParams({'value': 'group'.tr})
                            : null,
                        controller: ctr.fieldGroup.value,
                      ),
                    ),Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        enabled: ctr.categories.isNotEmpty,
                        onTap: () => ctr.selectItem(context, 'category'),
                        decoration: InputDecoration(
                          labelText: 'category'.tr,
                          hintText: 'select_item_field'.trParams({'value': 'category'.tr}),
                          prefixIcon: const Icon(Icons.category_outlined, color: Color(0xFF3f87b9), size: 22,),
                          suffixIcon: const Icon(Icons.expand_more_outlined, color: Color(0xFF3f87b9),),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFF3f87b9)
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'please_in_field'.trParams({'value': 'category'.tr})
                            : null,
                        controller: ctr.fieldCategory.value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        enabled: ctr.subCategories.isNotEmpty,
                        onTap: () => ctr.selectItem(context, 'sub-category'),
                        decoration: InputDecoration(
                          labelText: 'sub_category'.tr,
                          hintText: 'select_item_field'.trParams({'value': 'sub_category'.tr}),
                          prefixIcon: const Icon(Icons.category_outlined, color: Color(0xFF3f87b9), size: 22,),
                          suffixIcon: const Icon(Icons.expand_more_outlined, color: Color(0xFF3f87b9),),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFF3f87b9)
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'please_in_field'.trParams({'value': 'sub_category'.tr})
                            : null,
                        controller: ctr.fieldSubCategory.value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'tag_asset'.tr,
                          // hintText: 'write_the_@_here'.trParams({'value': 'tag_asset'}),
                          prefixIcon: const Icon(Icons.tag, color: Color(0xFF3f87b9), size: 22,),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFF3f87b9)
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'please_in_field'.trParams({'value': 'tag_asset'.tr})
                            : null,
                        controller: ctr.fieldTagAsset.value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        onTap: () => ctr.selectItem(context, 'supplier'),
                        decoration: InputDecoration(
                          labelText: 'supplier'.tr,
                          hintText: 'select_item_field'.trParams({'value': 'supplier'.tr}),
                          prefixIcon: const Icon(Icons.storefront_outlined, color: Color(0xFF3f87b9), size: 22,),
                          suffixIcon: const Icon(Icons.expand_more_outlined, color: Color(0xFF3f87b9),),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFF3f87b9)
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        controller: ctr.fieldSupplier.value,
                      ),
                    ),Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        onTap: () => ctr.selectItem(context, 'brand'),
                        decoration: InputDecoration(
                          labelText: 'brand'.tr,
                          hintText: 'select_item_field'.trParams({'value': 'brand'.tr}),
                          prefixIcon: const Icon(Icons.label_outline_rounded, color: Color(0xFF3f87b9), size: 22,),
                          suffixIcon: const Icon(Icons.expand_more_outlined, color: Color(0xFF3f87b9),),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFF3f87b9)
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        controller: ctr.fieldBrand.value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'serial'.tr,
                          hintText: 'write_in_field'.trParams({'value': 'serial'.tr}),
                          prefixIcon: const Icon(Icons.qr_code_2_outlined, color: Color(0xFF3f87b9), size: 22,),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFF3f87b9)
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        controller: ctr.fieldSerial.value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        onTap: () => ctr.selectDate(context),
                        decoration: InputDecoration(
                          labelText: 'purchase_date'.tr,
                          hintText: 'select_item_field'.trParams({'value': 'purchase_date'.tr}),
                          prefixIcon: const Icon(Icons.calendar_month_outlined, color: Color(0xFF3f87b9), size: 22,),
                          suffixIcon: const Icon(Icons.expand_more_outlined, color: Color(0xFF3f87b9),),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFF3f87b9)
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        controller: ctr.fieldPurchaseDate.value,
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'please_in_field'.trParams({'value': 'purchase_date'.tr})
                            : null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'warranty'.tr,
                          hintText: 'write_in_field'.trParams({'value': 'warranty'.tr}),
                          prefixIcon: const Icon(Icons.date_range_outlined, color: Color(0xFF3f87b9), size: 22,),
                          suffixIcon: GestureDetector(
                            onTap: () => ctr.selectItem(context, 'warranty'),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(ctr.warrantyTypes[ctr.warrantyType.value-1]),
                                  const Icon(Icons.expand_more_outlined, color: Color(0xFF3f87b9),),
                                ],
                              ),
                            ),
                          ),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFF3f87b9)
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        controller: ctr.fieldWarranty.value,
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'please_in_field'.trParams({'value': 'warranty'.tr})
                            : null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'cost'.tr,
                          hintText: 'write_in_field'.trParams({'value': 'cost'.tr}),
                          prefixIcon: const Icon(Icons.account_balance_wallet_outlined, color: Color(0xFF3f87b9), size: 22,),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFF3f87b9)
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        controller: ctr.fieldCost.value,
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'please_in_field'.trParams({'value': 'cost'.tr})
                            : null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'description'.tr,
                          hintText: 'write_in_field'.trParams({'value': 'description'.tr}),
                          prefixIcon: const Icon(Icons.chat_outlined, color: Color(0xFF3f87b9), size: 22,),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFF3f87b9)
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        minLines: 2,
                        maxLines: 3,
                        controller: ctr.fieldDescription.value,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, left: 10, right: 10,),
                      padding: const EdgeInsets.only(top: 20, bottom: 20, right: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.light
                              ? Colors.white
                              : const Color(0xFF272d34),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFF3f87b9))
                      ),
                      child: WebFileSelector(
                        onData: (files) async => ctr.selectedImage(files),
                        accept: '.png, .jpg, .jpeg,',
                        multiple: false,
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Icon(Icons.upload_rounded, color: Color(0xFF3f87b9), size: 30,),
                            ),
                            Expanded(
                              child: Text(ctr.imageName.value != '' ? ctr.imageName.value : 'upload_image_asset'.tr,
                                style: TextStyle(color: ctr.imageName.value != ''
                                    ? Colors. black
                                  :  Colors.grey
                                ),),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.only(bottom: 40, top: 10, left: 10, right: 10),
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.white
                      : const Color(0xFF272d34)
              ),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)
                      ),
                      backgroundColor: const Color(0xFF3f87b9),
                      foregroundColor: Colors.white
                  ),
                  onPressed: () {
                    if(ctr.formKey.value.currentState!.validate())ctr.save(context);
                  },
                  child: Text('save'.tr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
              ),
            )
          ],
        ),
      ))
    );
  }
}
