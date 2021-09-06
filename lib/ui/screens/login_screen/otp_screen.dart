import 'package:chatapp/ui/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class OTPScreen extends StatefulWidget {
  final String number;
  final String countryCode;

  const OTPScreen({Key key, @required this.number, @required this.countryCode})
      : super(key: key);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Verify ${widget.countryCode} ${widget.number}",
          style: TextStyle(
            color: UIColors.primaryColor,
            fontSize: 16.5,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            SizedBox(height: 10),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "We have sent an SMS to ",
                    style: TextStyle(
                      fontSize: 15,
                      color: UIColors.primaryColor,
                    ),
                  ),
                  TextSpan(
                    text: widget.countryCode + " " + widget.number,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: " Wrong number?",
                    style: TextStyle(
                      color: UIColors.accentColor,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 30,
              style: TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onCompleted: (pin) {
                print("Completed: " + pin);
              },
            ),
            SizedBox(height: 30),
            Text(
              "Enter 6-digit OTP",
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 30),
            bottomButton("Resend SMS", Icons.message),
            SizedBox(height: 12),
            Divider(),
            SizedBox(height: 12),
            bottomButton("Call me", Icons.call),
          ],
        ),
      ),
    );
  }

  Widget bottomButton(String text, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: UIColors.primaryColor,
          size: 24,
        ),
        SizedBox(width: 30),
        Text(
          text,
          style: TextStyle(
            color: UIColors.primaryColor,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
