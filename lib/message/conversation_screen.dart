import 'package:buddyappfirebase/message/constant_val.dart';
import 'package:buddyappfirebase/message/widgets_messages.dart';
import 'package:flutter/material.dart';

import 'database_functionality.dart';
class ConversationScreen extends StatefulWidget {
  @override
  String chatRoomId;
  ConversationScreen(this.chatRoomId);

  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {

  Database databaseFunctionality = new Database();
  TextEditingController controlledMessage= new TextEditingController();
  Stream chatMessageStream;
  Widget ChatMessageList() {
    return StreamBuilder(
      stream: chatMessageStream,
      builder: (context, snapshot){
        return snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data.length(),
            itemBuilder: (context, index){
              return MessageTile(snapshot.data.documents[index].data["message"],
                  snapshot.data.documents[index].data["senderBy"]==Constants.myName);

            }):Container();
      },

    );
  }


  messageSend() {
    if (controlledMessage.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": controlledMessage.text,
        "sendBy": Constants.myName,
        "time": DateTime.now().millisecondsSinceEpoch,
      };


      databaseFunctionality.getConversation(widget.chatRoomId, messageMap);
      controlledMessage.text="";
    }
  }
  void initState(){
    databaseFunctionality.getMessageConversation(widget.chatRoomId).then((value){

      setState(() {
        chatMessageStream= value;
      });
    });
    super.initState();

  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Stack(
            children:[
              ChatMessageList(),
              Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding:  EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: controlledMessage,
                          decoration: InputDecoration(

                              hintText: "Enter Message...",
                              hintStyle: TextStyle(color: Colors.white, fontFamily: "Time New Roman",),
                              border: InputBorder.none),
                        ),

                      ),
                      GestureDetector(
                        onTap: (){

                          //createSearch();
                          messageSend();

                        },
                        child: Container(

                          height: 40,
                          width: 40,
                          child: Icon(Icons.send),

                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]
        ),
      ),
    );
  }
}
class MessageTile extends StatelessWidget {
  @override
  final String message;
  final bool senderMe;

  MessageTile(this.message, this.senderMe);

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: senderMe?Alignment.centerRight:Alignment.centerLeft ,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 8),
        decoration:BoxDecoration(
          gradient: LinearGradient(
            colors:senderMe?[
              const Color(0xff0000),
              const Color(0x0000ff)
            ]
                :[
              const Color(0x1AFFFFFF),
              const Color(0x1AFFFFFF),
            ],
          ),
        ),

        child: Text(message, style: TextStyle(color: Colors.white, fontSize: 17)),
      ),
    );
  }
}