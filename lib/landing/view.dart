import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: LandingController(),
        builder: (ctr) => Scaffold(
          body: Obx(() => Column(
            children: [
              Expanded(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: ctr.languages.map((lg) {
                        String id = lg['id'];
                        String label = lg['label'];
                        return GestureDetector(
                          onTap: () => ctr.changeLanguage(id),
                          child: Card(
                            shadowColor: ctr.language.value == id ? Colors.blueAccent : Colors.grey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                    color: ctr.language.value == id ? Colors.blueAccent : Colors.grey.shade200
                                )
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  CountryFlag.fromLanguageCode(id,
                                    borderRadius: 40,
                                    width: 100,
                                    height: 80,
                                  ),
                                  const Divider(height: 10),
                                  Text(label),
                                ],
                              ),
                            ),
                          ),
                        );
                      },).toList()
                  ),
                  const Divider(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: ctr.themes.map((theme) => GestureDetector(
                        onTap: () => ctr.changeTheme(theme),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                              side: BorderSide(
                                color: ctr.theme.value == theme ? Colors.blueAccent : Colors.grey.shade200,
                              )
                          ),
                          shadowColor: ctr.theme.value == theme ? Colors.blueAccent : Colors.grey,
                          child: Container(
                              alignment: Alignment.center,
                              height: 100,
                              width: 100,
                              child: Text(theme)
                          ),
                        ),
                      )).toList(),
                    ),
                  ),
                ],
              )),
              Container(
                margin: const EdgeInsets.only(bottom: 30, right: 30),
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        side: const BorderSide(
                            color: Colors.grey
                        )
                    ),
                    onPressed: () => ctr.next(context),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('next'.tr,
                          style: const TextStyle(color: Colors.grey),),
                        const VerticalDivider(width: 4,),
                        const Icon(Icons.arrow_forward_outlined, color: Colors.blue,)
                      ],
                    )
                ),
              )
            ],
          )),
        )
    );
  }
}
