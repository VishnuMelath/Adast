import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterButtonEvent>(registerButtonEvent);
  }

  FutureOr<void> registerButtonEvent(RegisterEvent event, Emitter<RegisterState> emit) {
    //todo register user
    emit(RegisterSuccessState());
  }
}
