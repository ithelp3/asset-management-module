import 'package:asset_management_module/component_widget/skeleton_account.dart';
import 'package:asset_management_module/home/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget account(BuildContext context, HomeController ctr) {
  return Scaffold(
    appBar: AppBar(
      title: Text('account'.tr,),
      centerTitle: true,
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : const Color(0xFF272d34),
      automaticallyImplyLeading: false,
    ),
    body: ListView(
      children: [
        if(!ctr.progressProfile.value) Column(
          children: [
            if((ctr.profile.value.picPicture ?? '') == '') const Icon(Icons.person, color: Color(0xFF3f87b9), size: 100,)
            else Container(
              height: 80,
              width: 80,
              margin: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(ctr.profile.value.picPicture ?? '')
                )
              ),
            ),
            Text(ctr.profile.value.fullName ?? 'N/A',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            Container(
              margin: const EdgeInsets.only(top: 6),
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFF3f87b9))
              ),
              child: Text(ctr.profile.value.role?.name ?? 'N/A',
                style: const TextStyle(color: Color(0xFF3f87b9), fontSize: 10),),
            )
          ],
        ) else skeletonAccountHead(),
        if(!ctr.progressProfile.value) Container(
          margin: const EdgeInsets.all(14),
          decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : const Color(0xFF272d34),
              borderRadius: BorderRadius.circular(8)
          ),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.mail_outline, color: Color(0xFF3f87b9),),
                title: Text('email'.tr, style: const TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text(ctr.user.email ?? 'N/A', style: const TextStyle(color: Colors.grey),),
              ),
              ListTile(
                leading: const Icon(Icons.maps_home_work_outlined, color: Color(0xFF3f87b9),),
                title: Text('office'.tr, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(ctr.profile.value.office?.name ?? 'N/A', style: const TextStyle(color: Colors.grey),),
              ),
              ListTile(
                leading: const Icon(Icons.account_tree_outlined, color: Color(0xFF3f87b9),),
                title: Text('department'.tr, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(ctr.profile.value.department?.name ?? 'N/A', style: const TextStyle(color: Colors.grey),),
              ),
              ListTile(
                leading: const Icon(Icons.work_outline, color: Color(0xFF3f87b9),),
                title: Text('position'.tr, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(ctr.profile.value.position ?? 'N/A', style: const TextStyle(color: Colors.grey),),
              ),
              ListTile(
                leading: const Icon(Icons.phone, color: Color(0xFF3f87b9),),
                title: Text('phone'.tr, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(ctr.profile.value.phone ?? 'N/A', style: const TextStyle(color: Colors.grey),),
              ),
              ListTile(
                leading: const Icon(Icons.location_on_outlined, color: Color(0xFF3f87b9),),
                title: Text('address'.tr, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(ctr.profile.value.address ?? 'N/A', style: const TextStyle(color: Colors.grey),),
              ),
            ],
          ),
        ) else skeletonAccountCard(),
      ],
    )
  );
}