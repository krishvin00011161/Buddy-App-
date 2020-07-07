import 'package:buddyappfirebase/Explore/explore.dart';
import 'package:buddyappfirebase/home/screens/MainHomeView.dart';
import 'package:buddyappfirebase/home/widgets/custom_app_bar.dart';
import 'package:buddyappfirebase/home/widgets/custom_drawers.dart';
import 'package:buddyappfirebase/message/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:buddyappfirebase/login/services/firestoreService.dart';

class ProfileView extends StatelessWidget {
  int _currentIndex = 0;
  bool isSelected;
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: Scaffold(
          appBar: ProfileAppbar(),
          drawer: CustomDrawers(),
          body: ProfilePage(),
          bottomNavigationBar: CupertinoTabBar( // Code reuse make some class Reminder
          currentIndex: _currentIndex,
          //activeColor: Theme.of(context).primaryColor,
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
    )
  )
  );
}
  AppBar ProfileAppbar() {
    bool isSearching = false;

    return AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.grey),
      elevation: 0.0,
      title: Text(
        "Requests",
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }
  
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name = "Cool Guy";
  String _classCount = "0";
  String _questionCount = "1";
  String _answerCount = "999999";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    double height =  MediaQuery.of(context).size.height;
    return Scaffold(
      body: Profile(height)
    );
  }



  ListView Profile(double height) {
    getData();
    return ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "$_name",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Container(
              height: 120,
              child: Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                    "https://cdn4.iconfinder.com/data/icons/avatars-21/512/avatar-circle-human-male-3-512.png",
                  ),
                ),
              )
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,

            children: <Widget>[
              FlatButton(
                color: Colors.transparent,
                onPressed: () {

                },
                child: Text(
                  'EDIT PROFILE',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ],
          ),

          Divider(),
          DefaultTabController(
              length: 3,
              initialIndex: 0,
              child: Column(
                children: [
                  TabBar(
                      unselectedLabelColor: Colors.grey,
                      labelColor: Colors.blueAccent,
                      tabs: [
                        Tab(
                          child: Text(
                              '$_classCount\nClasses',
                              textAlign: TextAlign.center,
                            ),
                        ),
                        Tab(
                          child: Text(
                            '$_questionCount\nQuestions',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Tab(
                          child: Text(
                            '$_answerCount\nAnswers',
                            textAlign: TextAlign.center,
                          ),
                        )
                      ]
                  ),
                  Container(
                      height: 250,
                      child: TabBarView(
                        children: [
                          Center(child: Text('fsfafffasa')),
                          Center(child: Text('afahefafre')),
                          Center(child: Text('fsaafaegde')),
                        ],
                      )
                  )
                ],
              )
          )
        ]
    );
  }

  void getData() {
    Firestore.instance.collection("users").document(FirestoreService.id).get().then((value){
      print(value.data);
      setState(() {
        _name = value.data['fullName'];
      });
    });

  }


}
