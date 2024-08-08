
import 'package:adast/constants/constants.dart';
import 'package:adast/methods/encrypt.dart';
import 'package:adast/models/reservation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationDatabaseServices {
  FirebaseFirestore firebaseInstance = FirebaseFirestore.instance;
  Future addReservation(ReservationModel reservation) async {
    try {
      await firebaseInstance
          .collection('reservations')
          .add(reservation.toJson());
    } on FirebaseException {
      rethrow;
    }
  }

  Future updateReservation(ReservationModel reservation) async {
    try {
      await firebaseInstance
          .collection('reservations')
          .doc(reservation.id)
          .set(reservation.toJson());
    } on FirebaseException {
      rethrow;
    }
  }

  Future<List<ReservationModel>> loadReservations(String userId) async {
    try {
      final snapshots = await firebaseInstance
          .collection('reservations')
          .where('userId', isEqualTo: encryptData(userId))
          .get();
      return snapshots.docs
          .map(
            (e) => ReservationModel.fromSnapShot(e),
          )
          .toList();
    } on FirebaseException {
 
      rethrow;
    }
  }
  Future<bool> checkPurchased(String sellerId,String userId) async
{
final query=firebaseInstance.collection('reservations').where('sellerId',isEqualTo: encryptData(sellerId)).where('userId',isEqualTo: encryptData(userId)).where('status',isEqualTo: encryptData(ReservationStatus.purchased.name));
final data=await query.get();
return data.docs.isNotEmpty;
}
}
