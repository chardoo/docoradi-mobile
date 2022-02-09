import 'package:flutter/material.dart';
import 'memory_game.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dashboard.dart';

class GameLoginPage extends StatefulWidget {
  const GameLoginPage({Key? key}) : super(key: key);

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<GameLoginPage> {
  List<MaterialColor> colorizeColors = [
    Colors.red,
    Colors.amber,
    Colors.yellow,
  ];

  static const colorizeTextStyle =
      TextStyle(fontSize: 25.0, fontFamily: 'SF', color: Colors.redAccent);
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF800020),
      appBar: _getAppBar(),
      body: playGame(),
    );
  }

  Widget playGame() {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF800020),
        body: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 35,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 80, left: 10, right: 10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        const Color(0xFFffffff),
                        const Color(0xFFffffff),
                      ]),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Create Account',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF800020),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                fontFamily: 'Raleway'),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                      focusColor: Color(0xFF800020),
                                      hintText: 'Full Name',
                                      hintStyle: TextStyle(
                                        color: Color(0xFF800020),
                                      )),
                                  onChanged: (value) {
                                    print(value);
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                      focusColor: Color(0xFF800020),
                                      hintText: 'Email',
                                      hintStyle: TextStyle(
                                        color: Color(0xFF800020),
                                      )),
                                  onChanged: (value) {
                                    print(value);
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      focusColor: Color(0xFF800020),
                                      hintText: 'Password',
                                      suffixIcon: Icon(Icons.remove_red_eye),
                                      hintStyle: TextStyle(
                                        color: Color(0xFF800020),
                                      )),
                                  onChanged: (value) {
                                    print(value);
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(3),
                                    color: Color(0xFF800020),
                                    child: MaterialButton(
                                      child: Text(
                                        'Sign Up with Email',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                      onPressed: () {
                                        myDashboard();
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: SignInButton(
                                    Buttons.FacebookNew,
                                    text: 'Sign Up with Facebook',
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: SignInButton(
                                    Buttons.GoogleDark,
                                    text: 'Sign Up with Google',
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'already have an account',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          )
                        ]),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar _getAppBar() {
    return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(child: Text('DocXon')));
  }

  myDashboard() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Dashboard()));
  }
}
