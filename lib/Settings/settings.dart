import 'dart:io';
import 'package:flutter/material.dart';
import 'package:link/link.dart';
class SettingsView extends StatefulWidget {
  SettingsView({Key key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Settings"),
      ),
      body: Column(
        children: <Widget>[
          SwitchListTile(
            value: false,
            activeColor: Colors.green[500],
            title: Text("Notifications"),
            onChanged:(val){},
          ),
          SwitchListTile(
            value: false,
            activeColor: Colors.green[500],
            title: Text("Dark Mode"),
            onChanged:(bool value){
              setState(() {
//                var settingsDarkViewState = _SettingsDarkViewState();

              });
            },
          ),
          ExpansionTile(
            title: Text("Private Policy Link Below"),
            children: <Widget>[
              Link(
                child: Text("Private Policy"),
                url:'https://docs.google.com/document/d/1TAqTE7MBzuIagISHHzjGxSHoY1z884LXR3iGIojz1sA/edit',
              )
            ],
          ),



        ],
      ),




    );


  }
}