import 'package:DocXonApp/model/Login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'memory_game.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dashboard.dart';
import '../model/Registration.dart';
import 'SignUp.dart';
import '../httpBaseInstances/dio_instance.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/LoginResponse.dart';
import 'package:http/http.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  //email RegExp
  final _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  final loginModel = Login('', '');
  final loginresponse = LoginResponseObject('', '', '', '', '', '', '');
  List<MaterialColor> colorizeColors = [
    Colors.red,
    Colors.amber,
    Colors.yellow,
  ];

  Dio dio1 = new Dio();
  final _formKey = GlobalKey<FormState>();
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
                      height: 500,
                      margin:
                          const EdgeInsets.only(top: 80, left: 10, right: 10),
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
                      child: Form(
                        key: _formKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Login ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xFF800020),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontFamily: 'Raleway'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      decoration: InputDecoration(
                                          focusColor: Color(0xFF800020),
                                          hintText: 'Email',
                                          hintStyle: TextStyle(
                                            color: Color(0xFF800020),
                                          )),
                                      onChanged: (value) {
                                        loginModel.email = value;
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter  email';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          focusColor: Color(0xFF800020),
                                          hintText: 'Password',
                                          suffixIcon:
                                              Icon(Icons.remove_red_eye),
                                          hintStyle: TextStyle(
                                            color: Color(0xFF800020),
                                          )),
                                      onChanged: (value) {
                                        loginModel.password = value;
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter  password';
                                        }
                                        return null;
                                      },
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Forget Password",
                                          style: TextStyle(
                                            color: Color(0xFF004d99),
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
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
                                              'Login',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                      content:
                                                          Text('Login Acount')),
                                                );

                                                login();
                                              }
                                            }),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Dont have an account',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  MaterialButton(
                                      child: Text(
                                        'Sign Up',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Color(0xFF004d99),
                                            fontSize: 15),
                                      ),
                                      onPressed: signUP)
                                ],
                              )
                            ]),
                      )),
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

  signUP() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpPage()));
  }

  myDashboard() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Dashboard()));
  }

  Future<dynamic> login() async {
    // debugPrint("login users hit");
    try {
      ///flutter/login testing endpoint
      ///advent_user/login prod_endpoint
      final response =
          await dio.post("/service/user/login", data: loginModel.toJson());
      if (response.statusCode == 200) {
        // Map<String, dynamic> decoded = response.data;
        // print(response.data['email']);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        prefs.setString('userId', response.data['email']);
        prefs.setString('token', response.data['token']);

        myDashboard();
        // return decoded;
      } else {
        throw Exception();
      }
    } on SocketException catch (e) {
      debugPrint("eSocket = " + e.toString());
      throw Exception(e);
    } catch (e) {
      debugPrint("e = " + e.toString());
      throw Exception(e);
    }
  }
}
