import 'package:buddyappfirebase/home/widgets/custom_app_bar.dart';
import 'package:buddyappfirebase/home/widgets/custom_drawers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: Scaffold(
          appBar: CustomAppBar(),
          drawer: CustomDrawers(),
          body: ProfilePage(),
          

          ));
  }
}

class ProfilePage extends StatelessWidget {
  String _name = "Cool Guy";
  String _classCount = "0";
  String _questionCount = "1";
  String _answerCount = "999999";

  @override
  Widget build(BuildContext context) {
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
              height: MediaQuery.of(context).size.height * .20,
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
                      height: 300.0,
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
}
