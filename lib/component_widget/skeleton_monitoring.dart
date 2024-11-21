import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget skeletonMonitoringItem() {
  return Shimmer.fromColors(
    baseColor: Colors.white,
    highlightColor: Colors.blue.shade200,
    child: Column( children: [
      for(int i=0; i<4; i++) Container(
        height: 140,
        margin: const EdgeInsets.only(right: 14, left: 14, top: 12),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue.shade200,
        ),
      ),
    ],),
  );
}

Widget skeletonMonitoringItemDashboard() {
  return Shimmer.fromColors(
    baseColor: Colors.white,
    highlightColor: Colors.blue.shade200,
    child: Column( children: [
      for(int i=0; i<4; i++) Container(
        height: 120,
        margin: EdgeInsets.only(top: i == 0 ? 10 : 14),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue.shade200,
        ),
      ),
    ],),
  );
}