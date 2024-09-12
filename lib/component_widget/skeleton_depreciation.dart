import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget skeletonDepreciationItem() {
  return Shimmer.fromColors(
    enabled: true,
    baseColor: Colors.white,
    highlightColor: Colors.grey.shade200,
    child: Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
         Container(
            height: 28,
            margin: const EdgeInsets.only(right: 14, left: 14, top: 8),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey
            ),
          ),
          for(int i=0; i<4; i++) Container(
            height: 12,
            margin: EdgeInsets.only(right: 14, left: 14, top: i == 0 ? 24 : 8),
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