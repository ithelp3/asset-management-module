import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget skeletonDepreciationItem() {
  return Shimmer.fromColors(
    baseColor: Colors.white,
    highlightColor: Colors.blue.shade200,
    child: Column( children: [
       Container(
          height: 28,
          margin: const EdgeInsets.only(right: 14, left: 14, top: 80),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.blue.shade200,
          ),
        ),
        for(int i=0; i<4; i++) Container(
          height: 12,
          margin: EdgeInsets.only(right: 14, left: 14, top: i == 0 ? 20 : 8),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue.shade200,
          ),
        ),
      ],),
  );
}