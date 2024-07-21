

import 'package:adast/custom_widgets/custom_button.dart';
import 'package:adast/custom_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import '../bloc/login_bloc.dart';

Future forgotPasswordDialog(BuildContext context,
    TextEditingController controller, LoginBloc loginBloc) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Forgot Password'),
        content:
            CustomTextfield(label: 'Email Address', controller: controller),
        actions: [
          CustomButton(onTap: () {
            if(controller.text.isEmpty)
            {
            }else
            {
              loginBloc.add(LoginForgotPasswordEvent(email: controller));
            }
            
          }, text: 'Next'),
         
        ],
      );
    },
  );
}
