import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splashscreen_event.dart';
part 'splashscreen_state.dart';

class SplashscreenBloc extends Bloc<SplashscreenEvent, SplashscreenState> {
  SplashscreenBloc() : super(SplashscreenInitial()) {
    on<SplashLoadingEvent>(splashLoadingEvent);
  }

  FutureOr<void> splashLoadingEvent(
    
      SplashLoadingEvent event, Emitter<SplashscreenState> emit) async{bool test=false;
    emit(SplashLoginCheckingState());

    //todo -check wheather the user already logged in or not
   await Future.delayed(
      const Duration(seconds: 3),
      () {
         test = true;
      },
    );
      if (test) {
          emit(SplashNavigatetoLoginState());
        } 
        // else {
        //   emit(SplashNavigateToHomeState());
        // }

  }
}
