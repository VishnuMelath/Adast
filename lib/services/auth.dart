import 'dart:developer';
import 'package:adast/services/user_database_services.dart';
import 'package:adast/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel> signInWithMailandPass(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      return await UserDatabaseServices().getUserData(email);
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }

  Future<UserModel> signUp(UserModel user, String password) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: user.email, password: password)
          .then((value) {});
      await UserDatabaseServices().addUser(user);
      return user;
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }

  Future<UserModel> signUpWithGoogle() async {
    try {
      await GoogleSignIn().signOut();
      log('google');

//       bool isAuthorized = gUser != null;
//       if (kIsWeb && gUser != null) {
//   isAuthorized = await GoogleSignIn().canAccessScopes([]);
// }
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId:
            '282036476767-v64qhk6hu949mobacdiqcv4qv8d3aa48.apps.googleusercontent.com',
        scopes: [
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      );
      final GoogleSignInAccount? gUser;
      late bool isAuthorized=true;
      if (kIsWeb) {
        isAuthorized=await googleSignIn.canAccessScopes(googleSignIn.scopes);
        gUser = await googleSignIn.signIn();
      log(isAuthorized.toString());
      } else {
        gUser = await GoogleSignIn().signIn();
      }
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);

      var user = await _auth.signInWithCredential(credential);
      var map = user.additionalUserInfo;
      if (user.additionalUserInfo!.isNewUser) {
        UserModel userModel = UserModel(
            email: map!.profile?['email'],
            name: map.profile?['given_name'],
            image: map.profile?['picture']);
        await UserDatabaseServices().addUser(userModel);
        return userModel;
      } else {
        return await UserDatabaseServices()
            .getUserData(user.additionalUserInfo!.profile!['email']);
      }
    } on FirebaseException catch (e) {
      log(e.code);
      rethrow;
    }
  }
}
