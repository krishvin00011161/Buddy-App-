import 'package:buddyappfirebase/message/constant_val.dart';
import 'package:buddyappfirebase/message/conversation_screen.dart';
import 'package:buddyappfirebase/message/userInfo_functions.dart';
import 'package:buddyappfirebase/message/widgets_messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'database_functionality.dart';
class SearchAdd extends StatefulWidget {
  @override
  _SearchAddState createState() => _SearchAddState();
}

class _SearchAddState extends State<SearchAdd> {
  TextEditingController searchTxt = new TextEditingController();
  QuerySnapshot searchSnapShot;

  Widget searchList(){
    return searchSnapShot != null ? ListView.builder(
        itemCount: searchSnapShot.documents.length,
        shrinkWrap: true,
        itemBuilder: (context, index){
          return SearchTile(
            userName: searchSnapShot.documents[index].data["num"],
            userEmail: searchSnapShot.documents[index].data["email"],
          );
        }): Container();
  }
  createSearch(){
    dataMethod.getNameUser(searchTxt.text).then((val){
      print(val.toString());
      setState(() {
        searchSnapShot = val;
      });
    });
    dataMethod.getEmailUser(searchTxt.text).then((val){
      print(val.toString());
      setState(() {
        searchSnapShot = val;
      });
    });

  }
  createChatScreen({ String userName}){
    print("${Constants.myName}");
    if(userName!=Constants.myName){
      String chatRoomId=getChatRoomId(userName, Constants.myName);
      List<String> users=[userName, Constants.myName];
      Map <String, dynamic> chatRoomMap = {
        "users":users,
        "chatroomid": chatRoomId
      };
      Database().createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(context, MaterialPageRoute(
          builder: (context)=>ConversationScreen(chatRoomId)
      ));
    }else{
      print("You cannot send a message to yourself!");
    }
  }
  Widget SearchTile({String userName, String userEmail}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(userName),
              Text(userEmail),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap:(){
              createChatScreen(
                  userName: userName

              );
            },
            child: Container(
              decoration:BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.green,
              ),
              padding: EdgeInsets.symmetric(horizontal:24,vertical:12),
              child: Text("Start Chart"),
            ),
          ),
        ],
      ),
    );
  }


  void initState(){
    super.initState();
  }

  Database dataMethod = new Database();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: appBarMain(context),
      body: Container(

        child: Column(
          children: <Widget>[
            Container(
              padding:  EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: searchTxt,
                      decoration: InputDecoration(

                          hintText: "Search for other users...",
                          hintStyle: TextStyle(color: Colors.white, fontFamily: "Time New Roman",),
                          border: InputBorder.none),
                    ),

                  ),
                  GestureDetector(
                    onTap: (){

                      createSearch();


                    },
                    child: Container(

                      height: 40,
                      width: 40,
                      child: Icon(Icons.add_circle),

                    ),
                  ),
                ],
              ),
            ),
            searchList(),

          ],
        ),
      ),

    );
  }
}




getChatRoomId(String a, String b){
  if(a.substring(0,1).codeUnitAt(0)>b.substring(0,1).codeUnitAt(0)){
    return "$b\_$a";
  }else{
    return "$a\_$b";
  }
}