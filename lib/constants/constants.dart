import 'package:flutter/material.dart';


enum ReservationStatus {
  reserved,cancelled,
  purchased,

}

Map<String, IconData> icons = {
  'Email Address': Icons.email,
  'Password': Icons.lock_open,
  'Name': Icons.person,
  'Confirm Password': Icons.password,
  'Personal Details': Icons.person,
  'My Reservations': Icons.lock_clock,
  'Saved': Icons.bookmark,
  'Settings': Icons.settings,
  'Subscriptions':Icons.follow_the_signs
  ,'Edit profile':Icons.person,
    'Camera': Icons.camera,
  'Gallery': Icons.image,
  'Privacy policy':Icons.privacy_tip,
  'Help':Icons.help,
  'About':Icons.info_outlined
};
const String imagePath =
    'https://firebasestorage.googleapis.com/v0/b/adast-425404.appspot.com/o/profileImages%2Fbusinessman.png?alt=media&token=1245ce78-22fa-43d1-b863-bad64a8dcab4';
Map<bool, Icon> eye = {
  true: const Icon(Icons.remove_red_eye_outlined),
  false: const Icon(Icons.remove_red_eye)
};

List<String> fits=['regular','oversized','slimfit'];

List<String> sizes=['XS', 'S', 'M', 'L', 'XL','XXL'];

Map<int, String> month = {
  1: 'jan',
  2: 'feb',
  3: 'march',
  4: 'april',
  5: 'may',
  6: "june",
  7: 'july',
  8: 'aug',
  9: 'sept',
  10: 'oct',
  11: 'nov',
  12: 'dec'
};

List<String> fabric=['Chiffon','Corduroy','Cotton Blend','Cotton Lycra','Cotton Silk','Crepe','Denim','Georgette','Hemp','Linen Blend','Liva','Lycra Blend','Lyocell','Modal','Net/Lace','Nylon','PolySilk','Poly Viscose','Polycotton','Polyester','Pure Cotton','Pure Linen','Pure silk','Satin','Silk Blend','Viscose Rayon','Wool Blend'];