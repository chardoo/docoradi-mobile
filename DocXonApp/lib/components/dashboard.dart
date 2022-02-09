import 'package:flutter/material.dart';
import 'memory_game.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatars/avatars.dart';

class Dashboard extends StatefulWidget {
  @override
  _MyDashboard createState() => _MyDashboard();
}

class _MyDashboard extends State<Dashboard> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: main(),
    );
  }

  Widget main() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 50,
              color: Colors.black,
              child: Row(
                children: [
                  Avatar(
                    name: 'Alberto Fecchi',
                    shape: AvatarShape.circle(25),
                    onTap: () {
                      print("Tap");
                    },
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
                  Icon(
                    Icons.notifications,
                    color: Colors.amber,
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
