part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginButtonPressedEvent extends LoginEvent{}

class LoginRegisterPressedEvent extends LoginEvent{}

class LoginGoogleAuthPressedEvent extends LoginEvent{}


