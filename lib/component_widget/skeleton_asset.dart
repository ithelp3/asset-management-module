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

Widget skeletonAssetDetailsHead(BuildContext context) {
  return Shimmer.fromColors(
    enabled: true,
    baseColor: Colors.white,
    highlightColor: Colors.grey.shade200,
    child: Column(
      children: [
        Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width/2) - 40),
              height: 70,
              width: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200
              ),
            ),
            Container(
              height: 20,
              width: 300,
              margin: EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200
              ),
            )
          ],
        ),
        for(int i=0;i<2;i++) Container(
          height: 14,
          width: double.infinity,
          margin: EdgeInsets.only(top: i==0 ? 10 : 6, left: 20, right: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.grey.shade200
          ),
        )
      ],
    ),
  );
}

Widget skeletonAssetDetailsView(BuildContext context) {
  return Shimmer.fromColors(
    enabled: true,
    baseColor: Colors.white,
    highlightColor: Colors.grey.shade200,
    child: Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: (MediaQuery.of(context).size.width/2) - 120,
            ),
            height: 100,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade200
            ),
          ),
          for(int i=0;i<14;i++) Container(
            height: 16,
            width: double.infinity,
            margin: EdgeInsets.only(top: i==0 ? 14 : 10, left: 20, right: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.grey.shade200
            ),
          )
        ],
      ),
    ),
  );
}