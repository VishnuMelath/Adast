import 'dart:async';

import 'package:adast/models/user_model.dart';
import 'package:adast/services/user_database_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splashscreen_event.dart';
part 'splashscreen_state.dart';

class SplashscreenBloc extends Bloc<SplashscreenEvent, SplashscreenState> {
  UserModel? userModel;
  SplashscreenBloc() : super(SplashscreenInitial()) {
    on<SplashLoadingEvent>(splashLoadingEvent);
  }

  FutureOr<void> splashLoadingEvent(
    
      SplashLoadingEvent event, Emitter<SplashscreenState> emit) async{
    emit(SplashLoginCheckingState());

    //todo -check wheather the user already logged in or not
   await Future.delayed(
      const Duration(seconds: 2),
      () async{
        userModel=await UserDatabaseServices().getUser();
      },
    );
      if (userModel==null) {
          emit(SplashNavigatetoLoginState());
        } 
        else {
          emit(SplashNavigateToHomeState());
        }

  }
}
