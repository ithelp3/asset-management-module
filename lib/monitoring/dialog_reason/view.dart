import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class DialogReasonPage extends StatelessWidget {
  const DialogReasonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DialogReasonController(),
      builder: (ctr) => Obx(() => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: SizedBox(
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 14),
                child: Text(ctr.type.value == 'approve'
                    ? 'approve_submission'.tr
                    : 'reject_submission'.tr,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Form(
                  key: ctr.formKey.value,
                  child: TextFormField(
                    minLines: 3,
                    maxLines: 5,
                    maxLength: 200,
                    controller: ctr.fieldReason.value,
                    autofocus: true,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'please_in_field'.trParams({'value': 'reason'.tr})
                        : null,
                    decoration: InputDecoration(
                      labelText: 'reason'.tr,
                      hintText: 'write_in_field'.trParams({'value': 'reason'.tr}),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0xFF3f87b9)
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12, left: 12, bottom: 14),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if(ctr.formKey.value.currentState!.validate()) ctr.send();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3f87b9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                    ),
                    child: Text('send'.tr, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                  ),
                ),
              )
            ],
          ),
        ),
      ))
    );
  }
}
