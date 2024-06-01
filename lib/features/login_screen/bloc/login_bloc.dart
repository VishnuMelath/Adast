import 'dart:async';

import 'package:adast/services/auth.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';


part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressedEvent>(loginButtonPressedEvent);
    on<LoginRegisterPressedEvent>(loginRegisterPressedEvent);
    on<LoginGoogleAuthPressedEvent>(loginGoogleAuthPressedEvent);
    on<LoginForgotPasswordEvent>(loginForgotPasswordEvent);
  }

  FutureOr<void> loginButtonPressedEvent(
      LoginButtonPressedEvent event, Emitter<LoginState> emit) async {
    if (event.email.text.isEmpty || event.pass.text.isEmpty) {
      emit(LoginEmptyFieldState());
    } else {
      await LoginService()
          .signInWithMailandPass(event.email.text, event.pass.text);
      emit(LoginNavigateToHomeState());
    }
  }

  FutureOr<void> loginRegisterPressedEvent(
      LoginRegisterPressedEvent event, Emitter<LoginState> emit) {
    emit(LoginNavigateToRegisterState());
  }

  FutureOr<void> loginGoogleAuthPressedEvent(
      LoginGoogleAuthPressedEvent event, Emitter<LoginState> emit) async {
    await LoginService().signUpWithGoogle();
    emit(LoginNavigateToHomeState());
  }

  FutureOr<void> loginForgotPasswordEvent(LoginForgotPasswordEvent event, Emitter<LoginState> emit) async{

    await LoginService().resetPassword(event.email.text);
    emit(LoginForgotPassMailSuccesfullySentState());
  }
}
