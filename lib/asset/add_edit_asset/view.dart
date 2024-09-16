import 'package:asset_management_module/asset/add_edit_asset/controller.dart';
import 'package:flutter/material.dart';
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
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black,),
          ),
          backgroundColor: Colors.white,
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
                          hintText: 'write_the_@_here'.trParams({'value': 'name'}),
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
                          contentPadding: EdgeInsets.zero,
                        ),
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'please_fill_in_@'.trParams({'value': 'name'})
                            : null,
                        style: const TextStyle(fontSize: 14),
                        controller: ctr.fieldName.value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'status'.tr,
                          hintText: 'write_the_@_here'.trParams({'value': 'status'}),
                          prefixIcon: const Icon(Icons.sync, color: Color(0xFF3f87b9), size: 22,),
                          suffixIcon: const Icon(Icons.expand_more_outlined, color: Color(0xFF3f87b9),),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'please_fill_in_@'.trParams({'value': 'status'})
                            : null,
                        style: const TextStyle(fontSize: 14),
                        controller: ctr.fieldStatus.value,
                      ),
                    ),Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'person_on_changer'.tr,
                          hintText: 'write_the_@_here'.trParams({'value': 'person_on_changer'}),
                          prefixIcon: const Icon(Icons.person, color: Color(0xFF3f87b9), size: 22,),
                          suffixIcon: const Icon(Icons.expand_more_outlined, color: Color(0xFF3f87b9),),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'please_fill_in_@'.trParams({'value': 'person_on_charger'})
                            : null,
                        style: const TextStyle(fontSize: 14),
                        controller: ctr.fieldPersonOnCharger.value,
                      ),
                    ),Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'office'.tr,
                          hintText: 'write_the_@_here'.trParams({'value': 'office'}),
                          prefixIcon: const Icon(Icons.maps_home_work_outlined, color: Color(0xFF3f87b9), size: 22,),
                          suffixIcon: const Icon(Icons.expand_more_outlined, color: Color(0xFF3f87b9),),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'please_fill_in_@'.trParams({'value': 'office'})
                            : null,
                        style: const TextStyle(fontSize: 14),
                        controller: ctr.fieldOffice.value,
                      ),
                    ),Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'building'.tr,
                          hintText: 'write_the_@_here'.trParams({'value': 'building'}),
                          prefixIcon: const Icon(Icons.maps_home_work_outlined, color: Color(0xFF3f87b9), size: 22,),
                          suffixIcon: const Icon(Icons.expand_more_outlined, color: Color(0xFF3f87b9),),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'please_fill_in_@'.trParams({'value': 'building'})
                            : null,
                        style: const TextStyle(fontSize: 14),
                        controller: ctr.fieldBuilding.value,
                      ),
                    ),Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'floor'.tr,
                          hintText: 'write_the_@_here'.trParams({'value': 'floor'}),
                          prefixIcon: const Icon(Icons.door_back_door_outlined, color: Color(0xFF3f87b9), size: 22,),
                          suffixIcon: const Icon(Icons.expand_more_outlined, color: Color(0xFF3f87b9),),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: const TextStyle(fontSize: 14),
                        controller: ctr.fieldFloor.value,
                      ),
                    ),Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'room'.tr,
                          hintText: 'write_the_@_here'.trParams({'value': 'room'}),
                          prefixIcon: const Icon(Icons.meeting_room_outlined, color: Color(0xFF3f87b9), size: 22,),
                          suffixIcon: const Icon(Icons.expand_more_outlined, color: Color(0xFF3f87b9),),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: const TextStyle(fontSize: 14),
                        controller: ctr.fieldRoom.value,
                      ),
                    ),Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'group'.tr,
                          hintText: 'write_the_@_here'.trParams({'value': 'group'}),
                          prefixIcon: const Icon(Icons.category_outlined, color: Color(0xFF3f87b9), size: 22,),
                          suffixIcon: const Icon(Icons.expand_more_outlined, color: Color(0xFF3f87b9),),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'please_fill_in_@'.trParams({'value': 'group'})
                            : null,
                        style: const TextStyle(fontSize: 14),
                        controller: ctr.fieldGroup.value,
                      ),
                    ),Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'category'.tr,
                          hintText: 'write_the_@_here'.trParams({'value': 'category'}),
                          prefixIcon: const Icon(Icons.category_outlined, color: Color(0xFF3f87b9), size: 22,),
                          suffixIcon: const Icon(Icons.expand_more_outlined, color: Color(0xFF3f87b9),),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: const TextStyle(fontSize: 14),
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'please_fill_in_@'.trParams({'value': 'category'})
                            : null,
                        controller: ctr.fieldCategory.value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'sub_category'.tr,
                          hintText: 'write_the_@_here'.trParams({'value': 'sub_category'}),
                          prefixIcon: const Icon(Icons.category_outlined, color: Color(0xFF3f87b9), size: 22,),
                          suffixIcon: const Icon(Icons.expand_more_outlined, color: Color(0xFF3f87b9),),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'please_fill_in_@'.trParams({'value': 'sub_category'})
                            : null,
                        style: const TextStyle(fontSize: 14),
                        controller: ctr.fieldSubCategory.value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'tag_asset'.tr,
                          hintText: 'write_the_@_here'.trParams({'value': 'tag_asset'}),
                          prefixIcon: const Icon(Icons.tag, color: Color(0xFF3f87b9), size: 22,),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'please_fill_in_@'.trParams({'value': 'tag_asset'})
                            : null,
                        style: const TextStyle(fontSize: 14),
                        controller: ctr.fieldTagAsset.value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'supplier'.tr,
                          hintText: 'write_the_@_here'.trParams({'value': 'supplier'}),
                          prefixIcon: const Icon(Icons.storefront_outlined, color: Color(0xFF3f87b9), size: 22,),
                          suffixIcon: const Icon(Icons.expand_more_outlined, color: Color(0xFF3f87b9),),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: const TextStyle(fontSize: 14),
                        controller: ctr.fieldSupplier.value,
                      ),
                    ),Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'brand'.tr,
                          hintText: 'write_the_@_here'.trParams({'value': 'brand'}),
                          prefixIcon: const Icon(Icons.label_outline_rounded, color: Color(0xFF3f87b9), size: 22,),
                          suffixIcon: const Icon(Icons.expand_more_outlined, color: Color(0xFF3f87b9),),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: const TextStyle(fontSize: 14),
                        controller: ctr.fieldBrand.value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'serial'.tr,
                          hintText: 'write_the_@_here'.trParams({'value': 'serial'}),
                          prefixIcon: const Icon(Icons.qr_code_2_outlined, color: Color(0xFF3f87b9), size: 22,),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: const TextStyle(fontSize: 14),
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
                          hintText: 'write_the_@_here'.trParams({'value': 'purchase_date'}),
                          prefixIcon: const Icon(Icons.calendar_month_outlined, color: Color(0xFF3f87b9), size: 22,),
                          suffixIcon: const Icon(Icons.expand_more_outlined, color: Color(0xFF3f87b9),),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: const TextStyle(fontSize: 14),
                        controller: ctr.fieldPurchaseDate.value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'warranty'.tr,
                          hintText: 'write_the_@_here'.trParams({'value': 'warranty'}),
                          prefixIcon: const Icon(Icons.date_range_outlined, color: Color(0xFF3f87b9), size: 22,),
                          suffixIcon: const Icon(Icons.expand_more_outlined, color: Color(0xFF3f87b9),),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: const TextStyle(fontSize: 14),
                        controller: ctr.fieldWarranty.value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'cost'.tr,
                          hintText: 'write_the_@_here'.trParams({'value': 'cost'}),
                          prefixIcon: const Icon(Icons.account_balance_wallet_outlined, color: Color(0xFF3f87b9), size: 22,),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 14),
                        controller: ctr.fieldCost.value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'description'.tr,
                          hintText: 'write_the_@_here'.trParams({'value': 'description'}),
                          prefixIcon: const Icon(Icons.chat_outlined, color: Color(0xFF3f87b9), size: 22,),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          // contentPadding: EdgeInsets.zero,
                        ),
                        minLines: 2,
                        maxLines: 3,
                        style: const TextStyle(fontSize: 14),
                        controller: ctr.fieldDescription.value,
                      ),
                    ),
                  ],
                )
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.only(bottom: 40, top: 10, left: 10, right: 10),
              decoration: const BoxDecoration(
                  color: Colors.white
              ),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)
                      ),
                      backgroundColor: const Color(0xFF3f87b9),
                      foregroundColor: Colors.white
                  ),
                  onPressed: () {},
                  child: Text('save'.tr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
              ),
            )
          ],
        ),
      ))
    );
  }
}
