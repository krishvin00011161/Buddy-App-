import 'dart:convert';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:buddyappfirebase/home/widgets/homeUser.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  bool isSearching = false;

  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<HomeUser>> key = new GlobalKey();

  static List<HomeUser> loadUsers(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<HomeUser>((json) => HomeUser.fromJson(json)).toList();
  }

  static List<HomeUser> users = new List<HomeUser>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.grey),
      elevation: 0.0,
      title: !isSearching
          ? Text(
              "Search",
              style: TextStyle(
                color: Colors.grey,
              ),
            )
          : searchTextField = AutoCompleteTextField<HomeUser>(
              key: key,
              clearOnSubmit: false,
              suggestions: users,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                icon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                hintText: "Search Country Here",
                hintStyle: TextStyle(color: Colors.grey),
                fillColor: Colors.grey,
              ),
              itemFilter: (item, query) {
                return item.name.toLowerCase().startsWith(query.toLowerCase());
              },
              itemSorter: (a, b) {
                return a.name.compareTo(b.name);
              },
              itemSubmitted: (item) {
                // setState(() {

                // });
              },
              itemBuilder: (context, item) {
                return Card(
                  child: ListTile(
                    title: Text(item.name),
                  ),
                );
                //return row(item);
              },
            ),
      actions: <Widget>[
        isSearching
            ? IconButton(
                icon: Icon(Icons.cancel),
                color: Colors.grey,
                onPressed: () {
                  // setState(() {
                  //   this.isSearching = false;
                  //   //Navigator.pop(context);
                  //   }
                  // );
                },
              )
            : IconButton(
                icon: Icon(Icons.search),
                color: Colors.grey,
                onPressed: () {
                  // setState(() {
                  //   this.isSearching = true;
                  //   //  Navigator.push(context,
                  //   // MaterialPageRoute(
                  //   //  builder: (context) => SearchScreen()));
                  // });
                },
              )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
