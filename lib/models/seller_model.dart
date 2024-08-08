import 'package:cloud_firestore/cloud_firestore.dart';

import '../methods/encrypt.dart';

class SellerModel {
  String? id;
  String name;
  String email;
  String? image;
  GeoPoint? latLng;
  DateTime creationTime;
  String place;
  int wallet;

  SellerModel(
      {
      this.image,
      this.id,
      required this.creationTime,
      required this.name,
      required this.email,
      required this.place,
      this.latLng,
      this.wallet = 0});

  Map<String, dynamic> toMap() {
    return {
      'emailaddress': encryptData(email),
      'image': image != null ? encryptData(image!) : null,
      'name': encryptData(name),
      'latlng': latLng,
      'place': encryptData(place),
      'wallet': wallet,
      'creationTime': Timestamp.fromDate(creationTime),
    };
  }

  factory SellerModel.fromJson(QueryDocumentSnapshot<Object?> data) {
    return SellerModel(
      id: data.id,
      place: decryptData(data['place']),
      name: decryptData(data['name']),
      email: decryptData(data['emailaddress']),
      image: data['image'] != null ? decryptData(data['image']) : 'https://firebasestorage.googleapis.com/v0/b/adast-425404.appspot.com/o/download.jpeg?alt=media&token=ea16bd9e-c9f0-47da-9d2b-050c121057ac',
      creationTime: (data['creationTime'] as Timestamp).toDate(),
      latLng: data['latlng'],
      wallet: data['wallet'] ?? 0,
    );
  }
}
