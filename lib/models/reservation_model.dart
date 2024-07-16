import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationModel
{
  final String? id;
  final String transactionId;
  final String sellerId;
  final String userId;
  final String itemId;
  String status;
  final DateTime reservationTime;
  final int amount;
  final int days;


  ReservationModel({required this.id,required this.amount,required this.itemId,required this.days, required this.transactionId, required this.sellerId, required this.userId, required this.reservationTime,required this.status});


  factory ReservationModel.fromSnapShot(QueryDocumentSnapshot<Object?> data)
  {
    return ReservationModel(amount: data['amount'],days: data['days'],id: data.id,itemId: data['itemId'], transactionId: data['transactionId'], sellerId: data['sellerId'], userId: data['userId'], reservationTime: data['reservationTime'], status: data['status']);
  }
  Map<String,dynamic> toJson()
  {
    return
    {
      'amount':amount,
      'days':days,
      'transactionId':transactionId,
      'sellerId':sellerId,
      'userId':userId,
      'status':status,
      'itemId':itemId,
      'reservationTime':reservationTime,
    };
  }
}