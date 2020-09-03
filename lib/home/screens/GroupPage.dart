import 'package:buddyappfirebase/FirebaseData/firebaseReferences.dart';
import 'package:buddyappfirebase/home/functionality/FirebaseRepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:buddyappfirebase/Message/helper/constants.dart';
import '../../Message/helper/helperfunctions.dart';
import '../../Widget/progress.dart';


class GroupsPage extends StatefulWidget {
  @override
  _GroupsPageState createState() => _GroupsPageState();
}
final FirebaseRepository repository= FirebaseRepository();

class _GroupsPageState extends State<GroupsPage> {
  @override
  String currentUserId;

  void initState(){
    getUserName();
    super.initState();
    repository.getCurrentUser().then((user){
      setState(() {

        currentUserId = Constants.myId;
      });

    });
  }
  getUserName() async {
    Constants.myId = await HelperFunctions.getUserIDSharedPreference();
    final DocumentSnapshot doc = await FirebaseReferences.usersRef.document(Constants.myId).get();

    (doc.data["userName"] != null) ?  setState(() {
      var _profileImg = doc.data["userName"];
    }) : circularProgress();

  }
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:AppBar(
        title: Text("Groups", textAlign: TextAlign.center,

        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.blue,
            ),
            onPressed: (){

              Navigator.pushNamed(context, "/SearchScreen");
            },
          )
        ],
      ),
      floatingActionButton: newGroup(),
      body: ChatListContainer(currentUserId),

    );
  }
}
class ChatListContainer extends StatefulWidget {
  @override
  final String currentUserId;
  ChatListContainer(this.currentUserId);
  _ChatListContainerState createState() => _ChatListContainerState();
}

class _ChatListContainerState extends State<ChatListContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(10) ,
        itemCount: 2,
        itemBuilder: (context, index){
          return CustomTile(
            mini: false,
            onTap: (){},
            title: Text(
              "Gangster Vinny V",
              style: TextStyle(
                color: Colors.white, fontFamily: "Calibri", fontSize: 19,),

            ),
            subtitle: Text(
              "Hello",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            leading: Container(
              constraints: BoxConstraints(maxHeight: 60, maxWidth: 60) ,
              child: Stack(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor:Colors.blueGrey,
                    maxRadius: 30,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.lightBlueAccent,
                        border:Border.all(
                          color: Colors.blue,
                        )
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
class CustomTile extends StatelessWidget {
  @override
  final Widget title;
  final Widget leading;
  final Widget icon;
  final Widget subtitle;
  final Widget trailing;
  final EdgeInsets margin;
  final bool mini;
  final GestureTapCallback onTap;
  final GestureLongPressCallback onLongPress;
  CustomTile({
    @required this.leading,
    @required this.title,
    this.icon,
    @required this.subtitle,
    this.trailing,
    this.margin=const EdgeInsets.all(0),
    this.onTap,
    this.onLongPress,
    this.mini=true,
});
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress ,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: mini ? 10:0),
        margin: margin,
        child: Row(

          children: <Widget>[
            leading,
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: mini?10:15),
                padding:EdgeInsets.symmetric(vertical: mini ? 3:20),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Colors.purple,
                    ),
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        title,
                        SizedBox(height: 5),
                        Row(
                          children: <Widget>[
                            icon??Container(),
                            subtitle,
                          ],
                        )
                      ],
                    ),
                    trailing ?? Container(),
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

class newGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.cyan,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.edit,
        color: Colors.white,
        size: 18,
      ),
      padding: EdgeInsets.all(15),
    );
  }
}
