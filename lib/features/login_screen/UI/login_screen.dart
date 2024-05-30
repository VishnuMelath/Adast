import 'package:adast/%20themes/themes.dart';
import 'package:adast/custom_widgets/custom_button.dart';
import 'package:adast/custom_widgets/custom_textfield.dart';
import 'package:adast/features/login_screen/bloc/login_bloc.dart';
import 'package:flutter/cupertino.dart';
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
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
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
                icon: 'email',
                label: 'Email Address',
                controller: emailcontroller,
                login: true,
              ),
              CustomTextfield(
                icon: 'lock',
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              CustomButton(
                onTap: () {
                  //todo validation
                },
                text: 'Login',
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.03,
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
                  //todo validation
                },
                text: 'Google',
                icon: true,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                  child: BlocListener(
                    bloc: LoginBloc(),
                    listener: (context, state) {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Don\'t have an Account?'),
                        GestureDetector(
                          onTap: () {
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
