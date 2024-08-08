
import 'package:adast/methods/encrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/cloth_model.dart';

class ItemDatabaseServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addItem(ClothModel item) async {
    try {
      final sellersCollection = firestore.collection('items');
      await sellersCollection.add(item.toMap());

    } on FirebaseException {
      rethrow;
    }
  }
  Future<void> updateItem(ClothModel item) async {
    try {
      final document = firestore.collection('items').doc(item.id);
      await document.update(item.toMap());
    } on FirebaseException { rethrow;
    }
  }

  Future<void> updateItemRevenue(String id,String size,int amount,[bool replace=false])async
  {
    try {
      final document = firestore.collection('items').doc(id);
      await document.update({'revenue':FieldValue.increment(replace?(amount*-1):amount),'reservedCount.$size':FieldValue.increment(replace?-1:1)});
    } on FirebaseException { rethrow;
    }
  }

  Future<void> deleteItem(String id) async
  {
    try {
      final document = firestore.collection('items').doc(id);
     await document.delete();
    } on FirebaseException { rethrow;

    }

  }

  Future<List<ClothModel>> getAllSellerItems(String email) async {
    try {
      final sellersCollection = firestore.collection('items');
      Query userQuery = sellersCollection.where('sellerID', isEqualTo: encryptData(email));
      QuerySnapshot<Object?> itemsnap = await userQuery.get();
      return itemsnap.docs.map(
        (e) {
      
          return ClothModel.fromJson(e.data() as Map<String, dynamic>,e.id);
        },
      ).toList();
    }on FirebaseException {
   
      rethrow;
    }
  }

  Future<ClothModel> getItem(String itemid)async
  {
    try {
      final snapshot=await firestore.collection('items').doc(itemid).get();
      return ClothModel.fromJson(snapshot.data()!,snapshot.id);
    }on FirebaseException catch (_) {
      rethrow;
    }
  }
Future<List<ClothModel>> getAllItems() async {
    try {
      final sellersCollection = firestore.collection('items').orderBy('date', descending: true);
      Query userQuery = sellersCollection;
      QuerySnapshot<Object?> itemsnap = await userQuery.get();
      return itemsnap.docs.map(
        (e) {
          return ClothModel.fromJson(e.data() as Map<String, dynamic>,e.id);
        },
      ).toList();
    }on FirebaseException {
      rethrow;
    }
  }

  Future<List<ClothModel>> search(String? query) async {
    try {
      final sellersCollection = firestore.collection('items').where('name',isEqualTo: encryptData(query??''));
      Query userQuery = sellersCollection;
      QuerySnapshot<Object?> itemsnap = await userQuery.get();
      return itemsnap.docs.map(
        (e) {
          return ClothModel.fromJson(e.data() as Map<String, dynamic>,e.id);
        },
      ).toList();
    }on FirebaseException {
      rethrow;
    }
  }
  Future<List<ClothModel>> getSortedList(
      {required String sortby,
      required bool descending,
      required String email}) async {
    try {
      final sellersCollection =
          firestore.collection('items').orderBy(sortby, descending: descending);
      Query userQuery = sellersCollection.where('sellerID', isEqualTo: encryptData(email));
      QuerySnapshot<Object?> itemsnap = await userQuery.get();
      return itemsnap.docs.map(
        (e) {
          return ClothModel.fromJson(e.data() as Map<String, dynamic>,e.id);
        },
      ).toList();
    }on FirebaseException  {

      rethrow;
    }
  }


//todo function  not completed
  Future<List<ClothModel>> getFilteredSortedList(
      {required String? sortby,
      required bool descending,
      required Map<String, dynamic> filters,
      required String email}) async {
    try {
      late dynamic sellersCollection;
 
      if(sortby!=null)
      {
         sellersCollection =
          firestore.collection('items').orderBy(sortby, descending: descending);

      }
      else
      {
        sellersCollection = firestore.collection('items');
      }
      late Query userQuery;
       userQuery = sellersCollection.where('sellerID', isEqualTo: email);
      QuerySnapshot<Object?> itemsnap = await userQuery.get();
      return itemsnap.docs.map(
        (e) {
          return ClothModel.fromJson(e.data() as Map<String, dynamic>,e.id);
        },
      ).toList();
    }on FirebaseException {
      rethrow;
    }
  }

Future<List<ClothModel>> getItemOfSubscribedSeller(List seller)
async{
  final query=firestore.collection('items').where('sellerID',whereIn: seller.map((e) => encryptData(e),)).orderBy('date',descending: true);
  final snaps=await query.get();
  return snaps.docs.map((e) => ClothModel.fromJson(e.data(), e.id),).toList();
}


}
