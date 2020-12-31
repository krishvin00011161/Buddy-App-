/* 
  Authors: David Kim, Aaron NI, Vinay Krisnan
  Date: 12/30/20

  Function: TimeStamp
  Description: Convert Timestamp into readable format


 */


import 'package:intl/intl.dart';


class TimeStamp {
  String readQuestionTimeStamp(int timestamp) {
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var time = '';
    time = DateFormat.yMMMd().format(date);
    return time;
  }
  String readQuestionTimeStampHours(int timestamp1) {
    var format1 = DateFormat('Md');
    var date1 = DateTime.fromMillisecondsSinceEpoch(timestamp1);
    var time1 = '';
    time1 = DateFormat.yMMMd().format(date1);
    return time1;
  }
}