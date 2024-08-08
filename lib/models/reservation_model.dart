import 'package:cloud_firestore/cloud_firestore.dart';

import '../methods/encrypt.dart';

class ReservationModel {
   String? id;
  final String transactionId;
  final String sellerId;
  final String userId;
   String itemId;
  String status;
  String size;
  final DateTime reservationTime;
  final int amount;
  final int days;
   DateTime? purchasedDate;

  ReservationModel(
      {required this.id,
      required this.amount,
       this.purchasedDate,
      required this.itemId,
      required this.days,
      required this.size,
      required this.transactionId,
      required this.sellerId,
      required this.userId,
      required this.reservationTime,
      required this.status});

   factory ReservationModel.fromSnapShot(QueryDocumentSnapshot<Object?> data) {
    return ReservationModel(
      size: decryptData(data['size']),
      amount: data['amount'],
      days: data['days'],
      purchasedDate: data['purchasedDate']?.toDate(),
      id: data.id,
      itemId: decryptData(data['itemId']),
      transactionId: decryptData(data['transactionId']),
      sellerId: decryptData(data['sellerId']),
      userId: decryptData(data['userId']),
      reservationTime: data['reservationTime'].toDate(),
      status: decryptData(data['status']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'size': encryptData(size),
      'amount': amount,
      'days': days,
      'purchasedDate': purchasedDate,
      'transactionId': encryptData(transactionId),
      'sellerId': encryptData(sellerId),
      'userId': encryptData(userId),
      'status': encryptData(status),
      'itemId': encryptData(itemId),
      'reservationTime': reservationTime,
    };
  }
   copyWith()
  {
    return {'id':encryptData(itemId),'size':encryptData(size)};
  }
}
