import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ComposeScreen extends StatefulWidget {
  ComposeScreen({Key key}) : super(key: key);

  @override
  _ComposeScreenState createState() => _ComposeScreenState();
}

class _ComposeScreenState extends State<ComposeScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.cancel),
          ),
          middle: Text("Title"),
          trailing: Icon(Icons.cloud_upload),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://picturecorrect-wpengine.netdna-ssl.com/wp-content/uploads/2014/03/portrait-photography.jpg"),
                    ),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text("What's Happening?"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
