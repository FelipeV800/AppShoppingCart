import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pruebakubo/src/model/const.dart';
import 'package:pruebakubo/src/view/pages/main_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(child: Scaffold(
        backgroundColor: Color(Constants.paletteColors["complementaryLight"]!),
        body: MainPage(),
      )),
    );
  }
}
