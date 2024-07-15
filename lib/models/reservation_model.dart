import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationModel
{
  final String? id;
  final String transactionId;
  final String sellerId;
  final String userId;
  String status;
  final DateTime reservationTime;

  ReservationModel({required this.id, required this.transactionId, required this.sellerId, required this.userId, required this.reservationTime,required this.status});


  factory ReservationModel.fromSnapShot(QueryDocumentSnapshot<Object?> data)
  {
    return ReservationModel(id: data.id, transactionId: data['transactionId'], sellerId: data['sellerId'], userId: data['userId'], reservationTime: data['reservationTime'], status: data['status']);
  }
  Map<String,dynamic> toJson()
  {
    return
    {
      'transactionId':transactionId,
      'sellerId':sellerId,
      'userId':userId,
      'status':status,
      'reservationTime':reservationTime,
    };
  }
}