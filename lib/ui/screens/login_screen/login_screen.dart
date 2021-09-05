import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter your phone number"),
      ),
    );
  }
}

// class LoginScreen extends StatefulWidget {
//   LoginScreen({Key key}) : super(key: key);

//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   ChatModel sourceChat;
//   List<ChatModel> chatmodels = [
//     ChatModel(
//       name: "Dev Stack",
//       isGroup: false,
//       msg: "Hi Everyone",
//       time: "4:00",
//       icon: "person.svg",
//       id: 1,
//     ),
//     ChatModel(
//       name: "Kishor",
//       isGroup: false,
//       msg: "Hi Kishor",
//       time: "13:00",
//       icon: "person.svg",
//       id: 2,
//     ),

//     ChatModel(
//       name: "Collins",
//       isGroup: false,
//       msg: "Hi Dev Stack",
//       time: "8:00",
//       icon: "person.svg",
//       id: 3,
//     ),

//     ChatModel(
//       name: "Balram Rathore",
//       isGroup: false,
//       msg: "Hi Dev Stack",
//       time: "2:00",
//       icon: "person.svg",
//       id: 4,
//     ),

//     // ChatModel(
//     //   name: "NodeJs Group",
//     //   isGroup: true,
//     //   msg: "New NodejS Post",
//     //   time: "2:00",
//     //   icon: "group.svg",
//     // ),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//           itemCount: chatmodels.length,
//           itemBuilder: (contex, index) => InkWell(
//                 onTap: () {
//                   sourceChat = chatmodels.removeAt(index);
//                   Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                           builder: (builder) => HomeScreen(
//                                 chatmodels: chatmodels,
//                                 sourceChat: sourceChat,
//                               )));
//                 },
//                 child: ButtonCard(
//                   name: chatmodels[index].name,
//                   icon: Icons.person,
//                 ),
//               )),
//     );
//   }
// }
