import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String name;
  String email;
  String? image;
  List subscriptions;
  List saved;

  UserModel(
      {this.image,
      this.id,
      required this.name,
      required this.email,
      this.subscriptions = const [],
      this.saved=const[]});

  Map<String, dynamic> toMap() {
    return {
      'emailaddress': email,
      'image': image,
      'name': name,
      'subscriptions':subscriptions,
      'saved':saved
    };
  }

  factory UserModel.fromMap(QueryDocumentSnapshot<Object?> data) {
    return UserModel(
      id: data.id,
      email: data['emailaddress'],name: data['name'],image: data['image'],saved: data['saved'],subscriptions: data['subscriptions']);
  }
}
