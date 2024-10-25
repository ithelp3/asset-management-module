import 'package:asset_management_module/component_widget/formates.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'controller.dart';

class SetDiscountTaxModalBottomSheetPage extends StatelessWidget {
  const SetDiscountTaxModalBottomSheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SetDiscountTaxModalBottomSheetController(),
      builder: (ctr) => Obx(() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, right: 18, top: 14, bottom: 14),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade200))
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.close, size: 20,)),
                const VerticalDivider(width: 10,),
                Expanded(child: Text('insert_discount_and_tax_here'.tr)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Sub Total', style: TextStyle(fontSize: 14),),
                const VerticalDivider(width: 20,),
                Text(ctr.subTotal.value.toIdr(), style: const TextStyle(fontSize: 14),)
              ],
            ),
          ),
          Row(
            children: [
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12, left: 20, right: 4),
                  child: TextFormField(
                    onChanged: (v) {
                      if(v != '') {
                        ctr.totalDiscount(v);
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'discount'.tr,
                        labelStyle: const TextStyle(color: Color(0xFF3f87b9)),
                        prefixIcon: const Icon(Icons.percent_outlined, color: Color(0xFF3f87b9), size: 18,),
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFF3f87b9)
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFF3f87b9)
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14)
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(3)
                    ],
                    keyboardType: TextInputType.number,
                    controller: ctr.fieldDisc.value,
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12, left: 4, right: 20),
                  child: TextFormField(
                    readOnly: true,
                    enableInteractiveSelection: false,
                    style: TextStyle(color: Colors.grey.shade600),
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                        labelText: 'total_discount'.tr,
                        labelStyle: TextStyle(color: Colors.grey.shade600),
                        prefixText: 'Rp ',
                        prefixStyle: TextStyle(color: Colors.grey.shade600),
                        filled: true,
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey.shade600
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey.shade600
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14)
                    ),
                    controller: ctr.fieldTotalDisc.value,
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 14, left: 20, right: 4),
                  child: TextFormField(
                    onChanged: (v) {
                      if(v != '') {
                        ctr.totalTax(v);
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'tax'.tr,
                        labelStyle: const TextStyle(color: Color(0xFF3f87b9)),
                        prefixIcon: const Icon(Icons.percent_outlined, color: Color(0xFF3f87b9), size: 18,),
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFF3f87b9)
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFF3f87b9)
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14)
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(3)
                    ],
                    keyboardType: TextInputType.number,
                    controller: ctr.fieldTax.value,
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(top: 14, left: 4, right: 20),
                  child: TextFormField(
                    readOnly: true,
                    enableInteractiveSelection: false,
                    style: TextStyle(color: Colors.grey.shade600),
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                        labelText: 'total_tax'.tr,
                        labelStyle: TextStyle(color: Colors.grey.shade600),
                        prefixText: 'Rp ',
                        prefixStyle: TextStyle(color: Colors.grey.shade600),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.shade600
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey.shade600
                          ),
                        ),
                        border: const OutlineInputBorder(),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14)
                    ),
                    controller: ctr.fieldTotalTax.value,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('total_payment'.tr,),
                const VerticalDivider(width: 20,),
                Text((ctr.subTotal.value-ctr.discountTotal.value+ctr.taxTotal.value).toIdr(),)
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 20, top: 18, left: 10, right: 10),
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade200)),
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
                onPressed: () => ctr.save(),
                child: Text('save'.tr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
            ),
          ),
        ],
      ),)
    );
  }
}
