
import 'package:adast/features/splash_screen/bloc/splashscreen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bottom_nav/UI/bottom_nav.dart';
import '../../login_screen/UI/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  
  @override
  Widget build(BuildContext context) {
    final SplashscreenBloc splashscreenBloc=context.read();
    splashscreenBloc.add(SplashLoadingEvent());
    return Scaffold(
      body: BlocConsumer<SplashscreenBloc,SplashscreenState>(
        builder: (context, state) {
        switch(state.runtimeType)
          {
            case  const (SplashLoginCheckingState):return  Center(
              child: Image.asset('assets/images/logo.png'),
            );
            default:
            return const SizedBox();

          }
      } , listener: (context, state) {
        if(state.runtimeType==SplashNavigateToHomeState)
        {
          Navigator.push(context,MaterialPageRoute(builder: (context) =>const BottomNavbarScreen(),));
        }
        else if(state.runtimeType==SplashNavigatetoLoginState)
        {
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>const LoginScreen(),));
        }
      },),
    );
  }
}