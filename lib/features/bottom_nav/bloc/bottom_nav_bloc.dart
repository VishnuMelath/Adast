import 'dart:async';

import 'package:adast/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_nav_event.dart';
part 'bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  UserModel? userModel;
  BottomNavBloc() : super(BottomNavInitial()) {
    on<BottomNavInitialEvent>(bottomNavInitialEvent);
  }

  FutureOr<void> bottomNavInitialEvent(BottomNavInitialEvent event, Emitter<BottomNavState> emit) async{}
  //   emit(BottomNavUserLoadingState());
  //   userModel=await DatabaseServices().getUser();
  //   if(userModel==null) {
  //     emit(BottomNavUserLoadingErrorState());
  //   } else {
  //     emit(BottomNavUserLoadingSuccessState());
  //   }
  // }
}
