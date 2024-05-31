part of 'register_bloc.dart';

@immutable
sealed class RegisterState {}

sealed class RegisterActionState extends RegisterState{}

final class RegisterInitial extends RegisterState {}

class RegisterErrorState extends RegisterActionState{}

class RegisterSuccessState extends RegisterActionState{}

