import 'package:cloud_firestore/cloud_firestore.dart';
class Database {
  getNameUser(String fullName) async {
    return Firestore.instance.collection("users").where("fullName", isEqualTo: fullName).getDocuments();
  }
  getEmailUser(String email) async{
    return Firestore.instance.collection("users").where("email", isEqualTo: email).getDocuments();
  }
  uploadUserData(userMap){
    Firestore.instance.collection("users").add(userMap).catchError((e){
      print(e.toString());
    });
  }
  createChatRoom(String charRoomId, chatRoomMap) {
    Firestore.instance.collection("ChatRoom").document(charRoomId).setData(
        chatRoomMap).catchError((e) {
      print(e.toString());
    });
  }
  getConversation(String chatRoomId, messageMap){
    Firestore.instance.collection("ChatRoom").document(chatRoomId).collection("chats").add(messageMap).catchError((e){
      print(e.toString());
    });
  }
  getMessageConversation (String chatRoomId)async{
    return await Firestore.instance.collection("ChatRoom").document(chatRoomId).collection("chats").orderBy("time",descending: false).snapshots();

  }
  getChatRooms(String userName)async {
    return Firestore.instance.collection("Chatroom").where("users", arrayContains: userName).snapshots();
  }
}