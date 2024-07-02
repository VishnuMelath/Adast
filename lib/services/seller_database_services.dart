import 'dart:developer';

import 'package:adast/models/seller_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SellerDatabaseServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot> getAllSellers() async* {
    final sellersCollection = firestore.collection('sellers');
    
    yield* sellersCollection.snapshots();
  }

  Future<SellerModel> getSeller(String email) async
  {
    final query=firestore.collection('sellers').where('emailaddress',isEqualTo: email);
    final list=await query.get();
    log(list.docs.toString());
    return SellerModel.fromJson(list.docs.first);
  }
}
