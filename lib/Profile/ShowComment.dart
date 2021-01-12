import 'package:buddyappfirebase/GlobalWidget/TimeStamp.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Message/Services/database.dart';

// Come back and debug
class ShowComment extends StatefulWidget {
  final String questionId;
  ShowComment({this.questionId});

  @override
  _ShowCommentState createState() => _ShowCommentState();
}

class _ShowCommentState extends State<ShowComment> {
  Stream<QuerySnapshot> comments;
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TimeStamp timeStamp = new TimeStamp();

  @override
  void initState() {
    super.initState();
    DatabaseMethods().getComments(widget.questionId).then((val) {
      setState(() {
        comments = val;
      });
    });
  }

  Widget commentChain() {
    return StreamBuilder(
      stream: comments,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return Chain(
                    photoUrl: snapshot.data.documents[index].data["photoUrl"],
                    message: snapshot.data.documents[index].data["commentContent"],
                    userName: snapshot.data.documents[index].data["userName"],
                    timeStamp: timeStamp.readQuestionTimeStamp(snapshot.data.documents[index].data["timeStamp"]),
                  );
                })
            : Container(
                color: Colors.blue,
              );
      },
    );
  }

  AppBar profileAppbar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.grey),
      elevation: 0.0,
      title: Text(
        "Comments",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Scaffold body() {
    return Scaffold(
      appBar: profileAppbar(),
      body: Container(
        color: Colors.white,
        child: commentChain(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }
}

class Chain extends StatelessWidget {
  final String photoUrl;
  final String message;
  final String userName;
  final String timeStamp;

  Chain({this.photoUrl, this.message, this.userName, this.timeStamp});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
      child: Row(
        children: [
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(photoUrl),
              ),
              SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    userName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Text(
                      message,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                  ),
                ],
              ),
            ],
          ),
          //SizedBox(width: 25.0),
          Column(
            children: <Widget>[
              Text(
                timeStamp,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 25.0),
            ],
          ),
        ],
      ),
    );
  }
}
