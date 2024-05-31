import 'dart:developer';
import 'package:adast/services/user_database_services.dart';
import 'package:adast/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithMailandPass(String email, String password) async {
    try {
      var user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      await DatabaseServices().getUserData(user.user!.uid);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<UserModel> signUp(UserModel user, String password) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: user.email, password: password)
          .then((value) {
        user.uid = value.user!.uid;
        log(value.user!.photoURL ?? '');
      });
      await DatabaseServices().addUser(user);
      return user;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> signUpWithGoogle() async {
    try {
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);

     var user= await _auth.signInWithCredential(credential);
     var map=user.additionalUserInfo;
     UserModel userModel=UserModel(email:map!.profile?['email'],name: map.profile?['given_name'],image: map.profile?['picture'] ,uid: credential.idToken);
     log(user.credential.toString());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
