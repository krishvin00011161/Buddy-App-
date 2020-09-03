// import 'package:buddyappfirebase/home/functionality/FirebaseRepository.dart';
// import 'package:buddyappfirebase/home/screens/user.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';


// class SearchScreen extends StatefulWidget {
//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }


// class _SearchScreenState extends State<SearchScreen> {
//   @override
//   FirebaseRepository repository = FirebaseRepository();
// List<User> userList;
// String query = "";
// TextEditingController searchControl = TextEditingController();
// void initState(){
//   super.initState();
//   repository.getCurrentUser().then((FirebaseUser user){
//     repository.getAllUsers(user).then((List<User> list){
//       userList = list;
//     });

//   });
// }
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon:Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: ()=> Navigator.pop(context),

//         ),
//         bottom: PreferredSize(
//           child: Padding(
//             padding: EdgeInsets.only(left: 20),
//             child: TextField(
//               controller: searchControl,
//               onChanged: (val){
//                 setState((){
//                   query = val;
//                 });
//               },
//               cursorColor: Colors.black,
//               autofocus: true,
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 20,
//               ),
//               decoration: InputDecoration(
//                 suffixIcon: IconButton(
//                   icon:Icon(Icons.close, color: colors.white) ,
//                   onPressed: (){
//                     WidgetsBinding.instance.addPostFramCallback((_)=>searchControl.clear());

//                   },
//                 ),
//                 border: InputBorder.none,
//                 hintText: "Search Users",
//                 hintStyle: TextStyle(
//                   color: Colors.black,
//                   fontSize: 13,
//                 ),
//               ),
//             ),
//           )
//         ),

//       ),
//       suggestUsers(String query){
//         final List<User> suggestionlist = query.isEmpty
//             ?[]
//             : userList.where((User user){
//               bool matchesName = _getName.contains(_query);
//               bool matchesUsername = _getUsername.contains(_query);
//               String _getName = user.name.toLowerCase();
//               String _query = query.toLowerCase();
//               String _getUsername = user.username.toLowerCase();
//               return (matchUsername || matchesName );
//     }).toList();
//         return ListView.builder(
//             itemCount: suggestionList.length,
//             itemBuilder: ((context, index){
//               User searchedUser = User(
//                 userName: suggestionList[index].userName;
//                 userEmail: suggestionList[index].userEmail;
//                 photoUrl: suggestionList[index].photoUrl);

//     return CustomTile(
//       mini: false,
//       onTap: (){
//         Navigator.push(
//         context,
//         MaterialPageRoute(

//         builder: (context)=> ConversationGroup(
//           reciever: searchedUser,
//     ))),

//     },
//       leading: CircleAvatar(
//         backgroundImage: NetworkImage(searchUser.photoUrl),
//         backgroundColor: Colors.grey,

//       ),
//       title: Text(
//         searchUser.userName,
//         style: TextStyle(
//           color: Colors.black,

//         ),

//       ),
//       subtitle: Text(
//           searchUser.userEmail,
//           style: TextStyle(color: Colors.black),
//         ),


//     ),





//         }),
//     );

//     }
//       body: Container(
//         padding: EdgeInsets.symmetric(horizontal: 20),
//         child: suggestUsers(query),
//       )
//     );
//   }
// }