import 'package:buddyappfirebase/Message/helper/constants.dart';
import 'package:buddyappfirebase/Message/services/database.dart';
import 'package:buddyappfirebase/Message/views/chatrooms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:buddyappfirebase/Message/views/changeChatName.dart';
import '../../home/screens/MainHomeView.dart';
import '../helper/constants.dart';
import '../services/database.dart';

class Chat extends StatefulWidget {
  String chatRoomId = "Aidan_Tim";
  static String lastChat =
      ""; // Used in MainHomeView.dart and carry information about last message in the chat
  static int
      lastTime; // Used in MainHomeView.dart and carry information about last message in the chat

  Chat({this.chatRoomId});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  Stream<QuerySnapshot> chats;
  TextEditingController messageEditingController = new TextEditingController();
  String title = "";

  Widget chatMessages() {
    // This creates the message bubbles in chat
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

      Map<String, dynamic> chatLatestMessageMap = {
        "message": messageEditingController.text,
        'time': DateTime.now().millisecondsSinceEpoch,
        'image': "",
      };

      DatabaseMethods().addMessage(widget.chatRoomId, chatMessageMap);
      DatabaseMethods()
          .updateLatestMessage(widget.chatRoomId, chatLatestMessageMap);

      updateLatestMessage(messageEditingController.text);
      updateLatestTime(DateTime.now().millisecondsSinceEpoch);
      updateLatestSendBy(Constants.myName);
      updateLatestProfileImg(MainHomeView().profileImg.toString());

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
    _getChatTitle();
    print(Chat.lastTime);
  }

  updateChatName(String text) {
    // Update the Name of the chat
    Firestore.instance
        .collection('chatRoom')
        .document(widget.chatRoomId)
        .updateData({'chatRoomName': text});
  }

  updateLatestMessage(String text) {
    Firestore.instance
        .collection('chatRoom')
        .document(widget.chatRoomId)
        .updateData({'message': text});
  }

  updateLatestTime(int text) {
    Firestore.instance
        .collection('chatRoom')
        .document(widget.chatRoomId)
        .updateData({'time': text});
  }

  updateLatestSendBy(String text) {
    Firestore.instance
        .collection('chatRoom')
        .document(widget.chatRoomId)
        .updateData({'sendBy': text});
  }

  updateLatestProfileImg(String image) {
    Firestore.instance
        .collection('chatRoom')
        .document(widget.chatRoomId)
        .updateData({'image': image});
  }

  deleteRoom() {
    Firestore.instance
        .collection('chatRoom')
        .document(widget.chatRoomId)
        .delete();
  }

  // deleteLatest() {
  //   Firestore.instance
  //       .collection('chatRoom')
  //       .document(widget.chatRoomId)
  //       .collection('latest')
  //       .document("tdxdsRjTejFnThTxVDGk")
  //       .delete();
  // }

  // deleteChats() {
  //   Firestore.instance
  //       .collection('chatRoom')
  //       .document(widget.chatRoomId)
  //       .collection('chats')
  //       .document()
  //       .delete();
  // }

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

  String chatName;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: chatAppbar(),
      body: Container(
        child: Stack(
          children: [
            chatMessages(),
            SizedBox(height: 10),
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
            SizedBox(height: 10),
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
