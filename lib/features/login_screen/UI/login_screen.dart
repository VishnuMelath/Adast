import 'package:adast/%20themes/themes.dart';
import 'package:adast/custom_widgets/custom_button.dart';
import 'package:adast/custom_widgets/custom_snackbar.dart';
import 'package:adast/custom_widgets/custom_textfield.dart';
import 'package:adast/features/login_screen/bloc/login_bloc.dart';
import 'package:adast/features/register_page.dart/UI/register_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ themes/colors_shemes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc loginBloc = LoginBloc();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: BlocListener<LoginBloc, LoginState>(
            bloc: loginBloc,
            listener: (context, state) {
              if (state.runtimeType == LoginEmptyFieldState) {
               customSnackBar(context, 'email and password cannot be empty');
              }
              else if(state.runtimeType == LoginInvalidUserIdOrPassState)
              {
                customSnackBar(context, 'invalid email or password');
              }
              else if(state.runtimeType==LoginNavigateToHomeState)
              {
                //todo navigate to home
              }
              else if(state.runtimeType==LoginNavigateToRegisterState)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>const RegisterPage(),));
              }
            },
            child: ListView(
              children: [
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.height * 0.04),
                  child: Center(
                      child: Image.asset(
                    'assets/images/logo.png',
                    height: 150,
                  )),
                ),
                CustomTextfield(
                  label: 'Email Address',
                  controller: emailcontroller,
                  login: true,
                ),
                CustomTextfield(
                  label: 'Password',
                  controller: passwordController,
                  password: true,
                  login: true,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: InkWell(
                        onTap: () {
                          if (kDebugMode) {
                            print('object');
                          }
                          //todo : forgot password
                        },
                        child: const Text(
                          'forgot password?',
                          style: TextStyle(
                            color: green,
                            fontSize: 13,
                          ),
                        )),
                  ),
                ),
                
                CustomButton(
                  onTap: () {
                    loginBloc.add(LoginButtonPressedEvent(
                        email: emailcontroller, pass: passwordController));
                    //todo login button action
                  },
                  text: 'Login',
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1,
                    right: MediaQuery.of(context).size.width * 0.1,
                    bottom: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: const Row(
                    children: [
                      Expanded(child: Divider()),
                      Text('  or sign up with  '),
                      Expanded(child: Divider()),
                    ],
                  ),
                ),
                CustomButton(
                  onTap: () {
                    loginBloc.add(LoginGoogleAuthPressedEvent());
                    //todo validation google
                  },
                  text: 'Google',
                  icon: true,
                ),
                Center(
                  child: BlocListener(
                    bloc: LoginBloc(),
                    listener: (context, state) {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Don\'t have an Account?'),
                        GestureDetector(
                          onTap: () {
                            loginBloc.add(LoginRegisterPressedEvent());
                            //todo : register
                          },
                          child: const Text(
                            'Sign up here',
                            style: greenTextStyle,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
