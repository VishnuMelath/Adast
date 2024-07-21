import 'package:adast/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDatabaseServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUser(UserModel user) async {
    try {
      final usersCollection = firestore.collection('users');
      await usersCollection.add(user.toMap());
    } on FirebaseException {
      rethrow;
    }
  }

  Future<UserModel> getUserData(String email) async {
    try {
      final usersCollection = firestore.collection('users');
      Query userQuery = usersCollection.where('emailaddress', isEqualTo: email);
      QuerySnapshot<Object?> userSnap = await userQuery.get();

      final user = UserModel.fromMap(userSnap.docs.first);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> getUser() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final user = auth.currentUser;

      if (user != null) {
        return await getUserData(user.email!);
      } else {
        return null;
      }
    } on Exception {
      return null;
    }
  }

  Future updateUser(UserModel user) async {
    try {
      final doc = firestore.collection('users').doc(user.id);
      await doc.set(user.toMap());
    } on FirebaseException {
      rethrow;
    }
  }
}
