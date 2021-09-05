import 'package:chatapp/models/chat_model.dart';
import 'package:chatapp/ui/components/custom_card.dart';
import 'package:chatapp/ui/screens/select_contact/select_contact.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  final List<ChatModel> chatmodels;
  final ChatModel sourceChat;

  const ChatScreen(
      {Key key, @required this.chatmodels, @required this.sourceChat})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // List<ChatModel> chats = [
  //   ChatModel(
  //     name: "Elon",
  //     icon: "person.svg",
  //     isGroup: false,
  //     time: "18:04",
  //     msg: "Hi everyone",
  //   ),
  //   ChatModel(
  //     name: "Bill",
  //     icon: "person.svg",
  //     isGroup: false,
  //     time: "16:04",
  //     msg: "Hi Mayur",
  //   ),
  //   ChatModel(
  //     name: "Albert",
  //     icon: "person.svg",
  //     isGroup: false,
  //     time: "19:04",
  //     msg: "Hi Boss",
  //   ),
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => SelectContact());
        },
        child: Icon(
          Icons.chat,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: widget.chatmodels.length,
        itemBuilder: (context, index) {
          return CustomCard(
            chatModel: widget.chatmodels[index],
            sourceChat: widget.sourceChat,
          );
        },
      ),
    );
  }
}
