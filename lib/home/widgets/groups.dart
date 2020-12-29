import 'package:buddyappfirebase/Message/views/chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GroupWidget extends StatelessWidget {
  const GroupWidget({
    Key key,
    @required this.context,
    @required this.photoUrl,
    @required this.title,
    @required this.messageContent,
    @required this.chatRoomId,
    @required this.time,
    @required this.secondPhotoUrl,
    
  }) : super(key: key);

  final BuildContext context;
  final String photoUrl;
  final String title;
  final String messageContent;
  final String chatRoomId;
  final String time;
  final String secondPhotoUrl;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 10 / 9.3,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Chat(
                        chatRoomId: chatRoomId,
                      )));
        },
        child: Container(
          width: 100,
          padding: EdgeInsets.all(4.0),
          margin: EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xF1C40F),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                  Color(0xF1C40F)
                      .withOpacity(1), //Colors.black.withOpacity(.8),
                  Color(0xF1C40F)
                      .withOpacity(1), //Colors.black.withOpacity(.2),
                ])),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    title,
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold)),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 250.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: -10,
                        blurRadius: 0,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Colors.transparent,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 5.0),
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[300],
                            blurRadius: 5.0,
                            offset: Offset(0, 3))
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage("$photoUrl"),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    messageContent,
                                    style: TextStyle(fontSize: 16),
                                    maxLines: 3,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 8,
                                  backgroundImage: NetworkImage("$photoUrl"), // change to image in latest
                                ),
                                SizedBox(width: 7),
                                CircleAvatar(
                                  radius: 8,
                                  backgroundImage: NetworkImage(
                                      "https://format-com-cld-res.cloudinary.com/image/private/s--6tY55LWi--/c_limit,g_center,h_700,w_65535/fl_keep_iptc.progressive,q_95/v1/a285743183c1c064087260b9d65c05f3/BG-0220_web.jpg"),
                                ),
                                SizedBox(width: 7),
                                CircleAvatar(
                                  radius: 8,
                                  backgroundColor: Colors.transparent,
                                ),
                                SizedBox(width: 50),
                                Container(
                                  height: 23.0,
                                  width: 85,
                                  color: Colors.transparent,
                                  child: new Container(
                                      decoration: new BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: new BorderRadius.only(
                                            topLeft:
                                                const Radius.circular(10.0),
                                            topRight:
                                                const Radius.circular(10.0),
                                            bottomLeft:
                                                const Radius.circular(10.0),
                                            bottomRight:
                                                const Radius.circular(10.0),
                                          )),
                                      child: new Center(
                                        child: new Text(time),
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ), // this is responsible for the inside
        ),
      ), // overall container
    );
  }
}