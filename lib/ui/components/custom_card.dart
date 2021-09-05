import 'package:chatapp/models/chat_model.dart';
import 'package:chatapp/ui/screens/single_chat_screen/single_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomCard extends StatelessWidget {
  ChatModel chatModel;
  ChatModel sourceChat;
  CustomCard({@required this.chatModel, @required this.sourceChat});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.to(() => SingleChatScreen(
              chatModel: chatModel,
              sourchat: sourceChat,
            ));
      },
      leading: CircleAvatar(
        radius: 26,
        backgroundColor: Colors.grey.shade400,
        child: SvgPicture.asset(
          chatModel.isGroup ? "assets/groups.svg" : "assets/person.svg",
          color: Colors.white,
          height: 26,
          width: 26,
        ),
      ),
      title: Text(
        chatModel.name,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Row(
        children: [
          Icon(
            Icons.done_all,
            color: Colors.grey,
            size: 16,
          ),
          SizedBox(width: 4),
          Text(
            chatModel.msg,
            style: TextStyle(
              fontSize: 13,
            ),
          ),
        ],
      ),
      trailing: Text(chatModel.time),
    );
  }
}
