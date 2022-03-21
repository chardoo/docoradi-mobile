import 'package:DocXonApp/model/Document.dart';

import 'package:flutter/material.dart';
import '../model/Document.dart';

class ViewLatermodal extends StatelessWidget {
  final Documents document;

  const ViewLatermodal({required this.document, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: new Icon(Icons.watch_later),
          title: new Text('View Later'),
          onTap: () {
            print(document);
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
  }
}
