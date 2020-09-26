// import 'package:buddyappfirebase/Message/helper/constants.dart';
// import 'package:buddyappfirebase/Message/services/database.dart';
// import 'package:buddyappfirebase/Message/widget/widget.dart';
// import 'package:buddyappfirebase/Message/views/chatrooms.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'chat.dart';

// class Search extends StatefulWidget {
//   @override
//   _SearchState createState() => _SearchState();
// }

// class _SearchState extends State<Search> {
//   DatabaseMethods databaseMethods = new DatabaseMethods();
//   TextEditingController searchEditingController = new TextEditingController();
//   QuerySnapshot searchResultSnapshot;

//   bool isLoading = false;
//   bool haveUserSearched = false;

//   initiateSearch() async {
//     if (searchEditingController.text.isNotEmpty) {
//       setState(() {
//         isLoading = true;
//       });
//       await databaseMethods
//           .searchByName(searchEditingController.text)
//           .then((snapshot) {
//         searchResultSnapshot = snapshot;
//         print("$searchResultSnapshot");
//         setState(() {
//           isLoading = false;
//           haveUserSearched = true;
//         });
//       });
//     }
//   }

//   Widget userList() {
//     return haveUserSearched
//         ? ListView.builder(
//             shrinkWrap: true,
//             itemCount: searchResultSnapshot.documents.length,
//             itemBuilder: (context, index) {
//               return userTile(
//                 searchResultSnapshot.documents[index].data["userName"],
//                 searchResultSnapshot.documents[index].data["userEmail"],
//               );
//             })
//         : Container();
//   }

//   /// 1.create a chatroom, send user to the chatroom, other userdetails
//   sendMessage(String userName) {
//     List<String> users = [Constants.myName, userName];

//     String chatRoomId = getChatRoomId(Constants.myName, userName);

//     Map<String, dynamic> chatRoom = {
//       "users": users,
//       "chatRoomId": chatRoomId,
//     };

//     databaseMethods.addChatRoom(chatRoom, chatRoomId);

//     Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) => Chat(
//                   chatRoomId: chatRoomId,
//                 )));
//   }

//   Widget userTile(String userName, String userEmail) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//       child: Row(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 userName,
//                 style: TextStyle(color: Colors.black, fontSize: 16),
//               ),
//               Text(
//                 userEmail,
//                 style: TextStyle(color: Colors.black, fontSize: 16),
//               )
//             ],
//           ),
//           Spacer(),
//           GestureDetector(
//             onTap: () {
//               sendMessage(userName);
//             },
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               decoration: BoxDecoration(
//                   color: Colors.blue, borderRadius: BorderRadius.circular(24)),
//               child: Text(
//                 "Message",
//                 style: TextStyle(color: Colors.white, fontSize: 16),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   getChatRoomId(String a, String b) {
//     if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
//       return "$b\_$a";
//     } else {
//       return "$a\_$b";
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: isLoading
//           ? Container(
//               child: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             )
//           : Container(
//               child: Column(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
//                     color: Colors.transparent, //Color(0x54FFFFFF)
//                     child: Row(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => ChatRoom()),
//                             );
//                           },
//                           child: Container(
//                               height: 40,
//                               width: 40,
//                               padding: EdgeInsets.only(right: 20, top: 1),
//                               child: Icon(
//                                 Icons.chevron_left,
//                                 size: 35,
//                                 color: Colors.black,
//                               )),
//                         ),
//                         Expanded(
//                           child: TextField(
//                             controller: searchEditingController,
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 16,
//                             ),
//                             decoration: InputDecoration(
//                               hintText: "Search username ...",
//                               hintStyle: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 16,
//                               ),
//                               //border: InputBorder.none
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             initiateSearch();
//                           },
//                           child: Container(
//                               height: 40,
//                               width: 40,
//                               decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                       colors: [
//                                         const Color(
//                                             0x1544d1), //Color(0x36FFFFFF),
//                                         const Color(
//                                             0x1544d1) //Color(0x0FFFFFFF)
//                                       ],
//                                       begin: FractionalOffset.topLeft,
//                                       end: FractionalOffset.bottomRight),
//                                   borderRadius: BorderRadius.circular(40)),
//                               padding: EdgeInsets.all(12),
//                               child: Icon(
//                                 Icons.search,
//                                 size: 25,
//                                 color: Colors.black,
//                               )),
//                           //Image.asset("assets/images/search_white.png",
//                           //height: 25, width: 25,)),
//                         )
//                       ],
//                     ),
//                   ),
//                   userList()
//                 ],
//               ),
//             ),
//     );
//   }
// }
import 'package:buddyappfirebase/Message/helper/helperfunctions.dart';
import 'package:buddyappfirebase/home/services/database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chat.dart';



class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  TextEditingController searchController = new TextEditingController();
  QuerySnapshot searchResult;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false;
  bool hasUserSearched = false;
  bool isJoin = false;
  String userName = "";
  FirebaseUser user;
  final CollectionReference userCollection = Firestore.instance.collection('users');
  void initState(){
    super.initState();

  }
  getUserNameEmail() async{
    await HelperFunctions.getUserNameSharedPreference().then((value){
      userName=value; 
    });
    user = await FirebaseAuth.instance.currentUser();
  }
  searchByName(String searchField) {
    return Firestore.instance
        .collection("users")
        .where('userName', isEqualTo: searchField)
        .getDocuments();
  }
  initiateSearch()async{
    if(searchController.text.isNotEmpty){
      setState(() {
        isLoading=true; 
      });
      await  searchByName(searchController.text).then((snapshot){
        searchResult = snapshot;
        setState(() {
          isLoading = false;
          hasUserSearched = true;
        });
      });
    }
  }
  void showScaffold(String message){
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: Colors.blueAccent,
        duration: Duration(milliseconds: 1500),
        content: Text(message, textAlign: TextAlign.center, style: TextStyle(fontSize:17.0 )),
      )
    );
  }

  joinGroupValue (String userName, String groupId, String groupName, String admin) async{
    bool value = await DatabaseMethods(uid: user.uid).isUserJoined(groupId, groupName, userName);
    setState(() {
      isJoin = value;
    });
  }
//  Widget groupList() {
//    return hasUserSearched ? ListView.builder(
//      itemCount: searchResult.documents.length,
//      shrinkWrap: true,
//      itemBuilder: (context, index) {
//        return GroupTile(
//
//
//        );
//      },
//    )
//  }
    Widget groupList() {
    return hasUserSearched ? ListView.builder(
      itemCount: searchResult.documents.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return groupTile(
          userName,
          searchResult.documents[index].data["groupId"],
          searchResult.documents[index].data["groupName"],
          searchResult.documents[index].data["admin"],


        );
      },
    ):Container();
  }
  Widget groupTile(String userName, String groupId, String groupName, String admin){
    joinGroupValue(userName, groupId, groupName, admin);
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      leading: CircleAvatar(
          radius: 30.0,
          backgroundColor: Colors.blueAccent,
          child: Text(groupName.substring(0, 1).toUpperCase(), style: TextStyle(color: Colors.white))
      ),
      title: Text(groupName, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text("Admin: $admin"),
      trailing: InkWell(
        onTap: () async {
          await DatabaseMethods(uid: user.uid).togglingGroupJoin(groupId, groupName, userName);
          if(isJoin) {
            setState(() {
              isJoin = !isJoin;
            });
            // await DatabaseService(uid: _user.uid).userJoinGroup(groupId, groupName, userName);
            showScaffold('Successfully joined the group "$groupName"');
            Future.delayed(Duration(milliseconds: 2000), () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Chat(groupId: groupId, userName: userName, groupName: groupName)));
            });
          }
          else {
            setState(() {
              isJoin = !isJoin;
            });
            showScaffold('Left the group "$groupName"');
          }
        },
        child: isJoin ? Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.black87,
              border: Border.all(
                  color: Colors.white,
                  width: 1.0
              )
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Text('Joined', style: TextStyle(color: Colors.white)),
        )
            :
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.blueAccent,
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Text('Join', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Container();
  }
}
