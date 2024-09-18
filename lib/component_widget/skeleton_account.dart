import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget skeletonAccountHead() {
  return Shimmer.fromColors(
    enabled: true,
    baseColor: Colors.white,
    highlightColor: Colors.grey.shade200,
    child: Column(
      children: [
        Container(
          height: 90,
          margin: const EdgeInsets.only(left: 20, top: 10),
          width: 90,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey
          ),
        ),
        for(int i=0; i<2; i++) Container(
          height: 16,
          margin: EdgeInsets.only(
              right: i == 0 ? 80 : 100,
              left: i == 0 ? 80 : 100,
              top: i == 0 ? 16 : 8
          ),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey
          ),
        ),
      ],
    ),
  );
}

Widget skeletonAccountCard() {
  return Shimmer.fromColors(
      enabled: true,
      baseColor: Colors.white,
      highlightColor: Colors.grey.shade200,
      child: Column(children: [
        Container(
          height: 400,
          margin: const EdgeInsets.only(right: 14, left: 14, top: 18),
          // width: 280,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey
          ),
        ),
      ],)
  );
}