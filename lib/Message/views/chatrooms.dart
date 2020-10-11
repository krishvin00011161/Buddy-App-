import 'package:buddyappfirebase/Message/helper/constants.dart';
import 'package:buddyappfirebase/Message/helper/helperfunctions.dart';
import 'package:buddyappfirebase/Message/helper/theme.dart';
import 'package:buddyappfirebase/Message/views/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Explore/screen/explore.dart';
import '../../home/screens/MainHomeView.dart';
import '../../home/widgets/custom_drawers.dart';
import '../services/database.dart';
import 'chat.dart';


class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
  
}

class _ChatRoomState extends State<ChatRoom> {
  DatabaseMethods databaseMethods = new DatabaseMethods(); // added

  Stream chatRooms;

  int _currentIndex = 0;

  int chatCount = 0;

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        
        return snapshot.hasData
            ? ListView.builder(
                
                itemCount: snapshot.data.documents.length, 
                
               shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ChatRoomsTile(
                    userName: snapshot
                        .data
                        .documents[index]
                        .data[
                            'chatRoomId'] //userName: snapshot.data.documents[index].data['chatRoomId']
                        .toString()
                        .replaceAll("_", "")
                        .replaceAll(Constants.myName, ""),
                    chatRoomId: snapshot.data.documents[index].data[
                        "chatRoomId"], 
                        chatRoomName: snapshot.data != null ?  snapshot.data.documents[index].data['chatRoomName'] : "",
                  );
                }) 
            : Container();
            
      },
    );
  }

  @override
  void initState() {
    getUserInfogetChats();
    super.initState();
  }

  getUserInfogetChats() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    DatabaseMethods().getUserChats(Constants.myName).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
        print(
            "we got the data + ${chatRooms.toString()} this is name  ${Constants.myName}");
      });
    });
  }

  AppBar chatRoomAppbar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.grey),
      elevation: 0.0,
      bottom: PreferredSize(
      child: Container(
         color: Colors.grey,
         height: 1.0,
      ),
      preferredSize: Size.fromHeight(1.0)),
      title: Text(
        "Messages",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: chatRoomAppbar(),
      drawer: CustomDrawers(),
      bottomNavigationBar: CupertinoTabBar(
        // Code reuse make some class Reminder
        currentIndex: _currentIndex,
        //activeColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _currentIndex == 0
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
            ),
            title: Text(""),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search,
                color: _currentIndex == 1
                    ? Theme.of(context).primaryColor
                    : Colors.grey),
            title: Text(""),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat,
                color: _currentIndex == 2
                    ? Theme.of(context).primaryColor
                    : Colors.grey),
            title: Text(""),
          )
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainHomeView()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ExplorePage()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatRoom()),
            );
          }
        },
      ),
      body: Container(
        child: chatRoomsList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.search,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Search()));
        },
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  final String chatRoomName;

  ChatRoomsTile({this.userName, @required this.chatRoomId, this.chatRoomName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Chat(
                      chatRoomId: chatRoomId,
                    )));
      },
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              padding: EdgeInsets.all(11),
              decoration: BoxDecoration(
                  color: CustomTheme.colorAccent,
                  borderRadius: BorderRadius.circular(30)),
              child: Text(userName.substring(0, 1),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, //white
                      fontSize: 20,
                      fontFamily: 'OverpassRegular',
                      fontWeight: FontWeight.w600)),
            ),
            SizedBox(
              width: 12,
            ),
            Text(chatRoomName,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'OverpassRegular',
                    fontWeight: FontWeight.w400))
          ],
        ),
      ),
    );
  }
}
