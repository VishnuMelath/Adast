import 'dart:async';
import 'dart:developer';

import 'package:adast/services/auth.dart';
import 'package:adast/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterButtonEvent>(registerButtonEvent);
  }

  FutureOr<void> registerButtonEvent(RegisterButtonEvent event, Emitter<RegisterState> emit) async{
    emit(RegisterButtomPressedState());
    var user=UserModel( name: event.nameController.text, email: event.emailController.text);
    if(event.formkey.currentState!.validate())
    {
      try{
       await LoginService().signUp(user, event.passController.text);
        emit(RegisterSuccessState());
      }
      on FirebaseException catch(e)
      {
        log(e.toString());
        emit(RegisterErrorState(errormsg: e.code));
      }
    }
    emit(RegisterButtonDefaultState());

   
  }
}
