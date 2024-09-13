import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget skeletonPie() {
  return Shimmer.fromColors(
    enabled: true,
    baseColor: Colors.white,
    highlightColor: Colors.grey.shade200,
    child: Padding(
      padding: const EdgeInsets.only(top: 10),
      child:
      // Column(
      //   children: [
          Container(
            height: 260,
            margin: const EdgeInsets.only(right: 14, left: 14, top: 10),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey
            ),
          ),
          // Row(children: [
          //   Container(
          //     height: 180,
          //     margin: const EdgeInsets.only(right: 10, left: 20),
          //     width: 180,
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(100),
          //         color: Colors.grey
          //     ),
          //   ),
          //   Column(children: [
          //     for(int i=0; i<3; i++)Container(
          //       height: 20,
          //       margin: const EdgeInsets.only(right: 10, left: 20, top: 10),
          //       width: 160,
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(8),
          //           color: Colors.grey
          //       ),
          //     ),
          //   ],)
          // ],),
      //   ],
      // ),
    ),
  );
}