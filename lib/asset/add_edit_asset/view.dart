import 'package:asset_management_module/asset/add_edit_asset/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEditAssetPage extends StatelessWidget {
  const AddEditAssetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AddEditAssetController(),
      builder: (ctr) => Scaffold(
        appBar: AppBar(
          title: Text(''),
          leading: const Icon(Icons.arrow_back_ios, color: Colors.black,),
        ),
        body: Column(
          children: [
            Expanded(child: Column(
              children: [],
            )),
            SizedBox(
              child: ElevatedButton(
                onPressed: () {},
                child: Text('save')
              ),
            )
          ],
        ),
      )
    );
  }
}
