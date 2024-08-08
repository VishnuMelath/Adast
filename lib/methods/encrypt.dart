import 'dart:developer';

import 'package:encrypt/encrypt.dart' as encrypt;


final key = encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows1');

final iv = encrypt.IV.fromUtf8('16charIVstring!!');

final encrypter = encrypt.Encrypter(encrypt.AES(key));

String encryptData(String plainText) {
   try {
  final encrypted = encrypter.encrypt(plainText,iv: iv);
  return encrypted.base64;
} on Exception catch (e) {
  
  log(e.toString());
  rethrow;
  
}
}

String decryptData(String? encryptedText) { if(encryptedText==''||encryptedText==null)
  {
    return '';
  }
  final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
  return decrypted;
}
