import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ComposeScreen extends StatefulWidget {
  ComposeScreen({Key key}) : super(key: key);

  @override
  _ComposeScreenState createState() => _ComposeScreenState();
}

class _ComposeScreenState extends State<ComposeScreen> {
  TextEditingController composeEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.cancel,
            color: Colors.lightBlue[200], //Color(0x5EC4F2),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.send,
              color: Colors.lightBlue[200],
            ),
            onPressed: () {
              print(composeEditingController.text);
            },
          )
        ],
      ),
      body: SafeArea(
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
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "What's Happening?",
                      focusColor: Colors.black,
                    ),
                    controller: composeEditingController,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
