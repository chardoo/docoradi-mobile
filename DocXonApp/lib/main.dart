import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/app_utils.dart';
import 'components/info_card.dart';
import 'components/dialog_util.dart';
import 'components/login.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Docxon App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const GameLoginPage());
  }
}

// const GameLoginPage(),