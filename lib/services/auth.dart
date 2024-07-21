import 'package:adast/services/user_database_services.dart';
import 'package:adast/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithMailandPass(String email, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await UserDatabaseServices().getUserData(email);
      });
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }
  

  Future<UserModel> signUp(UserModel user, String password) async {
    try {      
      await _auth
          .createUserWithEmailAndPassword(email: user.email, password: password)
          .then((value) {
      });
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

  Future<void> signUpWithGoogle() async {
    try {
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
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
      }
    } catch (e) {

      rethrow;
    }
  }
}
