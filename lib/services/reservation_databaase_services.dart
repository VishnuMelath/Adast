import 'dart:developer';

import 'package:adast/models/reservation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationDatabaseServices {
  FirebaseFirestore firebaseInstance = FirebaseFirestore.instance;
  Future addReservation(ReservationModel reservation) async {
    try {
      await firebaseInstance
          .collection('reservations')
          .add(reservation.toJson());
    } on FirebaseException catch (e) {
      log(e.code);
      rethrow;
    }
  }

  void updateReservation(ReservationModel reservation) async {
    try {
      await firebaseInstance
          .collection('reservations')
          .doc(reservation.id)
          .set(reservation.toJson());
    } on FirebaseException catch (e) {
      log(e.code);
      rethrow;
    }
  }

  Future<List<ReservationModel>> loadReservations(String userId) async {
    try {
      final snapshots = await firebaseInstance
          .collection('reservations')
          .where('userId', isEqualTo: userId)
          .get();
      return snapshots.docs
          .map(
            (e) => ReservationModel.fromSnapShot(e),
          )
          .toList();
    } on FirebaseException catch (e) {
      log(e.code);
      rethrow;
    }
  }
}
