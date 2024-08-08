

import 'package:adast/methods/encrypt.dart';
import 'package:adast/models/chat_room_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomDatabaseServices {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future createChatRoomIfDoesNotExists(String userId, String sellerId) async {}

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllChatRooms(
      String userId) async* {
    try {
      final snapshots = firebaseFirestore
          .collection('chatrooms')
          .where('userId', isEqualTo: encryptData(userId))
          .snapshots();

      yield* snapshots;
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  Future updateChatRoom(ChatRoomModel chatroom) async {
    try {
      final snapshot=firebaseFirestore
          .collection('chatrooms')
          .doc(chatroom.roomId);
      if(!await snapshot.get().then((value) => value.exists,))
          {
            await snapshot.set(chatroom.toJson());
          }
          
      await firebaseFirestore
          .collection('chatrooms')
          .doc(chatroom.roomId)
          .update({'sellerUnreadCount':FieldValue.increment(1),'lastMessage':encryptData(chatroom.lastMessage),'time':chatroom.time});
    } on FirebaseException catch (_) {
      rethrow;
    }
  }
 Future updateChatRoomUnseenCount(ChatRoomModel chatroom) async {
    try {
      await firebaseFirestore
          .collection('chatrooms')
          .doc(chatroom.roomId)
          .update({'userUnreadCount':0});
    } on FirebaseException catch (_) {
      rethrow;
    }
  }
  Future checkWheatherChatroomExists(String sellerId,String userId) async {
    try {
      var count = await firebaseFirestore
          .collection('chatrooms')
          .where('sellerId', isEqualTo: encryptData(sellerId)).where('userId',isEqualTo: encryptData(userId))
          .get();
        if(count.docs.isEmpty)
        {
          return ChatRoomModel(roomId:'' , userId: userId, sellerId: sellerId, sellerUnreadCount: 0, userUnreadCount: 0, lastMessage: '', time: DateTime.now());
        }
        else
        {
          return ChatRoomModel.fromSnapShot(count.docs.first);
        }
      // return count.count ?? 0;
    } on FirebaseException catch (_) {
      rethrow;
    }
  }
}
