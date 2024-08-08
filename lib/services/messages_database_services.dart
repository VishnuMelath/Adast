import 'dart:developer';

import 'package:adast/methods/encrypt.dart';
import 'package:adast/models/chat_room_model.dart';
import 'package:adast/models/message_model.dart';
import 'package:adast/services/chat_room_database_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessagesDatabaseServices {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  ChatRoomDatabaseServices chatRoomDatabaseServices =
      ChatRoomDatabaseServices();
  Future sendOrUpdateMessage(MessageModel message,ChatRoomModel chatroom) async {
    try {
     chatroom.lastMessage=message.message;
     chatroom.time=DateTime.now();
      message.roomId=generateChatRoomId(chatroom);
      message.messageId = generateMessageId(message);
      log(message.roomId);
      await chatRoomDatabaseServices.updateChatRoom(chatroom);
      await firebaseFirestore
          .collection('messages')
          .doc(message.messageId)
          .set(message.toJson());
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
      String chatRoomId) async* {
    try {
  final snapshot = firebaseFirestore
      .collection('messages')
      .where('roomId', isEqualTo: encryptData(chatRoomId));
  log(snapshot.toString());
  yield* snapshot.snapshots();
} on FirebaseException catch (e) {
   log(e.code);
  rethrow;
 
}
  }

  String generateChatRoomId(ChatRoomModel chatRoom) {
    List temp = [chatRoom.sellerId, chatRoom.userId];
    temp.sort();
    return temp.join('_');
  }

  String generateMessageId(MessageModel message) {
    List temp = [
      message.senderId,
      message.recieverId,
      message.timestamp.seconds.toString()
    ];
    log(temp.toString());
    temp.sort();
    log(temp.join('_'));
    return temp.join('_');
  }
}
