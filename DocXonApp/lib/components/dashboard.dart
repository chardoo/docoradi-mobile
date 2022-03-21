import 'package:DocXonApp/model/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'memory_game.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatars/avatars.dart';
import 'first.dart';
import 'second.dart';
import '../httpBaseInstances/dio_instance.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';
import '../model/Document.dart';
import '../components/Login.dart';
import 'dart:convert';
import 'package:http/http.dart';
import '../components/viewlaterModal.dart';
import '../apis/httpService.dart';
import '../model/ViewLater.dart';
import '../components/documentBody.dart';
import '../components/documentBody.dart';
import '../components/screens/uploads.dart';
import '../model/UploadedDocuments.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../apis/gcpApi.dart';

class Dashboard extends StatefulWidget {
  @override
  _MyDashboard createState() => _MyDashboard();
}

class _MyDashboard extends State<Dashboard> {
  HttpService httpService = HttpService();
  ViewLaterModel vieelead = ViewLaterModel();
  List<Documents> viewLaterObject = [];
  DialogUtil dialog = DialogUtil();
  UploadsUtils uploadscreen = UploadsUtils();
  final String value = '';
  final _formKey = GlobalKey<FormState>();
  late CloudApi api;
  // FutureBuilder<List<UploadedDocuments>> tabBody(BuildContext context) {
  //   final HttpService httpService = HttpService();
  //   return FutureBuilder<List<UploadedDocuments>>(
  //     future: httpService.getPersonalDocuments(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         final List<UploadedDocuments> futureDocuments = snapshot.data!;
  //         print(futureDocuments);
  //         return personalUploads(context, futureDocuments);
  //         // return futureDocuments;
  //       } else {
  //         return Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //     },
  //   );
  // }

  void getDataforViewLater() async {
    try {
      final HttpService httpService = HttpService();
      final List<Documents> data = await httpService.getDocuments();
      setState(() {
        vieelead.addRecent(data);
        for (var prop in data) {
          if (prop.isLater == true) {
            vieelead.add(prop);
          }
        }
      });
      // print(vieelead.recentsdoc);
    } catch (ex) {
      print(ex);
    }
  }

  @override
  void initState() {
    super.initState();
    check_if_already_login();
    getDataforViewLater();
    rootBundle
        .loadString('assets/credentials.json')
        .then((json) => {api = CloudApi(json)});
  }

  void check_if_already_login() async {
    var logindata = await SharedPreferences.getInstance();
    var isLoggedIn = (logindata.getBool('isLoggedIn') ?? true);
    print(isLoggedIn);
    if (isLoggedIn == false) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  void viewlater(Documents doc) {
    vieelead.add(doc);
    setState(() {
      vieelead.docs;
    });
    httpService.setAsViewLater(doc.objectID);
  }

  void RemoveFromviewlater(Documents doc) {
    vieelead.romoveFromList(doc);
    setState(() {
      vieelead.docs;
    });
    httpService.removeAsViewLater(doc.objectID);
  }

  void markAsView(Documents doc) {
    print('view later');
    print(doc);
    vieelead.add(doc);
    httpService.markAsViewed(doc.objectID);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
                Widget>[
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 50,
                    color: Colors.white24,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Avatar(
                          name: 'Alberto Fecchi',
                          placeholderColors: [Colors.black, Colors.black],
                          shape: AvatarShape.circle(25),
                          onTap: () {
                            print("Tap");
                          },
                        ),
                        SizedBox(
                            width: 200.0,
                            height: 40.0,
                            child: TextField(
                              onSubmitted: (value) async {
                                final List<Documents> data =
                                    await httpService.searchDocuments(value);
                                if (data.length > 0) {
                                  await showDialog<void>(
                                    context: context,
                                    barrierDismissible:
                                        false, // user must tap button!
                                    builder: (BuildContext context) {
                                      return Scaffold(
                                          appBar: AppBar(
                                            title: const Text('Search Results'),
                                            backgroundColor: Color(0xFF800020),
                                          ),
                                          body: recentDocs(context, data));
                                    },
                                  );
                                } else {
                                  await showDialog<void>(
                                    context: context,
                                    barrierDismissible:
                                        false, // user must tap button!
                                    builder: (BuildContext context) {
                                      return Scaffold(
                                          appBar: AppBar(
                                            title: const Text('Search Results'),
                                            backgroundColor: Color(0xFF800020),
                                          ),
                                          body: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text("sorry nothing found")
                                                ],
                                              )
                                            ],
                                          ));
                                    },
                                  );
                                }
                              },
                              decoration: InputDecoration(
                                  focusColor: Color(0xFF800020),
                                  hintText: 'Search',
                                  fillColor: Colors.white,
                                  suffixIcon: Icon(
                                    Icons.search,
                                    color: Color(0xFF800020),
                                  ),
                                  hintStyle: TextStyle(color: Colors.white)),
                            )),
                        const SizedBox(
                          height: 40.0,
                          width: 50,
                          child: Icon(
                            Icons.notifications,
                            color: Color(0xFF800020),
                          ),
                        )
                      ],
                    )),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    height: 50.0,
                    child: ListView(
                        // This next line does the trick.
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Container(
                            width: 160.0,
                            color: Colors.white,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.receipt,
                                  size: 20,
                                ),
                                Text('Notice')
                              ],
                            ),
                          ),
                          Container(
                            width: 160.0,
                            color: Colors.white,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.receipt,
                                  size: 20,
                                ),
                                Text('Consumer Bills')
                              ],
                            ),
                          ),
                          Container(
                            width: 160.0,
                            color: Colors.white,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.receipt,
                                  size: 20,
                                ),
                                Text('Receipts')
                              ],
                            ),
                          ),
                          Container(
                            width: 160.0,
                            height: 30,
                            color: Colors.white,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.receipt,
                                  size: 20,
                                ),
                                Text('Consumer Bills')
                              ],
                            ),
                          ),
                        ])),
              ],
            ),
          ),
          DefaultTabController(
              length: 3, // length of tabs
              initialIndex: 0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      child: TabBar(
                        labelColor: Color(0xFF800020),
                        unselectedLabelColor: Colors.black,
                        tabs: [
                          Tab(text: 'Recent'),
                          Tab(text: 'View Later'),
                          Tab(text: 'Uploads'),
                        ],
                      ),
                    ),
                    Container(
                        height: 400, //height of TabBarView
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: Colors.grey, width: 0.5))),
                        child: TabBarView(children: <Widget>[
                          Container(
                              child: recentDocs(context, vieelead.recentsdoc)),
                          Container(
                              child: viewLaterList(context, vieelead.docs)),
                          Container(
                              child: Column(
                            children: [
                              Text('uploads'),
                              // SafeArea(child: tabBody(context)),
                              Align(
                                alignment: Alignment.bottomRight,
                                heightFactor: 6,
                                child: FloatingActionButton(
                                  backgroundColor: Color(0xFF800028),
                                  child: Icon(
                                    Icons.add,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    uploadscreen.showUploadforms(context);
                                  },
                                ),
                              ),
                            ],
                          )),
                        ]))
                  ])),
        ]),
      ),
    );
  }

  ListView recentDocs(BuildContext context, List<Documents> documents) {
    final theme = Theme.of(context);
    return ListView.builder(
      itemCount: documents.length,
      itemBuilder: (context, index) {
        if (documents[index].isViewed == false) {
          return Card(
              elevation: 4,
              child: ListTile(
                tileColor: Colors.white70,
                leading: Icon(Icons.file_copy_outlined),
                title: Text(
                  documents[index].companyName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'Open Sans',
                      fontSize: 20),
                ),
                subtitle: Text(
                  'Lorem ipsum dolor #${index + 1}',
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.caption,
                ),
                onTap: () {
                  // Navigator.push(context, )
                  dialog.showGameDialog(context, documents[index]);
                  // _launchURL(documents[index].documentURL);
                  // markAsView(documents[index]);
                },
                trailing: SizedBox(
                    width: 96,
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            Text('6:30'),
                            Text('New'),
                          ],
                        )),
                        SizedBox(width: 15),
                        IconButton(
                          icon: const Icon(Icons.more_horiz),
                          tooltip: 'View Later',
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        leading: new Icon(Icons.watch_later),
                                        title: new Text('View Later'),
                                        onTap: () {
                                          viewlater(documents[index]);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: new Icon(Icons.download),
                                        title: new Text('Download'),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: new Icon(Icons.delete),
                                        title: new Text('Delete'),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: new Icon(Icons.share),
                                        title: new Text('Share'),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                      ],
                    )),
              ));
        } else {
          return Card(
              elevation: 40,
              child: ListTile(
                tileColor: Colors.white70,
                leading: Icon(Icons.file_copy_outlined),
                title: Text(
                  documents[index].companyName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'Open Sans',
                      fontSize: 20),
                ),
                subtitle: Text(
                  'Lorem ipsum dolor #${index + 1}',
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.caption,
                ),
                onTap: () {
                  dialog.showGameDialog(context, documents[index]);
                  // _launchURL(documents[index].documentURL);
                  // markAsView(documents[index]);
                },
                trailing: SizedBox(
                    width: 96,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '6:30',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'New',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 15),
                        IconButton(
                          icon: const Icon(Icons.more_horiz),
                          tooltip: 'View Later',
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        leading: new Icon(Icons.watch_later),
                                        title: new Text('View Later'),
                                        onTap: () {
                                          viewlater(documents[index]);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: new Icon(Icons.download),
                                        title: new Text('Download'),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: new Icon(Icons.delete),
                                        title: new Text('Delete'),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: new Icon(Icons.share),
                                        title: new Text('Share'),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                      ],
                    )),
              ));
        }
      },
    );
  }

  ListView viewLaterList(BuildContext context, List<Documents> documents) {
    final theme = Theme.of(context);

    return ListView.builder(
        itemCount: documents.length,
        itemBuilder: (context, index) {
          return Card(
              elevation: 4,
              child: ListTile(
                tileColor: Colors.white70,
                leading: Icon(Icons.file_copy_outlined),
                title: Text(
                  documents[index].companyName,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.headline6,
                ),
                subtitle: Text(
                  'Lorem ipsum dolor #${index + 1}',
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.caption,
                ),
                onTap: () {
                  dialog.showGameDialog(context, documents[index]);
                  // _launchURL(documents[index].documentURL);
                  // markAsView(documents[index]);
                },
                trailing: SizedBox(
                    width: 96,
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            Text('6:30'),
                            Text('New'),
                          ],
                        )),
                        SizedBox(width: 15),
                        IconButton(
                          icon: const Icon(Icons.more_horiz),
                          tooltip: 'View Later',
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        leading: new Icon(Icons.remove),
                                        title: new Text('Remove from List'),
                                        onTap: () {
                                          RemoveFromviewlater(documents[index]);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: new Icon(Icons.download),
                                        title: new Text('Download'),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: new Icon(Icons.delete),
                                        title: new Text('Delete'),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: new Icon(Icons.share),
                                        title: new Text('Share'),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                      ],
                    )),
              ));
        });
  }

  ListView personalUploads(
      BuildContext context, List<UploadedDocuments> documents) {
    final theme = Theme.of(context);

    return ListView.builder(
        itemCount: documents.length,
        itemBuilder: (context, index) {
          return Card(
              elevation: 4,
              child: ListTile(
                tileColor: Colors.white70,
                leading: Icon(Icons.file_copy_outlined),
                title: Text(
                  documents[index].documentType,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.headline6,
                ),
                subtitle: Text(
                  'Lorem ipsum dolor #${index + 1}',
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.caption,
                ),
                onTap: () {
                  // dialog.showGameDialog(context, documents[index]);
                  // _launchURL(documents[index].documentURL);
                  // markAsView(documents[index]);
                },
                trailing: SizedBox(
                    width: 96,
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            Text('6:30'),
                            Text('New'),
                          ],
                        )),
                        SizedBox(width: 15),
                        IconButton(
                          icon: const Icon(Icons.more_horiz),
                          tooltip: 'View Later',
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        leading: new Icon(Icons.remove),
                                        title: new Text('Remove from List'),
                                        onTap: () {
                                          // RemoveFromviewlater(documents[index]);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: new Icon(Icons.download),
                                        title: new Text('Download'),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: new Icon(Icons.delete),
                                        title: new Text('Delete'),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: new Icon(Icons.share),
                                        title: new Text('Share'),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                      ],
                    )),
              ));
        });
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
