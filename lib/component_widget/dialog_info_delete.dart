import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget dialogInfoDelete(BuildContext context, {
  required String title,
  required String info,
  required double height
}) {
  return Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8)
    ),
    child: Container(
      height: height,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(color: Color(0xFF3f87b9), fontSize: 16),),
          Text(info,
            textAlign: TextAlign.center,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                    onPressed: () => Get.back(result: false),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Color(0xFF3f87b9)),
                          borderRadius: BorderRadius.circular(8)
                      ),
                    ),
                    child: const Text('Batal', style: TextStyle(fontSize: 14, color: Color(0xFF3f87b9)),)
                ),
              ),
              const VerticalDivider(width: 10,),
              Expanded(
                child: ElevatedButton(
                    onPressed: () => Get.back(result: true),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3f87b9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.zero
                    ),
                    child: Text('yes_delete'.tr, style: const TextStyle(color: Colors.white, fontSize: 13),)
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}