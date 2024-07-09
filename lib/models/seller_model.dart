import 'package:cloud_firestore/cloud_firestore.dart';

import 'cloth_model.dart';

class SellerModel {
  String name;
  String email;
  String? image;
  GeoPoint? latLng;
  String place;
  List<ClothModel> items;

  SellerModel(
      {this.items = const [],
      this.image,
      required this.name,
      required this.email,
      required this.place,
      this.latLng});

  Map<String, dynamic> toMap() {
    return {
      'emailaddress': email,
      'image': image,
      'name': name,
      'latlng': latLng,
      'plance': place
    };
  }

  factory SellerModel.fromJson(QueryDocumentSnapshot<Object?> data) {
    return SellerModel(
      place: data['place'],
        name: data['name'],
        email: data['emailaddress'],
        image: data['image'],
        latLng: data['latlng']);
  }
}
