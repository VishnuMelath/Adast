
import 'package:cloud_firestore/cloud_firestore.dart';

import '../methods/encrypt.dart';
import 'reservation_model.dart';

class TransactionModel {
  String? id;
  String transactionId;
  bool withdraw;
  String sellerId;
  DateTime time;
  int amount;
  String? user;

  TransactionModel(
      {this.id,
      required this.sellerId,
      required this.transactionId,
      this.withdraw = false,
      required this.time,
      required this.amount,this.user});

  factory TransactionModel.fromReservationModel(
      ReservationModel reservationModel) {
    return TransactionModel(
        amount: reservationModel.amount,
        sellerId: reservationModel.sellerId,
        transactionId: reservationModel.transactionId,
        time: reservationModel.reservationTime
        ,user: reservationModel.userId
        );
  }
  
  factory TransactionModel.fromJson(QueryDocumentSnapshot<Object?> data) {
    return TransactionModel(
      id: data.id,
      sellerId: decryptData(data['sellerId']),
      transactionId: decryptData(data['transactionId']),
      time: (data['time'] as Timestamp).toDate(),
      amount: data['amount'],
      withdraw: data['withdraw'] ?? false,
      user: data['user'] != null ? decryptData(data['user']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sellerId': encryptData(sellerId),
      'transactionId': encryptData(transactionId),
      'time': Timestamp.fromDate(time),
      'amount': amount,
      'withdraw': withdraw,
      'user': user != null ? encryptData(user!) : null,
    };
  }
}
