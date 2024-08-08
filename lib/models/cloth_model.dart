import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../methods/encrypt.dart';

class ClothModel {
  String? id;
  String sellerID;
  String name;
  String description;
  String category;
  String fit;
  DateTime date;
  Map<String, dynamic> size;
  List images;
  Map<String, dynamic> reservedCount;
  Map<String, dynamic> reservableCount;
  Map<String, dynamic> soldCount;
  String brand;
  String material;
  int price;
  String tags;
  String metaTitle;
  String metaDescription;
  int revenue;

  ClothModel({
    this.id,
    required this.reservableCount,
    required this.date,
    required this.sellerID,
    required this.name,
    required this.description,
    required this.category,
    required this.fit,
    required this.size,
    required this.images,
    this.reservedCount = const {},
    this.soldCount = const {},
    required this.brand,
    required this.material,
    required this.price,
    required this.tags,
    required this.metaTitle,
    required this.metaDescription,
    required this.revenue,
  });

  Map<String, dynamic> toMap() {
    return {
      'sellerID': encryptData(sellerID),
      'name': encryptData(name),
      'description': encryptData(description),
      'category': encryptData(category),
      'fit': encryptData(fit),
      'size': size,
      'images': images.map((image) => encryptData(image.toString())).toList(),
      'reservedCount': reservedCount,
      'reservableCount': reservableCount,
      'soldCount': soldCount,
      'brand': encryptData(brand),
      'material': encryptData(material),
      'price': price,
      'tags': encryptData(tags),
      'metaTitle': encryptData(metaTitle),
      'metaDescription': encryptData(metaDescription),
      'date': Timestamp.fromDate(date),
      'revenue': revenue,
    };
  }

factory ClothModel.fromJson(Map<String, dynamic> map, String id) {
    log(map['size'].toString());
    return ClothModel(
      id: id,
      sellerID: decryptData(map['sellerID']),
      name: decryptData(map['name']),
      brand: decryptData(map['brand']),
      date: (map['date'] as Timestamp).toDate(),
      reservableCount: map['reservableCount'],
      category: decryptData(map['category']),
      description: decryptData(map['description']),
      fit: decryptData(map['fit']),
      images: map['images'].map((image) => decryptData(image)).toList(),
      material: decryptData(map['material']),
      metaDescription: decryptData(map['metaDescription']),
      metaTitle: decryptData(map['metaTitle']),
      price: map['price'],
      size: map['size'],
      tags: decryptData(map['tags']),
      reservedCount: map['reservedCount'],
      soldCount: map['soldCount'],
      revenue: map.containsKey('revenue') ? map['revenue'] : 0,
    );
  }
}
