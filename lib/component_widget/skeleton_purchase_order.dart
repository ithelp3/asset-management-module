import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget skeletonForm() {
  return Shimmer.fromColors(
    baseColor: Colors.white,
    highlightColor: Colors.blue.shade200,
    child: Column( children: [
      for(int i=0; i<4; i++) Container(
        height: i != 3 ? 50 : 100,
        margin: EdgeInsets.only(right: 14, left: 14,
            top: i == 0 ? 20 : 16
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue.shade200,
        ),
      ),
    ],),
  );
}

Widget skeletonPurchaseItem() {
  return Shimmer.fromColors(
    baseColor: Colors.white,
    highlightColor: Colors.blue.shade200,
    child: Column( children: [
      for(int i=0; i<4; i++) Container(
        height: 140,
        margin: EdgeInsets.only(
            left: 12, right: 12,
            top: i == 0 ? 10 : 14
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue.shade200,
        ),
      ),
    ],),
  );
}