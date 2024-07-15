import 'package:cloud_firestore/cloud_firestore.dart';

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
        roomId: data['roomId'],
        userId: data['userId'],
        sellerId: data['sellerId'],
        sellerUnreadCount: data['sellerUnreadCount'],
        userUnreadCount: data['userUnreadCount'],
        lastMessage: data['lastMessage'],
        time:( data['time'] as Timestamp).toDate()
        );
  }

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'userId': userId,
      'sellerId': sellerId,
      'sellerUnreadCount': sellerUnreadCount,
      'userUnreadCount': userUnreadCount,
      'lastMessage': lastMessage,
      'time':Timestamp.fromDate(time)
    };
  }
}
