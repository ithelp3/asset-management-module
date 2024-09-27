import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';

class QaController extends GetxController {
  Gemini gemini = Gemini.init(apiKey: 'AIzaSyBsiXKTTMlnXzsnmc2X4EL0dF24In5-BSc');
  ChatUser? user1;
  ChatUser? user2;
  RxList<ChatMessage> messages = <ChatMessage>[].obs;
  RxList<ChatUser> messagesUser = <ChatUser>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    user1 = ChatUser(
      id: '1',
      firstName: 'Turapika',
      lastName: '',
    );
    user2 = ChatUser(
      id: '2',
      firstName: 'DungDung',
      lastName: '',
    );
  }

  void send(ChatMessage message) async {
    messages.insert(0, message);
    update();

    gemini.streamGenerateContent(message.text).listen((res) {
      print('~~ ${message.text}');
      print('~~ $res');
      messages.insert(0, ChatMessage(
          text: res.content!.parts!.first.text!,
          user: user2!,
          createdAt: DateTime.now()
      ));
      update();
    });
  }
}
