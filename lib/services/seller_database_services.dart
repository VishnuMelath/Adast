
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

    return SellerModel.fromJson(list.docs.first);
  }

  Future<List<SellerModel>> getAllSellers1() async
  {
    final sellersCollection = firestore.collection('sellers');
    final list=await sellersCollection.get();
    return list.docs.map((e) => SellerModel.fromJson(e),).toList();
  }
}
