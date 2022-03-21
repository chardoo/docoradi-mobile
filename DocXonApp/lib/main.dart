import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/app_utils.dart';
import 'components/info_card.dart';
import 'components/dialog_util.dart';
import 'components/login.dart';
import 'components/SignUp.dart';
import 'components/dashboard.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

// SharedPreferences? preferences;
// Future<void> initializePreference() async {
//   preferences = await SharedPreferences.getInstance();
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SharedPreferences prefs =  SharedPreferences.getInstance();

    // var isLoggedIn = preferences?.getBool('isLoggedIn');
    // String initialRoute = (isLoggedIn == true) ? '/' : '/login';
    return MaterialApp(
      title: 'Docxon App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Dashboard(),
        '/login': (context) => const LoginPage(),
        '/signUp': (context) => SignUpPage(),
      },
    );
  }
}

// const GameLoginPage(),