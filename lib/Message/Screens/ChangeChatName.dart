/* 
  Authors: David Kim, Aaron NI, Vinay Krisnan
  Date: 12/30/20

  Function: 
  Description: 


 */


import 'package:buddyappfirebase/Message/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditChatName extends StatefulWidget {
  
  String chatRoomId;

  EditChatName({@required this.chatRoomId});

  static String profileName = "";
  @override
  _EditChatNameState createState() => _EditChatNameState();
}

class _EditChatNameState extends State<EditChatName> {
  TextEditingController displayNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  bool isLoading = false;
  User user;



  @override
  void initState() {
    super.initState();
    getUser();
   
  }

  getUser() async {
    setState(() {
      isLoading = true;
    });
  }

 



  Column buildDisplayNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          controller: displayNameController,
          decoration: InputDecoration(
            hintText: "Update Display Name",
          ),
        )
      ],
    );
  }

  updateData() async {
    Firestore.instance
          .collection('chatRoom')
          .document(widget.chatRoomId) 
          .updateData({'chatRoomName': displayNameController.text});
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Edit Chat Name",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.done,
              size: 30.0,
              color: Colors.green,
            ),
          ),
        ],
      ),
      body: 
      
          ListView(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            buildDisplayNameField(),
                          ],
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          updateData();
                        },
                        child: Text(
                          "Update ChatName",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}