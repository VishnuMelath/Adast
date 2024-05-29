part of 'splashscreen_bloc.dart';

@immutable
sealed class SplashscreenState {}


sealed class SplashscreenActionState extends SplashscreenState{}

final class SplashscreenInitial extends SplashscreenState {}

class SplashLoginCheckingState extends SplashscreenState{}
class SplashLoginCheckingErrorState extends SplashscreenState{}
class SplashLoginCheckingSuccessState extends SplashscreenState{}

class SplashNavigatetoLoginState extends SplashscreenActionState{}
class SplashNavigateToHomeState extends SplashscreenActionState{}


