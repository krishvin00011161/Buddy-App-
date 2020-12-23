import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<void> addUserInfo(userData) async {
    // Not Needed
    Firestore.instance.collection("users").add(userData).catchError((e) {
      print(e.toString());
    });
  }

  getUserInfo(String email) async {
    return Firestore.instance
        .collection("users")
        .where("userEmail", isEqualTo: email)
        .getDocuments()
        .catchError((e) {
      print(e.toString());
    });
  }

  searchByName(String searchField) {
    return Firestore.instance
        .collection("users")
        .where('userName', isEqualTo: searchField)
        .getDocuments();
  }

  searchMyQuestions(String name) {
    return Firestore.instance
        .collection('questions')
        .where('userName', isEqualTo: name)
        .getDocuments();
  }

  searchQuestions(String question) {
    return Firestore.instance
        .collection('questions')
        .where('questionContent', isEqualTo: question)
        .getDocuments();
  }

  searchClassQuestions(String className) {
    return Firestore.instance
        .collection('questions')
        .where('classes', isEqualTo: className)
        .getDocuments();
  }

  searchTopicQuestions(String categories) {
    return Firestore.instance
        .collection('questions')
        .where('categories', isEqualTo: categories)
        .getDocuments();
  }

  Future<bool> addChatRoom(chatRoom, chatRoomId) {
    Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .setData(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  getChats(String chatRoomId) async {
    return Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  getQuestions(String searchField) async {
    return Firestore.instance
        .collection('questions')
        .where('questionContent', isEqualTo: searchField)
        .getDocuments();
  }

  // Adds message into the Chat for ChatroomID
  Future<void> addMessage(String chatRoomId, chatMessageData) {
    Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getLatestMessage(String chatRoomId) {
    return Firestore.instance
        .collection('chatRoom')
        .document(chatRoomId)
        .collection('latest')
        .snapshots();
  }

  // Adds message into the Latest Chat for ChatroomID
  Future<void> addLatestMessage(String chatRoomId, chatMessageData) {
     Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("latest")
        .document("tdxdsRjTejFnThTxVDGk")
        .setData(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> updateLatestMessage(String chatRoomId, chatMessageData) {
      Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("latest")
        .document("tdxdsRjTejFnThTxVDGk")
        .updateData(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

 

  getUserChats(String itIsMyName) async {
    return await Firestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }

  getLatestQuestions(String userName) {
    return Firestore.instance
        .collection('questions')
        .where('userName', isEqualTo: userName)
        .orderBy('timeStamp', descending: true)
        .getDocuments();
  }
}
