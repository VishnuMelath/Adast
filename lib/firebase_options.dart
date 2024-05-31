// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBBmO-1UekWsoO9KqO4vCET_kbYrI8-xk0',
    appId: '1:888534327765:web:2579a3892f57b587e01d5c',
    messagingSenderId: '888534327765',
    projectId: 'adast-53666',
    authDomain: 'adast-53666.firebaseapp.com',
    storageBucket: 'adast-53666.appspot.com',
    measurementId: 'G-VDGXKZ0RPP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCFRzhTQ4RaXtB_XTZ_xCUz2YQAU7KczIE',
    appId: '1:888534327765:android:ef2b698efd062dece01d5c',
    messagingSenderId: '888534327765',
    projectId: 'adast-53666',
    storageBucket: 'adast-53666.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCHxkBWUp2YRqyXDUYRV5OXDKkJJTyLfrk',
    appId: '1:888534327765:ios:beb1dc3bad9dea74e01d5c',
    messagingSenderId: '888534327765',
    projectId: 'adast-53666',
    storageBucket: 'adast-53666.appspot.com',
    iosBundleId: 'com.example.adast',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCHxkBWUp2YRqyXDUYRV5OXDKkJJTyLfrk',
    appId: '1:888534327765:ios:beb1dc3bad9dea74e01d5c',
    messagingSenderId: '888534327765',
    projectId: 'adast-53666',
    storageBucket: 'adast-53666.appspot.com',
    iosBundleId: 'com.example.adast',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBBmO-1UekWsoO9KqO4vCET_kbYrI8-xk0',
    appId: '1:888534327765:web:a6193a33e13bef90e01d5c',
    messagingSenderId: '888534327765',
    projectId: 'adast-53666',
    authDomain: 'adast-53666.firebaseapp.com',
    storageBucket: 'adast-53666.appspot.com',
    measurementId: 'G-XV4V85L74V',
  );
}
