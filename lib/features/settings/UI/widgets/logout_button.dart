import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/%20themes/themes.dart';
import 'package:adast/custom_widgets/custom_snackbar.dart';
import 'package:adast/features/splash_screen/UI/splash_screen.dart';
import 'package:adast/features/splash_screen/bloc/splashscreen_bloc.dart';
import 'package:adast/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget logoutButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListTile(
        onTap: () {
          try {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  'Logout?',
                  style: blackTextStyle,
                ),
                content: const Text('Are you sure you want to logout'),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.cancel_rounded,color: red,size: 30,)),
                  IconButton(
                      onPressed: () {
                        LoginService().logout().then(
                          (value) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => SplashscreenBloc(),
                                    child: const SplashScreen(),
                                  ),
                                ),
                                (route) => false);
                          },
                        );
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.check,color: green,size: 30,)),
                ],
              ),
            );
          } on FirebaseAuthException catch (e) {
            customSnackBar(context, e.code);
          }
        },
        leading: const Icon(
          Icons.logout,
          color: red,
        ),
        title: Text(
          'Logout',
          style: mediumRedTextStyle,
        )),
  );
}
