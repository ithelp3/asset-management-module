import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Item{
  String? label;
  dynamic value;
  Item({this.label, this.value});
}

Widget dialogItemSelect(BuildContext context, {
  required String label,
  required List<Item> items,
}) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    child: SizedBox(
      height: MediaQuery.of(context).size.height/2,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6)),
              color: Color(0xFF3f87b9),
            ),
            child: Text(label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),),
          ),
          Expanded(child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, idx) {
                dynamic item = items[idx];
                return InkWell(
                  onTap: () => Get.back(result: {
                    'value': item.value
                  }),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18, top: 12, bottom: 12),
                        child: Text(item.label!),
                      ),
                      const Divider(color: Colors.white, height: 4,)
                    ],
                  ),
                );
              }
          ),
          )
        ],
      ),
    ),
  );
}