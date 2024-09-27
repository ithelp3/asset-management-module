import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'controller.dart';

class ReminderPage extends StatelessWidget {
  const ReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ReminderController(),
      builder: (ctr) => Scaffold(
        appBar: AppBar(
          title: Text('reminder'.tr),
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : const Color(0xFF272d34),
          // leading: IconButton(
          //   onPressed: () => Get.back(),
          //   icon: Icon(Icons.arrow_back_ios,
          //     color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,),
          // ),
          centerTitle: true,
        ),
        body: Obx(() => ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'name_reminder'.tr,
                  hintText: 'write_in_field'.trParams({'value': 'name_reminder'.tr}),
                  prefixIcon: const Icon(Icons.web_asset_outlined, color: Color(0xFF3f87b9), size: 22,),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color(0xFF3f87b9)
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) => (value == null || value.isEmpty)
                    ? 'please_in_field'.trParams({'value': 'name_reminder'.tr})
                    : null,
                controller: ctr.fieldNameReminder.value,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14, left: 14, right: 14, bottom: 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.date_range_outlined),
                      const Expanded(child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Setiap hari',),
                      )),
                      Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          value: ctr.switchEveryDay.value,
                          trackOutlineColor: !ctr.switchEveryDay.value ? const WidgetStatePropertyAll(Colors.grey) : null,
                          inactiveThumbColor: Colors.grey,
                          onChanged: (value) => ctr.onSwitch(value),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () => ctr.selectDate(),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [BoxShadow(
                                    color: Colors.blue.withOpacity(0.1),
                                    blurRadius: 2,
                                    spreadRadius: 2,
                                    offset: const Offset(1, 2),
                                  )]
                                ),
                                child: Text(DateFormat('EE, dd MMMM', 'id_ID').format(ctr.dateStart ?? DateTime.now()),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const Divider(height: 10,),
                            if(!ctr.switchEveryDay.value) GestureDetector(
                              onTap: () => ctr.selectTime(context, 'timeFirst'),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [BoxShadow(
                                      color: Colors.blue.withOpacity(0.1),
                                      blurRadius: 2,
                                      spreadRadius: 2,
                                      offset: const Offset(1, 2),
                                    )]
                                ),
                                child: Text(DateFormat('HH : mm', 'id_ID').format(DateTime.now()),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward),
                      Expanded(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () => ctr.selectDate(),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [BoxShadow(
                                      color: Colors.blue.withOpacity(0.1),
                                      blurRadius: 2,
                                      spreadRadius: 2,
                                      offset: const Offset(1, 2),
                                    )]
                                ),
                                child: Text(DateFormat('EE, dd MMMM', 'id_ID').format(ctr.dateEnd ?? DateTime.now()),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const Divider(height: 10,),
                            if(!ctr.switchEveryDay.value) GestureDetector(
                              onTap: () => ctr.selectTime(context, 'timeLast'),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [BoxShadow(
                                      color: Colors.blue.withOpacity(0.1),
                                      blurRadius: 2,
                                      spreadRadius: 2,
                                      offset: const Offset(1, 2),
                                    )]
                                ),
                                child: Text(DateFormat('HH : mm', 'id_ID').format(DateTime.now()),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizeTransition(
                    sizeFactor: CurvedAnimation(
                      parent: ctr.animationController!,
                      curve: Curves.decelerate
                    ),
                    child: TableCalendar(
                      locale: 'id_ID',
                      focusedDay: ctr.dateFocus,
                      firstDay: DateTime(2005),
                      lastDay: DateTime(2100),
                      availableGestures: AvailableGestures.all,
                      headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
                      selectedDayPredicate: (day) => isSameDay(day, ctr.dateFocus),
                      onDaySelected: ctr.selectedDate,
                      rangeStartDay: ctr.dateStart,
                      rangeEndDay: ctr.dateEnd,
                      onRangeSelected: ctr.switchEveryDay.value ? ctr.selectedRangeDate : null,
                      rangeSelectionMode: RangeSelectionMode.toggledOn,
                    ),
                  )
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            //   child: TextFormField(
            //     readOnly: true,
            //     onTap: () => ctr.selectTime(context, 'notification'),
            //     decoration: InputDecoration(
            //       labelText: 'notification'.tr,
            //       hintText: 'select_item_field'.trParams({'value': 'notification'.tr}),
            //       prefixIcon: const Icon(Icons.notifications_none, color: Color(0xFF3f87b9), size: 22,),
            //       suffixIcon: const Icon(Icons.expand_more_outlined, color: Color(0xFF3f87b9), size: 30,),
            //       filled: true,
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //       enabledBorder: OutlineInputBorder(
            //         borderSide: const BorderSide(
            //             color: Color(0xFF3f87b9)
            //         ),
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //     ),
            //     validator: (value) => (value == null || value.isEmpty)
            //         ? 'please_in_field'.trParams({'value': 'notification'.tr})
            //         : null,
            //     controller: ctr.fieldNotification.value,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: TextFormField(
                readOnly: true,
                onTap: () => ctr.selected(context, 'repeat'),
                decoration: InputDecoration(
                  labelText: 'repeat'.tr,
                  hintText: 'select_item_field'.trParams({'value': 'repeat'.tr}),
                  prefixIcon: const Icon(Icons.refresh, color: Color(0xFF3f87b9), size: 22,),
                  suffixIcon: const Icon(Icons.expand_more_outlined, color: Color(0xFF3f87b9), size: 30,),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color(0xFF3f87b9)
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) => (value == null || value.isEmpty)
                    ? 'please_in_field'.trParams({'value': 'repeat'.tr})
                    : null,
                controller: ctr.fieldRepeat.value,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: TextFormField(
                readOnly: true,
                onTap: () => ctr.selected(context, 'category'),
                decoration: InputDecoration(
                  labelText: 'category'.tr,
                  hintText: 'write_in_field'.trParams({'value': 'category'.tr}),
                  prefixIcon: const Icon(Icons.category_outlined, color: Color(0xFF3f87b9), size: 22,),
                  suffixIcon: const Icon(Icons.expand_more_outlined, color: Color(0xFF3f87b9), size: 30,),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color(0xFF3f87b9)
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) => (value == null || value.isEmpty)
                    ? 'please_in_field'.trParams({'value': 'category'.tr})
                    : null,
                controller: ctr.fieldCategory.value,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 40),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'description'.tr,
                  hintText: 'write_in_field'.trParams({'value': 'description'.tr}),
                  prefixIcon: const Icon(Icons.chat_outlined, color: Color(0xFF3f87b9), size: 22,),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color(0xFF3f87b9)
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                minLines: 2,
                maxLines: 4,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'please_in_field'.trParams({'value': 'description'.tr})
                    : null,
                controller: ctr.fieldDescription.value,
              ),
            ),
          ],
        )),
        floatingActionButton: Visibility(
            visible: !(MediaQuery.of(context).viewInsets.bottom != 0),
            child: FloatingActionButton(
              onPressed: () {
                // if(ctr.formKey.value.currentState!.validate()) ctr.save();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)
              ),
              backgroundColor: const Color(0xFF3f87b9),
              child: const Icon(Icons.add, size: 34, color: Colors.white,),
            )
        ),
      ),
    );
  }
}
