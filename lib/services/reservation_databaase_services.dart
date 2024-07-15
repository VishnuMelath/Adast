import 'dart:developer';

import 'package:adast/models/reservation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationDatabaseServices {
  FirebaseFirestore firebaseInstance = FirebaseFirestore.instance;
  void addReservation(ReservationModel reservation) async {
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
          .doc(reservation.id).set(reservation.toJson());
    } on FirebaseException catch (e) {
      log(e.code);
      rethrow;
    }
  }
}
