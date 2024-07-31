import 'package:cloud_firestore/cloud_firestore.dart';

import 'cloth_model.dart';

class SellerModel {
  String? id;
  String name;
  String email;
  String? image;
  GeoPoint? latLng;
  String place;
  List<ClothModel> items;
  int wallet;

  SellerModel(
      {
        this.id,
        this.items = const [],
      this.image,
      required this.name,
      required this.email,
      required this.place,
      this.latLng,
      this.wallet = 0});

  Map<String, dynamic> toMap() {
    return {
      'emailaddress': email,
      'image': image,
      'name': name,
      'latlng': latLng,
      'plance': place,
      'wallet': wallet
    };
  }

  factory SellerModel.fromJson(QueryDocumentSnapshot<Object?> data) {
    return SellerModel(
      id: data.id,
        place: data['place'],
        name: data['name'],
        email: data['emailaddress'],
        image: data['image'],
        latLng: data['latlng'],
        wallet: data['wallet'] ?? 0);
  }
}
