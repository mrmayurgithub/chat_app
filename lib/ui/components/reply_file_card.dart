import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReplyFileCard extends StatelessWidget {
  final String path;
  final String message;
  final String time;

  const ReplyFileCard({
    Key key,
    @required this.path,
    @required this.message,
    @required this.time,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          children: [
            Container(
              // height: Get.height / 2.3,
              width: Get.width / 1.8,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(15),
                color: Colors.lightGreen[200],
              ),
              child: Stack(
                children: [
                  Card(
                    // margin: EdgeInsets.all(3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child:
                        Image.network("http://192.168.1.36:5000/uploads/$path"),
                    // child: Image.file(
                    //   File(path),
                    //   fit: BoxFit.fitHeight,
                    // ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10, bottom: 10),
                      child: Text(
                        message.length == 0 ? time : "",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            message.length != 0
                ? Container(
                    decoration: BoxDecoration(
                      color: Colors.lightGreen[200],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                    ),
                    width: Get.width / 1.8,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(message),
                          Text(
                            time,
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
