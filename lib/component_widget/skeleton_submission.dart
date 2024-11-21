import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget skeletonSubmissionItem() {
  return Shimmer.fromColors(
    baseColor: Colors.white,
    highlightColor: Colors.blue.shade200,
    child: Column( children: [
      for(int i=0; i<4; i++) Container(
        height: 160,
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

Widget skeletonSelectedSupplier() {
  return Shimmer.fromColors(
    baseColor: Colors.white,
    highlightColor: Colors.blue.shade200,
    child: Column( children: [
      Container(
        height: 28,
        margin: const EdgeInsets.only(right: 14, left: 14, top: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.blue.shade200,
        ),
      ),
      for(int i=0; i<4; i++) Container(
        height: 60,
        margin: EdgeInsets.only(right: 14, left: 14,
            top: i == 0 ? 24 : 18
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

Widget skeletonDetailSubmission() {
  return Shimmer.fromColors(
    baseColor: Colors.white,
    highlightColor: Colors.blue.shade200,
    child: Column( children: [
      for(int i=0; i<3; i++) Container(
        height: i == 1 ? 100 : 140,
        margin: EdgeInsets.only(right: 14, left: 14,
            top: i == 0 ? 14 : 16
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