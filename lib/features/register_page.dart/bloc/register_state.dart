part of 'register_bloc.dart';

@immutable
sealed class RegisterState {}

sealed class RegisterActionState extends RegisterState{}

final class RegisterInitial extends RegisterState {}

class RegisterButtomPressedState extends RegisterState{}

class RegisterButtonDefaultState extends RegisterState{}

class RegisterErrorState extends RegisterActionState{
  final String errormsg;
  RegisterErrorState({required this.errormsg});

}

class RegisterSuccessState extends RegisterActionState{}

