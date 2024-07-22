import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';


class FirebaseStorageServices {
  Future<String?> uploadImageToFirebase(File imageFile, String path) async {
    try {
      final storage = FirebaseStorage.instance;
      final filename = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final reference = storage.ref().child('$path/$filename');
      final uploadTask = reference.putFile(imageFile);

      uploadTask.snapshotEvents.listen((event) {
        final progress = event.bytesTransferred / event.totalBytes * 100;
        log('Upload progress: $progress%');
      });
      final snapshot = await uploadTask.whenComplete(() => null);
      return await snapshot.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> deleteImageFromUrl(String downloadUrl) async {
    try {
      final storageRef = getStorageReferenceFromUrl(downloadUrl);
      await storageRef.delete();
      log('Image deleted successfully!');
    } catch (error) {
      log('Error deleting image: $error');
      rethrow;
    }
  }

  Reference getStorageReferenceFromUrl(String downloadUrl) {
    final Uri uri = Uri.parse(downloadUrl);
    log(uri.path);
    var list = uri.path.split('/');
    var test = list.last;
   test= test.replaceFirst('%2F', '/');
    log(test);
    return FirebaseStorage.instance.ref().child(test);
  }
}
