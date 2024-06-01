part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginButtonPressedEvent extends LoginEvent{
  final TextEditingController email;
  final TextEditingController pass;
   LoginButtonPressedEvent({required this.email,required this.pass});
}

class LoginRegisterPressedEvent extends LoginEvent{}

class LoginGoogleAuthPressedEvent extends LoginEvent{}

class LoginForgotPasswordEvent extends LoginEvent{
  final TextEditingController email;
  LoginForgotPasswordEvent({required this.email});
}


