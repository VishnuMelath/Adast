import 'dart:async';

import 'package:adast/services/auth.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressedEvent>(loginButtonPressedEvent);
    on<LoginRegisterPressedEvent>(loginRegisterPressedEvent);
    on<LoginGoogleAuthPressedEvent>(loginGoogleAuthPressedEvent);
  }

  FutureOr<void> loginButtonPressedEvent(LoginButtonPressedEvent event, Emitter<LoginState> emit) {
    if(event.email.text.isEmpty||event.pass.text.isEmpty)
    {
      emit(LoginEmptyFieldState());
    }
    else{
      LoginService().signInWithMailandPass(event.email.text, event.pass.text);
    }
    
  }

  FutureOr<void> loginRegisterPressedEvent(LoginRegisterPressedEvent event, Emitter<LoginState> emit) {
    emit(LoginNavigateToRegisterState());
  }

  FutureOr<void> loginGoogleAuthPressedEvent(LoginGoogleAuthPressedEvent event, Emitter<LoginState> emit) async{

   await LoginService().signUpWithGoogle();
  emit(LoginGoogleAuthenticationState());
  }
}
