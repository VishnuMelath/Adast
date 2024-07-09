import 'package:cloud_firestore/cloud_firestore.dart';

import 'message_model.dart';

class ChatRoomModel {
  final String userId;
  final String sellerId;
  List<MessageModel> messages;
  int unseenMessages;

  ChatRoomModel(
      {required this.userId,
      required this.sellerId,
      required this.messages,
      required this.unseenMessages});

  factory ChatRoomModel.fromSnapShot(QueryDocumentSnapshot<Object?> data) {
    return ChatRoomModel(
        userId: data['userId'],
        sellerId: data['sellerId'],
        messages: data['messages'],
        unseenMessages: data['unseenMessages']);
  }
}
