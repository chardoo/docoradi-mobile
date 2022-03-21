import 'package:flutter/material.dart';
import 'memory_game.dart';
// import 'package:flutter_application_1/components/';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class DialogUtil {
  showGameDialog(
    context,
    String title,
    String score,
  ) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    color: Colors.deepOrange[900],
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NotoEmoji'),
                textAlign: TextAlign.center,
              )
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  "Scores: $score ",
                  style: TextStyle(
                    color: Colors.deepOrange[500],
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => GamePage()));
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                    primary: Colors.deepOrange[900],
                    shape: StadiumBorder(),
                  ),
                  child: Text(
                    "REPLAY",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                FlatButton(
                  child: Text(
                    "Click to find more about these Adinkra Symbols",
                    style:
                        TextStyle(color: Colors.deepOrange[900], fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () async {
                    String url =
                        "https://yen.com.gh/109014-adinkra-symbols-and-their-meanings.html";
                    var urllaunchable = await canLaunch(
                        url); //canLaunch is from url_launcher package
                    if (urllaunchable) {
                      await launch(
                          url); //launch is from url_launcher package to launch URL
                    } else {
                      print("URL can't be launched.");
                    }
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
