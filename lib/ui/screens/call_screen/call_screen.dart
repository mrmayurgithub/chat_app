import 'package:chatapp/ui/constants.dart';
import 'package:flutter/material.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({Key key}) : super(key: key);

  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add_call,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            callCard(),
          ],
        ),
      ),
    );
  }

  Widget callCard() {
    return ListTile(
      leading: CircleAvatar(radius: 26),
      title: Text(
        "Test name",
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Row(
        children: [
          Icon(
            Icons.call_made,
            color: Colors.green,
            size: 20,
          ),
          SizedBox(width: 6),
          Text(
            "July 18, 18:20",
            style: TextStyle(
              fontSize: 13,
            ),
          ),
        ],
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.call,
          color: UIColors.primaryColor,
          size: 24,
        ),
      ),
    );
  }
}
