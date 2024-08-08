import 'package:cloud_firestore/cloud_firestore.dart';

import '../methods/encrypt.dart';

class MessageModel {
  String roomId;
  String messageId;
  final String senderId;
  final String recieverId;
  final Timestamp timestamp;
  final String message;
  final bool seen;

  MessageModel({
    required this.message,
    required this.roomId,
    required this.messageId,
    required this.seen,
    required this.senderId,
    required this.recieverId,
    required this.timestamp,
  });

  factory MessageModel.fromJson(Map<String, dynamic> data) {
    return MessageModel(
      message: decryptData(data['message']),
      roomId: decryptData(data['roomId']) ,
      messageId: decryptData(data['messageId']),
      seen: data['seen'],
      senderId: decryptData(data['senderId']),
      recieverId: decryptData(data['recieverId']),
      timestamp: data['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': encryptData(message),
      'roomId': encryptData(roomId),
      'messageId': encryptData(messageId),
      'seen': seen,
      'senderId': encryptData(senderId),
      'recieverId': encryptData(recieverId),
      'timestamp': timestamp,
    };
  }
}
