import 'package:flutter/material.dart';

Map<String,IconData> icons={
'Email Address':Icons.email,
'Password':Icons.lock_open,
'Name':Icons.person,
'Confirm Password':Icons.password,
'Personal Details':Icons.person,
'My Reservations':Icons.lock_clock,
'Saved':Icons.bookmark,
'Settings':Icons.settings
};

Map<bool,Icon> eye={
true:const Icon(Icons.remove_red_eye_outlined),
false:const Icon(Icons.remove_red_eye)
};