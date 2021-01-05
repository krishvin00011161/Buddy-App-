
// import 'package:buddyappfirebase/GlobalWidget/constants.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:buddyappfirebase/GlobalWidget/TimeStamp.dart';


// class QuestionWidget extends StatelessWidget {
//   const QuestionWidget({
//     Key key,
//     @required this.questionContent,
//     @required this.timestamp,
//     @required this.likes,
//     @required this.comments,
//   }) : super(key: key);//: _profileImg = profileImg, _name = name, super(key: key);

//   final String questionContent;
//   final int timestamp;
//   final int likes;
//   final int comments;

//   @override
//   Widget build(BuildContext context) {
//     // Makes rectangles belongs in the questions section
//     return AspectRatio(
//       aspectRatio: 4 / 3,
//       child: Container(
//         margin: EdgeInsets.only(right: 15),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: Color(0xF1C40F),
//         ),
//         child: Container(
//           padding: EdgeInsets.all(20),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(25),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 4,
//                   blurRadius: 7,
//                   offset: Offset(0, 3), // changes position of shadow
//                 ),
//               ],
//               gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
//                 Color(0x5EC4F2).withOpacity(1), //Colors.black.withOpacity(.8),
//                 Color(0x5EC4F2).withOpacity(1), //Colors.black.withOpacity(.2),
//               ])),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: <Widget>[
//                   CircleAvatar(
//                     backgroundImage: NetworkImage(Constants.myProfileImg),
//                   ),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: <Widget>[
//                         Padding(
//                           padding: const EdgeInsets.only(top: 0.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Expanded(
//                                 child: Container(
//                                     child: RichText(
//                                   text: TextSpan(children: [
//                                     TextSpan(
//                                       text: Constants.myName,
//                                       //text: "  $name",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 22.0,
//                                           color: Colors.white),
//                                     ),
//                                   ]),
//                                   overflow: TextOverflow.ellipsis,
//                                 )),
//                                 flex: 5,
//                               ),
//                             ],
//                           ),
//                         ),
//                         Text(
//                           "    Asked at " +
//                               TimeStamp().readQuestionTimeStamp(timestamp) +
//                               "                           ",
//                           style: TextStyle(fontSize: 14.0, color: Colors.white),
//                           maxLines: 1,
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Align(
//                 alignment: Alignment.bottomLeft,
//                 child: Text(
//                   "$questionContent",
//                   style: GoogleFonts.roboto(
//                       textStyle: TextStyle(
//                           color: Colors.white,
//                           fontSize: 22.5,
//                           fontWeight: FontWeight.bold)),
//                 ),
//               ),
//               SizedBox(
//                 height: 25,
//               ),
//               Row(
//                 // the comments and likes
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   RichText(
//                     text: TextSpan(
//                       style: TextStyle(color: Colors.grey),
//                       children: [
//                         //TextSpan(text: 'Created with '),
//                         WidgetSpan(
//                           child: Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 2.0),
//                             child: Icon(
//                               Icons.thumb_up,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                         TextSpan(
//                             text: ' $likes',
//                             style:
//                                 TextStyle(color: Colors.white, fontSize: 20)),
//                       ],
//                     ),
//                   ),
//                   SizedBox(width: 17.5),
//                   RichText(
//                     text: TextSpan(
//                       style: TextStyle(color: Colors.grey),
//                       children: [
//                         //TextSpan(text: 'Created with '),
//                         WidgetSpan(
//                           child: Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 2.0),
//                             child: Icon(
//                               Icons.chat,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                         TextSpan(
//                             text: '  $comments',
//                             style:
//                                 TextStyle(color: Colors.white, fontSize: 20)),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//         // this is responsible for the inside
//       ), // overall container
//     );
//   }
// }