import 'package:cloud_firestore/cloud_firestore.dart';

import '../methods/encrypt.dart';

class ChatRoomModel {
  String roomId;
  final String userId;
  final String sellerId;
  int sellerUnreadCount;
  int userUnreadCount;
  String lastMessage;
  DateTime time;

  ChatRoomModel(
      {required this.roomId,
      required this.userId,
      required this.sellerId,
      required this.sellerUnreadCount,
      required this.userUnreadCount,
      required this.lastMessage,
      required this.time
      });

  factory ChatRoomModel.fromSnapShot(QueryDocumentSnapshot<Object?> data) {
    return ChatRoomModel(
      roomId: decryptData(data['roomId']),
      userId: decryptData(data['userId']),
      sellerId: decryptData(data['sellerId']),
      sellerUnreadCount: data['sellerUnreadCount'],
      userUnreadCount: data['userUnreadCount'],
      lastMessage: decryptData(data['lastMessage']),
      time: (data['time'] as Timestamp).toDate(),
    );
  }

   Map<String, dynamic> toJson() {
    return {
      'roomId': encryptData(roomId),
      'userId': encryptData(userId),
      'sellerId': encryptData(sellerId),
      'sellerUnreadCount':sellerUnreadCount,
      'userUnreadCount': userUnreadCount,
      'lastMessage': encryptData(lastMessage),
      'time': Timestamp.fromDate(time),
    };
  }
}
