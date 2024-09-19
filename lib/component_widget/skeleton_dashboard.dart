import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget skeletonPie() {
  return Shimmer.fromColors(
    enabled: true,
    baseColor: Colors.white,
    highlightColor: Colors.blue.shade200,
    child: Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        height: 260,
        margin: const EdgeInsets.only(right: 14, left: 14, top: 10),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue.shade200,
        ),
      ),
    ),
  );
}