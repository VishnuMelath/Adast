import 'package:cloud_firestore/cloud_firestore.dart';

class SellerDatabaseServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot> getAllSellers() async* {
    final sellersCollection = firestore.collection('sellers');
    
    yield* sellersCollection.snapshots();
  }
}
