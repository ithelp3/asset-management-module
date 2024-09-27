import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class QaPage extends StatelessWidget {
  const QaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: QaController(),
      builder: (ctr) => Scaffold(
        body: DashChat(
          currentUser: ctr.user1!,
          onSend: (ChatMessage message) => ctr.send(message),
          messages: ctr.messages,
        ),
      )
    );
  }
}
