/* 
  Authors: David Kim, Aaron NI, Vinay Krisnan
  Date: 12/30/20

  Function: Database methods
  Description: useful database methods for use


 */

import 'package:buddyappfirebase/GlobalWidget/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  // Adds user Info
  Future<void> addUserInfo(userData) async {
    Firestore.instance.collection("users").add(userData).catchError((e) {
      print(e.toString());
    });
  }

  // gets user info by searching userName
  searchByName(String searchField) {
    return Firestore.instance
        .collection("users")
        .where('userName', isEqualTo: searchField)
        .getDocuments();
  }

  // Search questions by searching userName
  searchMyQuestions(String name) {
    return Firestore.instance
        .collection('questions')
        .where('userName', isEqualTo: name)
        .getDocuments();
  }

  // Search question by question content
  searchQuestions(String question) {
    return Firestore.instance
        .collection('questions')
        .where('questionContent', isEqualTo: question)
        .getDocuments();
  }

  // Search classes by username
  searchClasses(String name) {
    return Firestore.instance
        .collection('users')
        .where('userName', isEqualTo: name)
        .getDocuments();
  }

  // search questions by className
  searchClassQuestions(String className) {
    return Firestore.instance
        .collection('questions')
        .where('classes', isEqualTo: className)
        .getDocuments();
  }

  // Search questions by topics
  searchTopicQuestions(String categories) {
    return Firestore.instance
        .collection('questions')
        .where('categories', isEqualTo: categories)
        .getDocuments();
  }

  // Search If user have Liked
  searchIfUserLiked(String userId, String questionId) {
    return Firestore.instance
        .collection('questions')
        .document(questionId)
        .collection('likes')
        .where('userId', isEqualTo: userId)
        .getDocuments();
  }

  // add ChatRoom
  Future<bool> addChatRoom(chatRoom, chatRoomId) {
    Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .setData(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  Future<bool> addQuestion(content, questionId) {
    Firestore.instance
        .collection("questions")
        .document(questionId)
        .setData(content)
        .catchError((e) {
      print(e);
    });
  }

  Future<void> addLike(String questionId, content) {
    // changed from .add to .set If trouble search this
    Firestore.instance
        .collection("questions")
        .document(questionId)
        .collection("likes")
        .document(Constants.myId)
        .setData(content)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> deleteLike(String questionId) {
    Firestore.instance
        .collection("questions")
        .document(questionId)
        .collection("likes")
        .document(Constants.myId)
        .delete()
        .catchError((e) {
      print(e.toString());
    });
  }

  // gets user info by searching email
  getUserInfo(String email) async {
    return Firestore.instance
        .collection("users")
        .where("userEmail", isEqualTo: email)
        .getDocuments()
        .catchError((e) {
      print(e.toString());
    });
  }

  // get chats by searching ChatRoomId
  getChats(String chatRoomId) async {
    return Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  // get comments by searching questionId
  getComments(String questionId) async {
    return Firestore.instance
        .collection("questions")
        .document(questionId)
        .collection("comments")
        .snapshots();
  }

  // gets chat Name by chatroomId
  getChatsName(String chatRoomId) async {
    return Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .snapshots();
  }

  getAmountOfLikes(String questionId) {
    return Firestore.instance
        .collection('questions')
        .document(questionId)
        .collection('likes')
        .getDocuments();
  }

  // get questions by searching question content
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

  Future<void> addLatestComment(String questionId, content) {
    Firestore.instance
        .collection("questions")
        .document(questionId)
        .collection("comments")
        .add(content)
        .catchError((e) {
      print(e.toString());
    });
  }

  // get latest sent message by searching chatRoomId
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

  // update Latest Message by ChatRoomId
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

  // get Users chat by using username
  getUserChats(String itIsMyName) async {
    return await Firestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }

  // get Latest qeustion by userName
  getLatestQuestions(String userName) {
    return Firestore.instance
        .collection('questions')
        .where('userName', isEqualTo: userName)
        .orderBy('timeStamp', descending: true)
        .getDocuments();
  }

  // get user profile img by userNmae
  getProfileImg(String userName) {
    return Firestore.instance
        .collection('users')
        .where('userName', isEqualTo: userName)
        .getDocuments();
  }
}
// import 'package:buddyappfirebase/GlobalWidget/constants.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class DatabaseMethods {
//   // Adds user Info
//   Future<void> addUserInfo(userData) async {
//     Firestore.instance.collection("users").add(userData).catchError((e) {
//       print(e.toString());
//     });
//   }

//   // add ChatRoom
//   Future<bool> addChatRoom(chatRoom, chatRoomId) {
//     Firestore.instance
//         .collection("chatRoom")
//         .document(chatRoomId)
//         .setData(chatRoom)
//         .catchError((e) {
//       print(e);
//     });
//   }

//   Future<bool> addQuestion(content, questionId) {
//     Firestore.instance
//         .collection("questions")
//         .document(questionId)
//         .setData(content)
//         .catchError((e) {
//       print(e);
//     });
//   }

//   Future<void> addLatestComment(String questionId, content) {
//     Firestore.instance
//         .collection("questions")
//         .document(questionId)
//         .collection("comments")
//         .add(content)
//         .catchError((e) {
//       print(e.toString());
//     });
//   }

//   Future<void> addLike(String questionId, content) {
//     Firestore.instance
//         .collection("questions")
//         .document(questionId)
//         .collection("likes")
//         .document(Constants.myId)
//         .setData(content)
//         .catchError((e) {
//       print(e.toString());
//     });
//   }

//   // Adds message into the Chat for ChatroomID
//   Future<void> addMessage(String chatRoomId, chatMessageData) {
//     Firestore.instance
//         .collection("chatRoom")
//         .document(chatRoomId)
//         .collection("chats")
//         .add(chatMessageData)
//         .catchError((e) {
//       print(e.toString());
//     });
//   }

//   // Adds message into the Latest Chat for ChatroomID
//   Future<void> addLatestMessage(String chatRoomId, chatMessageData) {
//     Firestore.instance
//         .collection("chatRoom")
//         .document(chatRoomId)
//         .collection("latest")
//         .document("tdxdsRjTejFnThTxVDGk")
//         .setData(chatMessageData)
//         .catchError((e) {
//       print(e.toString());
//     });
//   }

//   Future<void> deleteLike(String questionId) {
//     Firestore.instance
//         .collection("questions")
//         .document(questionId)
//         .collection("likes")
//         .document(Constants.myId)
//         .delete()
//         .catchError((e) {
//       print(e.toString());
//     });
//   }

//   // gets user info by searching email
//   getUserInfo(String email) async {
//     return Firestore.instance
//         .collection("users")
//         .where("userEmail", isEqualTo: email)
//         .getDocuments()
//         .catchError((e) {
//       print(e.toString());
//     });
//   }

//   // get chats by searching ChatRoomId
//   getChats(String chatRoomId) async {
//     return Firestore.instance
//         .collection("chatRoom")
//         .document(chatRoomId)
//         .collection("chats")
//         .orderBy('time')
//         .snapshots();
//   }

//   // getComments search by questionId

//   // gets chat Name by chatroomId
//   getChatsName(String chatRoomId) async {
//     return Firestore.instance
//         .collection("chatRoom")
//         .document(chatRoomId)
//         .snapshots();
//   }

//   // get questions by searching question content
//   getQuestions(String searchField) async {
//     return Firestore.instance
//         .collection('questions')
//         .where('questionContent', isEqualTo: searchField)
//         .getDocuments();
//   }

//   // get latest sent message by searching chatRoomId
//   getLatestMessage(String chatRoomId) {
//     return Firestore.instance
//         .collection('chatRoom')
//         .document(chatRoomId)
//         .collection('latest')
//         .snapshots();
//   }

//   // get Users chat by using username
//   getUserChats(String itIsMyName) async {
//     return await Firestore.instance
//         .collection("chatRoom")
//         .where('users', arrayContains: itIsMyName)
//         .snapshots();
//   }

//   // get Latest qeustion by userName
//   getLatestQuestions(String userName) {
//     return Firestore.instance
//         .collection('questions')
//         .where('userName', isEqualTo: userName)
//         .orderBy('timeStamp', descending: true)
//         .getDocuments();
//   }

//   // get user profile img by userNmae
//   getProfileImg(String userName) {
//     return Firestore.instance
//         .collection('users')
//         .where('userName', isEqualTo: userName)
//         .getDocuments();
//   }

//   getAmountOfLikes(String questionId) {
//     return Firestore.instance
//         .collection('questions')
//         .document(questionId)
//         .collection('likes')
//         .orderBy('time')
//         .getDocuments();
//   }

//   // get comments by searching questionId
//   getComments(String questionId) async {
//     return Firestore.instance
//         .collection("questions")
//         .document(questionId)
//         .collection("comments")
//         .orderBy('time')
//         .snapshots();
//   }
// }

// // gets user info by searching userName
// searchByName(String searchField) {
//   return Firestore.instance
//       .collection("users")
//       .where('userName', isEqualTo: searchField)
//       .getDocuments();
// }

// // Search questions by searching userName
// searchMyQuestions(String name) {
//   return Firestore.instance
//       .collection('questions')
//       .where('userName', isEqualTo: name)
//       .getDocuments();
// }

// // Search question by question content
// searchQuestions(String question) {
//   return Firestore.instance
//       .collection('questions')
//       .where('questionContent', isEqualTo: question)
//       .getDocuments();
// }

// // Search classes by username
// searchClasses(String name) {
//   return Firestore.instance
//       .collection('users')
//       .where('userName', isEqualTo: name)
//       .getDocuments();
// }

// // search questions by className
// searchClassQuestions(String className) {
//   return Firestore.instance
//       .collection('questions')
//       .where('classes', isEqualTo: className)
//       .getDocuments();
// }

// // Search questions by topics
// searchTopicQuestions(String categories) {
//   return Firestore.instance
//       .collection('questions')
//       .where('categories', isEqualTo: categories)
//       .getDocuments();
// }

// // Search If user have Liked
// searchIfUserLiked(String userId, String questionId) {
//   return Firestore.instance
//       .collection('questions')
//       .document(questionId)
//       .collection('likes')
//       .where('userId', isEqualTo: userId)
//       .getDocuments();
// }

//   // update Latest Message by ChatRoomId
//   Future<void> updateLatestMessage(String chatRoomId, chatMessageData) {
//     Firestore.instance
//         .collection("chatRoom")
//         .document(chatRoomId)
//         .collection("latest")
//         .document("tdxdsRjTejFnThTxVDGk")
//         .updateData(chatMessageData)
//         .catchError((e) {
//       print(e.toString());
//     });
//   }
