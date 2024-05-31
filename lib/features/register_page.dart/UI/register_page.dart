import 'package:adast/%20themes/themes.dart';
import 'package:adast/custom_widgets/custom_button.dart';
import 'package:adast/custom_widgets/custom_textfield.dart';
import 'package:adast/features/bottom_nav/UI/bottom_nav.dart';
import 'package:adast/features/register_page.dart/bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterBloc registerBloc = RegisterBloc();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'REGISTER',
          style: greenTextStyle,
        ),
      ),
      body: Form(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: BlocListener<RegisterBloc, RegisterState>(
      bloc: registerBloc,
          listener: (context, state) {
            if(state.runtimeType==RegisterSuccessState)
            {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>const BottomNavbarScreen(),), (route) => false,);
            }
            // TODO: implement listener
          },
          child: ListView(
            children: [
              CustomTextfield(
                label: 'Email Address',
                controller: emailController,
                login: false,
              ),
              CustomTextfield(
                  label: 'Name', controller: nameController, login: false),
              CustomTextfield(
                label: 'Password',
                controller: passwordController,
                login: false,
                password: true,
              ),
              CustomTextfield(
                label: 'Confirm Password',
                controller: rePasswordController,
                login: false,
                password: true,
              ),
              CustomButton(onTap: () {
                registerBloc.add(RegisterButtonEvent());
              }, text: 'Submit')
            ],
          ),
        ),
      )),
    );
  }
}
