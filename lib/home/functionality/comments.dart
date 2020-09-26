// import 'package:buddyappfirebase/FirebaseData/firebaseReferences.dart';
// import 'package:buddyappfirebase/Message/helper/constants.dart';
// import 'package:buddyappfirebase/Message/helper/helperfunctions.dart';
// import 'package:buddyappfirebase/Widget/progress.dart';
// import 'package:buddyappfirebase/home/widgets/header.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class Comments extends StatefulWidget {
//   final String postId;
//   final String postOwnerId;
//   final String postMediaUrl;

//   Comments({
//     this.postId,
//     this.postOwnerId,
//     this.postMediaUrl,
//   });

//   @override
//   CommentsState createState() => CommentsState(
//         postId: this.postId,
//         postOwnerId: this.postOwnerId,
//         postMediaUrl: this.postMediaUrl,
//       );
// }

// class CommentsState extends State<Comments> {
//   TextEditingController commentController = TextEditingController();
//   final String postId;
//   final String postOwnerId;
//   final String postMediaUrl;
//   String _name = "";
//   final DateTime timestamp = DateTime.now();
//   String profileImg;

//   @override
//   void initState() { 
//     super.initState();
//     _getUserName();
//     _getUserProfileImg();
//   }

//   CommentsState({
//     this.postId,
//     this.postOwnerId,
//     this.postMediaUrl,
//   });

//   // gets the username
//   _getUserName() async {
//     Constants.myId = await HelperFunctions.getUserIDSharedPreference();
//     final DocumentSnapshot doc =
//         await FirebaseReferences.usersRef.document(Constants.myId).get();

//     (doc.data["userName"] != null)
//         ? setState(() {
//             _name = doc.data["userName"];
//           })
//         : circularProgress();
//   }
//   // gets the profile
//   _getUserProfileImg() async {
//     Constants.myId = await HelperFunctions.getUserIDSharedPreference();
//     final DocumentSnapshot doc =
//         await FirebaseReferences.usersRef.document(Constants.myId).get();

//     (doc.data["photoUrl"] != null)
//         ? setState(() {
//             profileImg = doc.data["photoUrl"];
//           })
//         : circularProgress();
//   }

//   buildComments() {
//     return StreamBuilder(
//         stream: FirebaseReferences.commentsRef
//             .document(postId)
//             .collection('comments')
//             .orderBy("timestamp", descending: false)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return circularProgress();
//           }
//           List<Comment> comments = [];
//           snapshot.data.documents.forEach((doc) {
//             comments.add(Comment.fromDocument(doc));
//           });
//           return ListView(
//             children: comments,
//           );
//         });
//   }

//   addComment() {
//      FirebaseReferences.commentsRef.document(postId).collection("comments").add({
//       "username": _name,
//       "comment": commentController.text,
//       "timestamp": timestamp,
//       "avatarUrl": profileImg,
//       "userId" : Constants.myId
//     });
//     // bool isNotPostOwner = postOwnerId != currentUser.id;
//     // if (isNotPostOwner) {
//     //   activityFeedRef.document(postOwnerId).collection('feedItems').add({
//     //     "type": "comment",
//     //     "commentData": commentController.text,
//     //     "timestamp": timestamp,
//     //     "postId": postId,
//     //     "userId": currentUser.id,
//     //     "username": currentUser.username,
//     //     "userProfileImg": currentUser.photoUrl,
//     //     "mediaUrl": postMediaUrl,
//     //   });
//     // }
//     commentController.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: header(context, titleText: "Comments"),
//       body: Column(
//         children: <Widget>[
//           Expanded(child: buildComments()),
//           Divider(),
//           ListTile(
//             title: TextFormField(
//               controller: commentController,
//               decoration: InputDecoration(labelText: "Write a comment..."),
//             ),
//             trailing: OutlineButton(
//               onPressed: addComment,
//               borderSide: BorderSide.none,
//               child: Text("Post"),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class Comment extends StatelessWidget {
//   final String username;
//   final String userId;
//   final String avatarUrl;
//   final String comment;
//   final Timestamp timestamp;

//   Comment({
//     this.username,
//     this.userId,
//     this.avatarUrl,
//     this.comment,
//     this.timestamp,
//   });

//   factory Comment.fromDocument(DocumentSnapshot doc) {
//     return Comment(
//       username: doc['username'],
//       userId: doc['userId'],
//       comment: doc['comment'],
//       timestamp: doc['timestamp'],
//       avatarUrl: doc['avatarUrl'],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         ListTile(
//           title: Text(comment),
//           leading: CircleAvatar(
//             backgroundImage: NetworkImage("$profileImg"),
//           ),
//           subtitle: Text(timestamp.toString()),
//         ),
//         Divider(),
//       ],
//     );
//   }
// }