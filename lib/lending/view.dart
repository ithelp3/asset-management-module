import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'controller.dart';

class LendingPage extends StatelessWidget {
  const LendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: LendingController(),
      builder: (ctr) => Scaffold(
        appBar: AppBar(
          title: Text('lending'.tr),
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : const Color(0xFF272d34),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios,
              color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,),
          ),
          centerTitle: true,
        ),
        body: Form(
            key: ctr.formKey.value,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: TextFormField(
                          readOnly: true,
                          onTap: () => ctr.selectItem(context, 'asset'),
                          decoration: InputDecoration(
                            labelText: 'asset'.tr,
                            hintText: 'select_item_field'.trParams({'value': 'asset'.tr}),
                            prefixIcon: const Icon(Icons.web_asset_outlined, color: Color(0xFF3f87b9), size: 22,),
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
                              ? 'please_in_field'.trParams({'value': 'asset'.tr})
                              : null,
                          controller: ctr.fieldAsset.value,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'needs'.tr,
                            hintText: 'write_in_field'.trParams({'value': 'needs'.tr}),
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
                              ? 'please_in_field'.trParams({'value': 'needs'.tr})
                              : null,
                          controller: ctr.fieldNeeds.value,
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      //   child: TextFormField(
                      //     readOnly: true,
                      //     onTap: () => ctr.selectDate(context, 'first'),
                      //     decoration: InputDecoration(
                      //       labelText: 'lending_date'.tr,
                      //       hintText: 'select_item_field'.trParams({'value': 'lending_date'.tr}),
                      //       prefixIcon: const Icon(Icons.date_range_outlined, color: Color(0xFF3f87b9), size: 22,),
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
                      //         ? 'please_in_field'.trParams({'value': 'lending_date'.tr})
                      //         : null,
                      //     controller: ctr.fieldFirstDate.value,
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      //   child: TextFormField(
                      //     readOnly: true,
                      //     onTap: () => ctr.selectDate(context, 'last'),
                      //     decoration: InputDecoration(
                      //       labelText: 'return_date'.tr,
                      //       hintText: 'select_in_field'.trParams({'value': 'return_date'.tr}),
                      //       prefixIcon: const Icon(Icons.date_range_outlined, color: Color(0xFF3f87b9), size: 22,),
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
                      //         ? 'please_in_field'.trParams({'value': 'return_date'.tr})
                      //         : null,
                      //     controller: ctr.fieldLastDate.value,
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(top: 14, left: 20, right: 14, bottom: 10),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 8, bottom: 18),
                              child: Row(
                                children: [
                                   Icon(Icons.date_range_outlined, color: Color(0xFF3f87b9), size: 26,),
                                   Expanded(child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Text('Keterangan Tanggal', style: TextStyle(fontSize: 16),),
                                  )),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () => ctr.showSelectCalender('start'),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(18),
                                              boxShadow: [BoxShadow(
                                                color: Colors.blue.withOpacity(0.1),
                                                blurRadius: 2,
                                                spreadRadius: 2,
                                                offset: const Offset(1, 2),
                                              )]
                                          ),
                                          child: const Text('Tanggal Pinjam',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      const Divider(height: 12,),
                                      Text(DateFormat('EE, dd MMMM', 'id_ID').format(ctr.dateStart ?? DateTime.now(),),
                                        style: const TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                ),
                                const Icon(Icons.arrow_forward),
                                Expanded(
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () => ctr.showSelectCalender('end'),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(18),
                                              boxShadow: [BoxShadow(
                                                color: Colors.blue.withOpacity(0.1),
                                                blurRadius: 2,
                                                spreadRadius: 2,
                                                offset: const Offset(1, 2),
                                              )]
                                          ),
                                          child: const Text('Tanggal Kembali',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      const Divider(height: 12,),
                                      Text(DateFormat('EE, dd MMMM', 'id_ID').format(ctr.dateEnd ?? DateTime.now(),),
                                        style: const TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizeTransition(
                              sizeFactor: CurvedAnimation(
                                parent: ctr.animationControllerDate!,
                                curve: Curves.decelerate,
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
                                // onRangeSelected: ctr.selectedRangeDate,
                                rangeSelectionMode: RangeSelectionMode.toggledOn,
                                calendarStyle: const CalendarStyle(
                                  selectedDecoration: BoxDecoration(
                                    color: Color(0xFF3f87b9),
                                    shape: BoxShape.circle,
                                  ),
                                  rangeStartDecoration: BoxDecoration(
                                    color: Color(0xFF3f87b9),
                                    shape: BoxShape.circle,
                                  ),
                                  rangeEndDecoration: BoxDecoration(
                                    color: Color(0xFF3f87b9),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.only(bottom: 40, top: 10, left: 10, right: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : const Color(0xFF272d34)
                  ),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)
                          ),
                          backgroundColor: const Color(0xFF3f87b9),
                          foregroundColor: Colors.white
                      ),
                      onPressed: () {
                        // if(ctr.formKey.value.currentState!.validate()) ctr.save(context);
                      },
                      child: Text('save'.tr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
                  ),
                )
              ],
            )
        ),
      ),
    );
  }
}
