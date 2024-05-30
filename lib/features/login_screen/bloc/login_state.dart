part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

sealed class LoginActionState extends LoginState{}

final class LoginInitial extends LoginState {}

 class LoginNavigateToHomeState extends LoginActionState{}

 class LoginNavigateToRegisterState extends LoginActionState{}

 class LoginInvalidUserIdOrPassState extends LoginActionState{}

 class LoginGoogleAuthenticationState extends LoginActionState{}


