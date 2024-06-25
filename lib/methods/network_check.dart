import 'dart:developer';
import 'dart:io';

Future<bool> hasNetwork() async {
  try {
    final result = await InternetAddress.lookup('example.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (e) {
    log(e.message);
    return false;
  }
}