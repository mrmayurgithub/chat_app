import 'package:chatapp/models/chat_model.dart';
import 'package:chatapp/models/country_model.dart';
import 'package:chatapp/ui/components/button_card.dart';
import 'package:chatapp/ui/screens/home_screen/home_page.dart';
import 'package:chatapp/ui/screens/login_screen/country_screen.dart';
import 'package:chatapp/ui/screens/login_screen/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _textEditingController = TextEditingController();
  String countryName = "India";
  String countryCode = "+91";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Enter your phone number",
          style: TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
          ),
        ),
        actions: [
          Icon(
            Icons.more_vert,
            color: Colors.black,
          ),
        ],
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Column(
          children: [
            Text(
              "Whatsapp will send an SMS to verify your number",
              style: TextStyle(
                fontSize: 13.5,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Whatsapp's my number ?",
              style: TextStyle(
                fontSize: 13.5,
                color: Colors.cyan[800],
              ),
            ),
            SizedBox(height: 15),
            countryCard(),
            SizedBox(height: 5),
            number(),
            Expanded(child: Container()),
            InkWell(
              onTap: () {
                if (_textEditingController.text.length < 10)
                  alertBox();
                else
                  dialogShow();
              },
              child: Container(
                color: Colors.teal[400],
                height: 40,
                width: 70,
                child: Center(
                  child: Text(
                    "NEXT",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget countryCard() {
    return InkWell(
      onTap: () {
        Get.to(() => CountryScreen(setCountryData: setCountryData));
      },
      child: Container(
        width: Get.width / 1.5,
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.teal,
              width: 1.8,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: Center(
                  child: Text(
                    countryName,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.teal,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }

  Widget number() {
    return Container(
      width: Get.width / 1.5,
      height: 38,
      child: Row(
        children: [
          Container(
            width: 70,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.teal,
                  width: 1.8,
                ),
              ),
            ),
            child: Row(
              children: [
                SizedBox(width: 10),
                Text(
                  "+",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(width: 15),
                Text(
                  countryCode.substring(1),
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          SizedBox(width: 30),
          Container(
            width: Get.width / 1.5 - 100,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.teal,
                  width: 1.8,
                ),
              ),
            ),
            child: TextFormField(
              controller: _textEditingController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(8),
                hintText: "phone number",
              ),
            ),
          ),
        ],
      ),
    );
  }

  void setCountryData(CountryModel countryModel) {
    setState(() {
      countryName = countryModel.name;
      countryCode = countryModel.code;
    });
    Get.back();
  }

  Future<void> dialogShow() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "We will be verifying your phone Number",
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 10),
                Text(
                  countryCode + " " + _textEditingController.text,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Is this ok, or would you like to edit the number",
                  style: TextStyle(
                    fontSize: 13.5,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                "Edit",
              ),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                Get.to(
                  () => OTPScreen(
                    number: _textEditingController.text,
                    countryCode: countryCode,
                  ),
                );
              },
              child: Text(
                "Ok",
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> alertBox() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "There's no number you eneterd",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                "Ok",
              ),
            )
          ],
        );
      },
    );
  }
}

class OldLogin extends StatefulWidget {
  OldLogin({Key key}) : super(key: key);

  @override
  _OldLoginState createState() => _OldLoginState();
}

class _OldLoginState extends State<OldLogin> {
  ChatModel sourceChat;
  List<ChatModel> chatmodels = [
    ChatModel(
      name: "Dev Stack",
      isGroup: false,
      msg: "Hi Everyone",
      time: "4:00",
      icon: "person.svg",
      id: 1,
    ),
    ChatModel(
      name: "Kishor",
      isGroup: false,
      msg: "Hi Kishor",
      time: "13:00",
      icon: "person.svg",
      id: 2,
    ),

    ChatModel(
      name: "Collins",
      isGroup: false,
      msg: "Hi Dev Stack",
      time: "8:00",
      icon: "person.svg",
      id: 3,
    ),

    ChatModel(
      name: "Balram Rathore",
      isGroup: false,
      msg: "Hi Dev Stack",
      time: "2:00",
      icon: "person.svg",
      id: 4,
    ),

    // ChatModel(
    //   name: "NodeJs Group",
    //   isGroup: true,
    //   msg: "New NodejS Post",
    //   time: "2:00",
    //   icon: "group.svg",
    // ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: chatmodels.length,
          itemBuilder: (contex, index) => InkWell(
                onTap: () {
                  sourceChat = chatmodels.removeAt(index);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => HomeScreen(
                                chatmodels: chatmodels,
                                sourceChat: sourceChat,
                              )));
                },
                child: ButtonCard(
                  name: chatmodels[index].name,
                  icon: Icons.person,
                ),
              )),
    );
  }
}
