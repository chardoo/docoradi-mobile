import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:flutter_application_1/components/';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:file_picker/file_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:async';
import 'dart:io';
import '../../model/Uploads.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:http/http.dart';
import '../../httpBaseInstances/dio_instance.dart';
import 'dart:typed_data';

class UploadsUtils {
  final _formKey = GlobalKey<FormState>();
  final uploadsModel = Uploads('', '', '', '');
  // Dio dio1 = new Dio();

//switch to either local or remote depending on where
//you're retrieving your data from
  // Dio dio2 = Dio(localOptions);

  showUploadforms(
    context,
  ) {
    return showDialog<void>(
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
                Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Upload Documents',
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
                                TextFormField(
                                  decoration: InputDecoration(
                                      focusColor: Color(0xFF800020),
                                      hintText: 'Document Type',
                                      hintStyle: TextStyle(
                                        color: Color(0xFF800020),
                                      )),
                                  onChanged: (value) {
                                    uploadsModel.documentType = value;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter the the type of document';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                      focusColor: Color(0xFF800020),
                                      hintText: 'Descriptions',
                                      hintStyle: TextStyle(
                                        color: Color(0xFF800020),
                                      )),
                                  onChanged: (value) {
                                    // RegistrationModel.lastName = value;
                                    uploadsModel.description = value;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'short note about the document';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                MaterialButton(
                                  onPressed: () async {
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles();

                                    if (result != null) {
                                      // print('results');
                                      // print(result);
                                      uploadsModel.filename =
                                          result.files.first.name as String;
                                      String filePath =
                                          result.files.first.path as String;
                                      File file = File(filePath);
                                      // String mime
                                      //  Stream<String> lines = file
                                      //       .openRead()
                                      //       .transform(utf8.decoder);
                                      Uint8List fileInByte =
                                          await file.readAsBytes();
                                      uploadsModel.file =
                                          base64.encode(fileInByte);
                                    }
                                  },
                                  child: Text(
                                    'Select file',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Color(0xFF800020),
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
                                      child: Center(
                                        child: MaterialButton(
                                            child: Text(
                                              'Upload',
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
                                                      content: Text(
                                                          'Creating Acount')),
                                                );
                                                uploadDocuments();
                                                // register();
                                              }
                                            }),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ]),
                  ),
                )
              ],
            ));
      },
    );
  }

  Future<dynamic> uploadDocuments() async {
    // debugPrint("login users hit");
    try {
      var localOptions2 = BaseOptions(
        baseUrl: 'https://docxon-service-app-phrl5joxbq-uc.a.run.app',
        connectTimeout: 60 * 1000, // 60 seconds
        receiveTimeout: 60 * 1000,
        headers: {
          HttpHeaders.acceptHeader: "accept: application/json",
        }, // 60 seconds
      );
      Dio dio2 = Dio(localOptions2);
      print("sending data");
      // final String postsURL =
      //     "https://docxon-service-app-phrl5joxbq-uc.a.run.app/service/docxon/";
      print(uploadsModel.toJson());
      final response = await dio2.post("/service/docxon/personal",
          data: uploadsModel.toJson());
      print("the response");
      print(response);
      // if (response?.status = "Ok") {
      //   print("the document sent succefully");
      // } else {
      //   throw Exception();
      // }
    } on SocketException catch (e) {
      debugPrint("eSocket = " + e.toString());
      throw Exception(e);
    } catch (e) {
      debugPrint("e = " + e.toString());
      throw Exception(e);
    }
  }
}
