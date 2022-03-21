import 'package:DocXonApp/model/Document.dart';
import 'package:flutter/material.dart';
import 'memory_game.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../httpBaseInstances/dio_instance.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';
import '../model/Document.dart';
import 'dart:convert';
import 'package:http/http.dart';
// import 'package:flutter_application_1/components/';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/Document.dart';

class DialogUtil {
  final pdf = pw.Document();
  showGameDialog(
    context,
    Documents doc,
  ) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Back'),
            backgroundColor: Color(0xFF800020),
          ),
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    doc.companyName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Click to view pdf ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    color: Color(0xFF800020),
                    child: new Icon(
                      Icons.picture_as_pdf,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _launchURL(doc.documentURL);
                    },
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  _launchURL(link) async {
    if (await canLaunch(link)) {
      await launch(link,
          forceSafariVC: true, forceWebView: true, enableJavaScript: true);
    } else {
      throw 'Could not launch $link';
    }
  }
}
