import 'package:cloud_firestore/cloud_firestore.dart';

class RatingModel {
  final String? id;
  final double rating;
  final String comments;
  final DateTime time;
  final String sellerId;
  final String userId;

  RatingModel(
      { this.id,
      required this.rating,
      required this.comments,
      required this.time,
      required this.sellerId,
      required this.userId});

  factory RatingModel.fromSnap(QueryDocumentSnapshot<Object?> data) {
    return RatingModel(
        id: data.id,
        rating: data['rating'],
        comments: data['comments'],
        time: data['time'].toDate(),
        sellerId: data['sellerId'],
        userId: data['userId']);
  }

 Map<String,dynamic> toJson()
 {
  return {
    'rating':rating,
    'comments':comments,
    'time':Timestamp.fromDate(time),
    'sellerId':sellerId,
    'userId':userId
  };
 }
}
