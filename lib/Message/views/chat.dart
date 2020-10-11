import 'package:buddyappfirebase/Message/helper/constants.dart';
import 'package:buddyappfirebase/Message/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Authentication/widgets/TextEditingControllers.dart';

// This needs work

class Chat extends StatefulWidget {
  final String chatRoomId;
  static String lastChat = ""; // Used in MainHomeView.dart and carry information about last message in the chat
  static int lastTime; // Used in MainHomeView.dart and carry information about last message in the chat

  Chat({this.chatRoomId});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  Stream<QuerySnapshot> chats;
  TextEditingController messageEditingController = new TextEditingController();

  Widget chatMessages() { // This creates the message bubbles in chat
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
                    lastChat: Chat.lastChat =
                        snapshot.data.documents[index].data["message"],
                    lastTime: Chat.lastTime =
                        snapshot.data.documents[index].data["time"],
                  );
                })
            : Container();
      },
    );
  }

  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": Constants.myName,
        "message": messageEditingController.text,
        'time': DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseMethods().addMessage(widget.chatRoomId, chatMessageMap);

      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  @override
  void initState() {
    DatabaseMethods().getChats(widget.chatRoomId).then((val) {
      setState(() {
        chats = val;
      });
    });
    super.initState();
    print(Chat.lastTime);
  }

  updateChatName(String text) { // Update the Name of the chat
    Firestore.instance
          .collection('chatRoom')
          .document(widget.chatRoomId) 
          .updateData({'chatRoomName': text});
   
  }
  String chatName;

  AppBar chatAppbar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.grey),
      elevation: 0.0,
      title: TextFormField(
        decoration: InputDecoration(
          hintText: "Enter Chat Name",
          labelText: chatName,
        ),
        controller: TextEditingControllers.chatNameEditingController,
        onChanged: (text) {
          updateChatName(text);
          setState(() {
            chatName = text;
          });
        },
      ),
      bottom: PreferredSize(
          child: Container(
            color: Colors.grey,
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(1.0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: chatAppbar(),
      body: Container(
        child: Stack(
          children: [
            chatMessages(),
            Container(
              padding: EdgeInsets.only(left: 10),
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width - 10,
              height: MediaQuery.of(context).size.height - 88,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(width: 1.5, color: Colors.grey),
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
          ],
        ),
      ),
    );
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
                  : [const Color(0x1AFFFFFF), const Color(0x1AFFFFFF)],
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
