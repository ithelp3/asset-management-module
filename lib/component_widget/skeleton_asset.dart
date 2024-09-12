import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget skeletonAssetItem() {
  return Shimmer.fromColors(
    enabled: true,
    baseColor: Colors.white,
    highlightColor: Colors.grey.shade200,
    child: Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(children: [
            Container(
              height: 60,
              margin: const EdgeInsets.only(left: 20, top: 10),
              width: 90,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey
              ),
            ),
            Column(children: [
              for(int i=0; i<2; i++)Container(
                height: 20,
                margin: const EdgeInsets.only(right: 10, left: 10, top: 10),
                width: 280,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey
                ),
              ),
            ],)
          ],),
          for(int i=0; i<4; i++) Container(
            height: 16,
            margin: EdgeInsets.only(right: 14, left: 14, top: i == 0 ? 16 : 8),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey
            ),
          ),
        ],
      ),
    ),
  );
}