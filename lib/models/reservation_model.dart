import 'package:cloud_firestore/cloud_firestore.dart';

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
  final DateTime? purchasedDate;

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
        size: data['size'],
        amount: data['amount'],
        days: data['days'],
        purchasedDate: data['purchasedDate'],
        id: data.id,
        itemId: data['itemId'],
        transactionId: data['transactionId'],
        sellerId: data['sellerId'],
        userId: data['userId'],
        reservationTime: data['reservationTime'].toDate(),
        status: data['status']);
  }
  Map<String, dynamic> toJson() {
    return {
      'size':size,
      'amount': amount,
      'days': days,
      'purchasedDate':purchasedDate,
      'transactionId': transactionId,
      'sellerId': sellerId,
      'userId': userId,
      'status': status,
      'itemId': itemId,
      'reservationTime': reservationTime,
    };
  }
}
