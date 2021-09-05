import 'package:camera/camera.dart';
import 'package:chatapp/ui/constants.dart';
import 'package:chatapp/ui/screens/home_screen/home_page.dart';
import 'package:chatapp/ui/screens/login_screen/login_screen.dart';
import 'package:chatapp/ui/screens/new_screen/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "OpenSans",
        primarySwatch: Colors.blue,
        primaryColor: UIColors.primaryColor,
        accentColor: UIColors.accentColor,
      ),
      home: LandingScreen(),
    );
  }
}
