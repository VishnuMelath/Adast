import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String senderId;
  final String recieverId;
  final Timestamp timestamp;

  MessageModel(
      {required this.senderId,
      required this.recieverId,
      required this.timestamp});

  factory MessageModel.fromJson(Map<String, dynamic> data) {
    return MessageModel(
        senderId: data['senderId'],
        recieverId: data['recieverId'],
        timestamp: data['timestamp']);
  }
  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'recieverId': recieverId,
      'timestamp': timestamp
    };
  }
}
