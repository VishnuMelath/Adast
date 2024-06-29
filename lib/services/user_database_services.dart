import 'dart:developer';

import 'package:adast/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDatabaseServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUser(UserModel user) async {
    try {
      final usersCollection = firestore.collection('users');
      await usersCollection.add(user.toMap());
    } on FirebaseException catch (e) {
      log(e.code.toString());
    }
  }

  Future<UserModel> getUserData(String email) async {
    try {
      final usersCollection = firestore.collection('users');
      Query userQuery = usersCollection.where('emailaddress', isEqualTo: email);
      QuerySnapshot<Object?> userSnap = await userQuery.get();
      log(userSnap.docs.first.toString());
      final user=UserModel.fromMap(userSnap.docs.first);
      return user;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<UserModel?> getUser() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final user = auth.currentUser;
      log(user?.email ?? 'no user');
      if (user != null) {
        return await getUserData(user.email!);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future updateUser(UserModel user) async {
    try {
      final doc = firestore.collection('users').doc(user.id);
      await doc.set(user.toMap());
    } on FirebaseException catch (e) {
      log(e.toString());
    }
  }
}
