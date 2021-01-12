/* 
  Authors: David Kim, Aaron NI, Vinay Krisnan
  Date: 12/30/20

  Function: Chat
  Description: Builds the Chat functionality of textfield, sends, and diaplay emssages


 */

import 'package:buddyappfirebase/GlobalWidget/constants.dart';
import 'package:buddyappfirebase/Message/screens/changeChatName.dart';
import 'package:buddyappfirebase/Message/screens/chatrooms.dart';
import 'package:buddyappfirebase/Message/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../GlobalWidget/constants.dart';
import '../services/database.dart';

class Chat extends StatefulWidget {
  final String chatRoomId;
  Chat({this.chatRoomId});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  Stream<QuerySnapshot> chats;
  TextEditingController messageEditingController = new TextEditingController();
  String title = "";
  String chatName;

  @override
  void initState() {
    super.initState();
    DatabaseMethods().getChats(widget.chatRoomId).then((val) {
      setState(() {
        chats = val;
      });
    });
    _getChatTitle();
  }

  // This creates the message bubbles in chat
  Widget chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                    message: snapshot.data.documents[index].data["message"],
                    sendByMe: Constants.myName ==
                        snapshot.data.documents[index].data["sendBy"],
                  );
                })
            : Container();
      },
    );
  }

  // sends message to firebase
  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": Constants.myName,
        "message": messageEditingController.text,
        'time': DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseMethods().addMessage(widget.chatRoomId, chatMessageMap);

      updateLatestMessage(messageEditingController.text);
      updateLatestTime(DateTime.now().millisecondsSinceEpoch);
      updateLatestProfileImg(Constants.myProfileImg);
      updateLatestSendBy(Constants.myName);

      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  // updates chat name in the database
  updateChatName(String text) {
    // Update the Name of the chat
    Firestore.instance
        .collection('chatRoom')
        .document(widget.chatRoomId)
        .updateData({'chatRoomName': text});
  }

  // update latest message's content to the database
  updateLatestMessage(String text) {
    Firestore.instance
        .collection('chatRoom')
        .document(widget.chatRoomId)
        .updateData({'message': text});
  }

  // update latest message's time to the database
  updateLatestTime(int text) {
    Firestore.instance
        .collection('chatRoom')
        .document(widget.chatRoomId)
        .updateData({'time': text});
  }

  // update latest message's time to database
  updateLatestSendBy(String text) {
    Firestore.instance
        .collection('chatRoom')
        .document(widget.chatRoomId)
        .updateData({'sendBy': text});
  }

  // update latest profileimg to the database
  updateLatestProfileImg(String image) {
    Firestore.instance
        .collection('chatRoom')
        .document(widget.chatRoomId)
        .updateData({'image': image});
  }

  // deletes the chat room
  deleteRoom() {
    Firestore.instance
        .collection('chatRoom')
        .document(widget.chatRoomId)
        .delete();
  }

  // gets the chat title from database
  _getChatTitle() async {
    DatabaseMethods().getChatsName(widget.chatRoomId).then((value) {
      if (value != null) {
        setState(() {
          title = value.document[0]["chatRoomName"];
        });
      } else {
        setState(() {
          title = "";
        });
      }
    });
  }

  // Logic for the drop down for delete chat, and edit chat name
  void choiceAction(String choice) {
    if (choice == Constants.Settings) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EditChatName(
                    chatRoomId: widget.chatRoomId,
                  )));
    } else if (choice == Constants.Delete) {
      deleteRoom();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ChatRoom()));
    }
  }

  AppBar chatAppbar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.grey),
      elevation: 0.0,
      title: Text(
        title,
      ),
      actions: <Widget>[
        PopupMenuButton<String>(
          onSelected: choiceAction,
          itemBuilder: (BuildContext context) {
            return Constants.choices.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        )
      ],
      bottom: PreferredSize(
          child: Container(
            color: Colors.grey,
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(1.0)),
    );
  }

  Scaffold body() {
    return Scaffold(
      appBar: chatAppbar(),
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Container(
                child: chatMessages(),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width - 10,
                height: MediaQuery.of(context).size.height - 88,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(width: 1.5, color: Colors.grey),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 3),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        controller: messageEditingController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            hintText: "Message ...",
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            border: InputBorder.none),
                      )),
                      SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          addMessage();
                        },
                        child: Container(
                            height: 40,
                            width: 40,
                            padding: EdgeInsets.only(left: 12),
                            child: Icon(
                              Icons.send,
                              size: 25,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;
  final String lastChat;
  final int lastTime;

  MessageTile(
      {@required this.message,
      @required this.sendByMe,
      this.lastChat,
      this.lastTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8, bottom: 8, left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin:
            sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: sendByMe
                  ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
                  : [const Color(0xff8A8A8A), const Color(0xff8A8A8A)],
            )),
        child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w300)),
      ),
    );
  }
}
