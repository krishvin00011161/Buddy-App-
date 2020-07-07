//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//
//import '../Explore/explore.dart';
//import '../home/screens/MainHomeView.dart';
//
//class MessageScreen extends StatefulWidget {
//  @override
//  _MessageScreenState createState() => _MessageScreenState();
//}
//
//class _MessageScreenState extends State<MessageScreen> {
//  int _currentIndex = 0;
//
//  CupertinoTabBar tabBar() {
//    return CupertinoTabBar( // Code reuse make some class Reminder
//          currentIndex: _currentIndex,
//          //activeColor: Theme.of(context).primaryColor,
//          items: [
//          BottomNavigationBarItem(
//          icon: Icon(
//            Icons.home,
//            color: _currentIndex == 0 ? Theme.of(context).primaryColor : Colors.grey,
//          ),
//          title: Text(""),
//
//          ),
//          BottomNavigationBarItem(
//          icon: Icon(
//            Icons.search,
//            color: _currentIndex == 1 ? Theme.of(context).primaryColor : Colors.grey
//          ),
//          title: Text(""),
//          ),
//          BottomNavigationBarItem(
//          icon: Icon(
//            Icons.chat,
//            color: _currentIndex == 2 ? Theme.of(context).primaryColor : Colors.grey
//          ),
//          title: Text(""),
//          )
//      ],
//      onTap: (index) {
//        if (index == 0) {
//          Navigator.push(
//          context,
//          MaterialPageRoute(
//            builder: (context) => MainHomeView()),
//          );
//
//
//      } else if (index == 1) {
//          Navigator.push(
//          context,
//          MaterialPageRoute(
//            builder: (context) => ExplorePage()),
//          );
//      } else {
//          Navigator.push(
//          context,
//          MaterialPageRoute(
//            builder: (context) => MessageScreen()),
//          );
//      }
//      },
//    );
//  }
//
//  Scaffold messageView() {
//    return Scaffold(
//      appBar:messageAppBar(),
//      bottomNavigationBar: tabBar(),
//    );
//  }
//
//  AppBar messageAppBar() {
//    return AppBar(
//        title: Text("Message"),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return messageView();
//  }
//}


import 'package:buddyappfirebase/Explore/explore.dart';
import 'package:buddyappfirebase/home/screens/MainHomeView.dart';
import 'package:buddyappfirebase/message/constant_val.dart';
import 'package:buddyappfirebase/message/search_add.dart';
import 'package:buddyappfirebase/message/conversation_screen.dart';
import 'package:buddyappfirebase/message/userInfo_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'database_functionality.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();


}

class _MessageScreenState extends State<MessageScreen> {
  Database databaseFunction = new Database();
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Stream chatRoomsStream;


  Widget chatListUser(){
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, snapshot){
        return snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index){
              return ChatRoomAddedUsersTiles(
                  snapshot.data.documents[index].data["chatroomId"].toString().replaceAll("_", "").replaceAll(Constants.myName, ""),
                  snapshot.data.documents[index].data["chatroomId"]

              );
            }): Container();
      },
    );
  }

  CupertinoTabBar tabBar() {
    return CupertinoTabBar( // Code reuse make some class Reminder

      currentIndex: _currentIndex,
      items: [
        BottomNavigationBarItem(

          icon: Icon(
            Icons.home,
            color: _currentIndex == 0 ? Theme.of(context).primaryColor : Colors.grey,
          ),
          title: Text(""),
        ),
        BottomNavigationBarItem(
          icon: Icon(
              Icons.search,
              color: _currentIndex == 1 ? Theme.of(context).primaryColor : Colors.grey
          ),
          title: Text(""),
        ),
        BottomNavigationBarItem(
          icon: Icon(
              Icons.chat,
              color: _currentIndex == 2 ? Theme.of(context).primaryColor : Colors.grey
          ),
          title: Text(""),
        )
      ],
      onTap: (index) {
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MainHomeView()),
          );


        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ExplorePage()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MessageScreen()),
          );
        }
      },
    );
  }

  void initState(){
    super.initState();

    getUserInfo();
  }


  getUserInfo() async{
    Constants.myName= await GetUserFunctions.getUserNameWithSharedPref();
    databaseFunction.getChatRooms(Constants.myName).then((value){
      setState(() {
        chatRoomsStream=value ;

      });
    });
    setState(() {
    });
  }

  AppBar appBar() { // App bar
    return AppBar(
      iconTheme: new IconThemeData(color: Colors.grey),
      backgroundColor: Colors.grey[100],
      elevation: 0,
      leading: new IconButton(
        icon: CircleAvatar(backgroundImage: NetworkImage("https://picturecorrect-wpengine.netdna-ssl.com/wp-content/uploads/2014/03/portrait-photography.jpg"),),
        onPressed: () => _scaffoldKey.currentState.openDrawer(),
      ),
      title: Text("Messages"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar(),
      bottomNavigationBar: tabBar(),
      body: chatListUser(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_circle),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context)=> SearchAdd()
          ));
        },
      ),
    );
  }
}
class ChatRoomAddedUsersTiles extends StatelessWidget {
  final String userName;
  final String chatRoomID;


  ChatRoomAddedUsersTiles(this.userName, this.chatRoomID);
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context)=>ConversationScreen(chatRoomID),
        ));
      },
      child: Container(
        color: Colors.white70,
        padding: EdgeInsets.symmetric(vertical:16 , horizontal:24 ),
        child: Row(
          children: <Widget>[
            Container(
              height: 45,
              width: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text("${userName.substring(0,1)}"),
            ),
            SizedBox(width: 10,),
            Text(userName),
          ],
        ),
      ),
    );
  }
}