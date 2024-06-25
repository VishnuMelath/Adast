
import 'package:cloud_firestore/cloud_firestore.dart';

import 'cloth_model.dart';


class SellerModel {
   String name;
   String email;
   String? image;
   GeoPoint? latLng;
   List<ClothModel> items;

  SellerModel(
      {this.items = const[],
      this.image,
      required this.name,
      required this.email,
      this.latLng});

  Map<String, dynamic> toMap() {
    return {
      'emailaddress': email,
      'image': image,
      'name': name,
      'latlng':latLng,
      // 'items':items
    };
  }
 factory SellerModel.fromJson(QueryDocumentSnapshot<Object?> data)
  {
    return SellerModel(name: data['name'], email: data['emailaddress'],image: data['image'],latLng: data['latlng']);
  }
}
