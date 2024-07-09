import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/features/splash_screen/UI/splash_screen.dart';
import 'package:adast/features/splash_screen/bloc/splashscreen_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: (context) => SplashscreenBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark),
          colorScheme: ColorScheme.fromSeed(seedColor: green),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
