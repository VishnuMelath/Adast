import 'dart:async';

import 'package:adast/services/auth.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
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
        emit(LoginButtonPressedState());
    if (event.email.text.isEmpty || event.pass.text.isEmpty) {
      emit(LoginEmptyFieldState());
    } else {
      try {
        await LoginService()
            .signInWithMailandPass(event.email.text, event.pass.text);
        emit(LoginNavigateToHomeState());
      } on FirebaseException catch (e) {
        emit(LoginInvalidUserIdOrPassState(errormsg: e.code));
      }
    }
  }

  FutureOr<void> loginRegisterPressedEvent(
      LoginRegisterPressedEvent event, Emitter<LoginState> emit) {
    emit(LoginNavigateToRegisterState());
  }

  FutureOr<void> loginGoogleAuthPressedEvent(
      LoginGoogleAuthPressedEvent event, Emitter<LoginState> emit) async {
    try {
      await LoginService().signUpWithGoogle();
      emit(LoginNavigateToHomeState());
    } on FirebaseException catch (e) {
      emit(LoginInvalidUserIdOrPassState(errormsg: e.code));
    }
  }

  FutureOr<void> loginForgotPasswordEvent(
      LoginForgotPasswordEvent event, Emitter<LoginState> emit) async {
    try {
      await LoginService().resetPassword(event.email.text);
      emit(LoginForgotPassMailSuccesfullySentState());
    } on FirebaseException catch (e) {
     emit(LoginInvalidUserIdOrPassState(errormsg: e.code));
    }
  }
}
