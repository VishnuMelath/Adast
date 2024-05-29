 import 'package:adast/features/splashscreen/bloc/splashscreen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashscreenBloc splashscreenBloc=SplashscreenBloc();
  @override
  void initState() {
    splashscreenBloc.add(SplashLoadingEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SplashscreenBloc,SplashscreenState>(
        bloc: splashscreenBloc,
        builder: (context, state) {
        switch(state.runtimeType)
          {
            case const (SplashLoginCheckingState):return  Center(
              child: Image.asset('assets/images/logo.png'),
            );
            default:
            return const SizedBox();

          }
      } , listener: (context, state) {
        if(state.runtimeType==SplashNavigateToHomeState)
        {
          // Navigator.push(context,MaterialPageRoute(builder: (context) =>const HomeScreen(),));
        }
        else if(state.runtimeType==SplashNavigatetoLoginState)
        {
          // Navigator.push(context,MaterialPageRoute(builder: (context) =>const LoginScreen(),));
        }
      },),
    );
  }
}