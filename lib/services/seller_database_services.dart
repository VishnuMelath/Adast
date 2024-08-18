
import 'package:adast/methods/encrypt.dart';
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
    final query=firestore.collection('sellers').where('emailaddress',isEqualTo: encryptData(email));
    final list=await query.get();

    return SellerModel.fromJson(list.docs.first);
  }

  Future<List<SellerModel>> getAllSellers1() async
  {
    final sellersCollection = firestore.collection('sellers');
    final list=await sellersCollection.get();
    return list.docs.map((e) => SellerModel.fromJson(e),).toList();
  }

  Future updateSellerWallet(int amount,String sellerId)
  async 
  {
    final query=firestore.collection('sellers').where('emailaddress',isEqualTo: encryptData(sellerId));
    final list=await query.get();
    await firestore.collection('sellers').doc(list.docs.first.id).update({'wallet':FieldValue.increment(amount)});
  }
}
