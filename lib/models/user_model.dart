import 'package:cloud_firestore/cloud_firestore.dart';

import '../methods/encrypt.dart';

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
      'emailaddress': encryptData(email),
      'image': image != null ? encryptData(image!) : null,
      'name': encryptData(name),
      'subscriptions': subscriptions.map((item) => encryptData(item.toString())).toList(),
      'saved': saved.map((item) => encryptData(item.toString())).toList(),
    };
  }

  factory UserModel.fromMap(QueryDocumentSnapshot<Object?> data) {
    return UserModel(
      id: data.id,
      email: decryptData(data['emailaddress']),
      name: decryptData(data['name']),
      image: data['image'] != null ? decryptData(data['image']) : 'https://firebasestorage.googleapis.com/v0/b/adast-425404.appspot.com/o/download.jpeg?alt=media&token=ea16bd9e-c9f0-47da-9d2b-050c121057ac',
      subscriptions: (data['subscriptions'] as List).map((item) => decryptData(item)).toList(),
      saved: (data['saved'] as List).map((item) => decryptData(item)).toList(),
    );
  }
}
