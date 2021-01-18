/* 
  Authors: David Kim, Aaron NI, Vinay Krisnan
  Date: 12/30/20

  Function: SearchQuetion
  Description: It searches question


 */

import 'package:buddyappfirebase/GlobalWidget/Progress.dart';
import 'package:buddyappfirebase/GlobalWidget/TimeStamp.dart';
import 'package:buddyappfirebase/Message/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchQuestion extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<SearchQuestion> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchEditingController = new TextEditingController();
  QuerySnapshot searchResultSnapshot;
  QuerySnapshot userResultSnapshot;
  bool isLoading = false;
  bool haveUserSearched = false;

  _searchQuestion(String value) async {
    if (searchEditingController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await databaseMethods.searchQuestions(value).then((snapshot) {
        searchResultSnapshot = snapshot;
        print("$searchResultSnapshot");
        setState(() {
          isLoading = false;
          haveUserSearched = true;
        });
      });
    }
  }

  __searchUser(String value) async {
    if (searchEditingController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await databaseMethods.searchByName(value).then((snapshot) {
        userResultSnapshot = snapshot;
        print("$searchResultSnapshot");
        setState(() {
          isLoading = false;
          haveUserSearched = true;
        });
      });
    }
  }

  // Widget that makes the chain UI
  Widget userChain(
      String userName, String photoUrl, String message, int timeStamp) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
      child: Row(
        children: [
          Container(
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
            child: Row(
              children: [
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: photoUrl != null
                          ? NetworkImage(photoUrl)
                          : circularProgress(), //Todo
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
                Column(
                  children: <Widget>[
                    Text(
                      TimeStamp().readQuestionTimeStamp(timeStamp),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15.0),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // this widget prints out the user list
  Widget userList() {
    return haveUserSearched
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchResultSnapshot.documents.length,
            itemBuilder: (context, index) {
              return userChain(
                searchResultSnapshot.documents[index].data["userName"],
                searchResultSnapshot.documents[index].data["photoUrl"],
                searchResultSnapshot.documents[index].data["questionContent"],
                searchResultSnapshot.documents[index].data["timeStamp"],
              );
            })
        : Container();
  }

  // searchAppBar UI
  AppBar searchAppBar() {
    return AppBar(
      iconTheme: new IconThemeData(color: Colors.grey),
      backgroundColor: Colors.grey[100],
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Container(
        width: 310,
        child: TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(8.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.grey, width: 3)),
            hintStyle: TextStyle(
                color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
            prefixIcon: Icon(Icons.search),
            hintText: "Search question",
          ),
          controller: searchEditingController,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          onChanged: (val) {
            _searchQuestion(val);
          },
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: GestureDetector(
            child: Icon(Icons.cancel, size: 25),
            onTap: () {
              Navigator.pop(
                context,
              );
            },
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchAppBar(),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              child: Column(
                children: [
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  //   color: Colors.transparent, //Color(0x54FFFFFF)
                  //   child: Row(
                  //     children: [],
                  //   ),
                  // ),
                  userList()
                ],
              ),
            ),
    );
  }
}
