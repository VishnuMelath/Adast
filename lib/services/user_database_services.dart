import 'dart:developer';

import 'package:adast/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

Future<UserModel> getUserData(String email) async
{
  try {
  final usersCollection=firestore.collection('users');
  Query userQuery = usersCollection.where('emailaddress', isEqualTo: email);
  QuerySnapshot<Object?> userSnap=await userQuery.get();
  Map<String , dynamic> userdata=userSnap.docs.first.data() as Map<String,dynamic>;
 var user= UserModel(name: userdata['name'], email: userdata['emailaddress'],image: userdata['image']);
 return user;
} catch (e) {
  log(e.toString());
  rethrow;
}
  
}

Future getUser() async
{
  try {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final user = auth.currentUser;
  
  if (user != null) {
 return await getUserData(user.email!);
  } else {
   
  return null;
  }
} on Exception catch (e) {
  log(e.toString());
}
}
}