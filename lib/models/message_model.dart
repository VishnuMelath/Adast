import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String roomId;
   String messageId;
  final String senderId;
  final String recieverId;
  final Timestamp timestamp;
  final String message;
  final bool seen;

  MessageModel(
      {
        required this.message,
        required this .roomId,
        required this.messageId,
        required this.seen,
         required this.senderId,
      required this.recieverId,
      required this.timestamp});

  factory MessageModel.fromJson(Map<String, dynamic> data) {
    return MessageModel(
      message: data['message'],
      roomId: data['roomId'],
      messageId: data['messageId'],
      seen: data['seen'],
        senderId: data['senderId'],
        recieverId: data['recieverId'],
        timestamp: data['timestamp']);
  }
  Map<String, dynamic> toJson() {
    return {
      'message':message,
      'roomId':roomId,
      'messageId':messageId,
      'seen':seen,
      'senderId': senderId,
      'recieverId': recieverId,
      'timestamp': timestamp
    };
  }
}
