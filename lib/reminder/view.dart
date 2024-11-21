import 'package:asset_management_module/home/controller.dart';
import 'package:asset_management_module/reminder/create_reminder/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

@override
Widget reminder(BuildContext context, HomeController ctr) {
    List items = [
      {'name': 'coba diingat - ingat', 'category': 'asset'.tr, 'date': '10 Sep 2024', 'time': '', 'desc': 'Peminjaman Kulkas dari Gedung A ke Gedung C.', 'repeat': false},
      {'name': 'coba diingat - ingat', 'category': 'submission'.tr, 'date': '10 Sep 2024', 'time': '', 'desc': 'Peminjaman Kulkas dari Gedung A ke Gedung C.', 'repeat': true},
      {'name': 'coba diingat - ingat', 'category': 'lending_asset'.tr, 'date': '10 Sep 2024', 'time': '', 'desc': 'Peminjaman Kulkas dari Gedung A ke Gedung C.', 'repeat': false},
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('reminder'.tr),
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : const Color(0xFF272d34),
        centerTitle: true,
      ),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, idx) {
            dynamic i = items[idx];
            return Container(
              margin: const EdgeInsets.only(top: 10, left: 12, right: 12),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue.shade100),
                boxShadow: [BoxShadow(
                  color: Colors.blue.withOpacity(0.1),
                  blurRadius: 2,
                  spreadRadius: 2,
                  offset: const Offset(1, 2),
                )]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(i['category'] == 'lending_asset'.tr ? Icons.move_up_outlined : Icons.data_exploration,
                        color: i['category'] == 'lending_asset'.tr ?  const Color(0xFF3f87b9) : Colors.yellow.shade700,
                        size: 38,
                      ),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(i['name'].toString(),
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(i['category'], style: const TextStyle(fontSize: 12, color: Colors.grey),)
                          ],
                        ),
                      ),),
                    ],
                  ),
                  Divider(color: Colors.blue.shade100,),
                  Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(DateFormat('HH : mm', 'id_ID').format(DateTime.now()),
                        //   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(DateTime.now()),
                              style: const TextStyle(fontSize: 20,),
                            ),
                            Text(DateFormat('HH : mm', 'id_ID').format(DateTime.now()),
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Divider(height: 6,),
                        Text(i['desc'].toString(),
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        ),
      ),
      floatingActionButton: Visibility(
          visible: !(MediaQuery.of(context).viewInsets.bottom != 0),
          child: FloatingActionButton(
            onPressed: () => Get.to(const CreateReminderPage(),
                routeName: '/reminder/create',
                transition: Transition.rightToLeft
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40)
            ),
            backgroundColor: const Color(0xFF3f87b9),
            child: const Icon(Icons.add, size: 34, color: Colors.white,),
          )
      ),
    );
  }
