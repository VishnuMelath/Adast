import 'dart:developer';

import 'package:adast/methods/encrypt.dart';
import 'package:adast/models/rating_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RatingDatabaseServices {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future<void> addRating(RatingModel rating) async {
    try {
      await firebaseFirestore.collection('ratings').doc('${rating.userId}${rating.sellerId}').set(rating.toJson());
    } on FirebaseException catch (e) {
      log(e.code);
      rethrow;
    }
  }

  Future<List<RatingModel>> getAllRatings(String sellerId) async {
    try {
      final query = firebaseFirestore
          .collection('ratings')
          .where('sellerId', isEqualTo: encryptData(sellerId));
      final snaps = await query.get();
      final docs = snaps.docs;
      return docs.map(
        (element) {
          return RatingModel.fromSnap(element);
        },
      ).toList();
    } on FirebaseException catch (e) {
      log(e.code);
      rethrow;
    }
  }

  Future<RatingModel?> checkReview(String userId,String sellerId) async
  {
    final query = firebaseFirestore
          .collection('ratings')
          .where('sellerId', isEqualTo: encryptData(sellerId)).where('userId',isEqualTo: encryptData(userId));
          final docs=await query.get();
          if(docs.docs.isEmpty)
          {
            return null;
          }
          return RatingModel.fromSnap(docs.docs.first);
  }
}
