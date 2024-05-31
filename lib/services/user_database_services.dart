import 'dart:developer';

import 'package:adast/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices 
{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  
Future<void>  addUser(UserModel user) async
{
  try {
  final usersCollection = firestore.collection('users');
  await usersCollection.add(user.toMap());
} on Exception catch (e) {
 log(e.toString());
}
}

Future<void> getUserData(String uid) async
{
  try {
  final usersCollection=firestore.collection('users');
  Query userQuery = usersCollection.where('uid', isEqualTo: uid);
  QuerySnapshot<Object?> userSnap=await userQuery.get();
  log(userSnap.docs.first.data().toString());
} catch (e) {
  log(e.toString());
  rethrow;
}
  
}
}