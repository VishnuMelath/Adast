part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

class RegisterButtonEvent extends RegisterEvent{
  final GlobalKey<FormState> formkey;
  final TextEditingController nameController;
  final TextEditingController passController;
  final TextEditingController emailController;

  RegisterButtonEvent( {required this.formkey,required this.nameController, required this.passController, required this.emailController});
  
}

