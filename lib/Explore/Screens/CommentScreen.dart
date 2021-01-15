import 'package:buddyappfirebase/GlobalWidget/constants.dart';
import 'package:buddyappfirebase/Home/Screens/MainHomeView.dart';
import 'package:buddyappfirebase/Message/Services/Database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../GlobalWidget/constants.dart';


class CommentScreen extends StatefulWidget {
  final String questionContent;
  final String userName;
  final String questionId;
  final int timeStamp;
 

  CommentScreen({this.questionContent, this.userName, this.questionId, this.timeStamp});

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  TextEditingController commentEditingController = new TextEditingController();
  bool isLoading = false;
  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot searchResultSnapshot;
  bool haveUserSearched;
  DocumentReference documentReference =
  Firestore.instance.collection('comments').document();

  @override
  void initState() {
    super.initState();
    getProfileImg();
  }

  getProfileImg() async {
    if (commentEditingController.text.isEmpty) {
      setState(() {
        isLoading = true;
      });
      await databaseMethods.getProfileImg(widget.userName).then((snapshot) {
        searchResultSnapshot = snapshot;
        print("$searchResultSnapshot");
        setState(() {
          isLoading = false;
          haveUserSearched = true;
        });
      });
    }
  }

 
 


  comment() async {
    if (commentEditingController.text.isNotEmpty) {
      Map<String, dynamic> comment = {
        "userName": Constants.myName,
        "commentContent": commentEditingController.text,
        "commentId": documentReference.documentID,
        "timeStamp": DateTime.now().millisecondsSinceEpoch,
        "photoUrl" : Constants.myProfileImg,
        "questionContent" : widget.questionContent,
        "questionTimeStamp" : widget.timeStamp,
        "questionUserName" : widget.userName,
        "questionId" : widget.questionId
      };

      DatabaseMethods().addLatestComment(widget.questionId, comment);

      setState(() {
        commentEditingController.text = "";
      });
    }
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text("Comment"),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.cancel,
            color: Colors.lightBlue[200],
          ),
        ),
        actions: <Widget>[
          GestureDetector(
            child: IconButton(
              icon: Icon(
                Icons.send,
                color: Colors.lightBlue[200],
              ),
              onPressed: () {
                comment();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainHomeView()),
                );
              },
            ),
            onTap: () {
              comment();
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
                        searchResultSnapshot.documents[0].data["photoUrl"]),
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
                Flexible(
                  child: Text(
                    widget.questionContent,
                    style: TextStyle(fontSize: 20, color: Colors.black87),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(Constants.myProfileImg),
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Type your reply",
                      focusColor: Colors.black,
                    ),
                    controller: commentEditingController,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
