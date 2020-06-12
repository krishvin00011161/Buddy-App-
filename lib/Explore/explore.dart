import 'package:flutter/material.dart';


class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Explore page"),
      ),
      body: ListView(

        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(11.5),
            child: TextField(
              onChanged: (val){

                //findQuestion(val);
              },
              decoration: InputDecoration(
                prefix:IconButton(
                  color:Colors.black,
                  icon:Icon(Icons.arrow_back),
                  iconSize: 20.0,
                  onPressed: (){
                    Navigator.of(context).pop();
                  },


                ),
                contentPadding: EdgeInsets.only(left: 26.5),
                hintText:'Search Question',
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0))),
                ),
              ),
              ],
            ),
          );
  }
}
// class ExplorePage extends StatefulWidget {
//   @override
//   _ExplorePageState createState() => _ExplorePageState();
// }

// class _ExplorePageState extends State<ExplorePage> {
//   @override
//   Widget build(BuildContext context) {
    
//   }
// }
