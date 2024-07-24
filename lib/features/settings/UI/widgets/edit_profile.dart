import 'dart:developer';

import 'package:adast/custom_widgets/custom_snackbar.dart';
import 'package:adast/custom_widgets/custom_textfield.dart';
import 'package:adast/features/settings/UI/widgets/custom_save_button.dart';
import 'package:adast/features/settings/UI/widgets/image_icon/UI/image_icon.dart';
import 'package:adast/features/settings/bloc/settings_bloc.dart';
import 'package:adast/features/splash_screen/bloc/splashscreen_bloc.dart';
import 'package:adast/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'image_icon/bloc/image_icon_bloc.dart';

void editProfile(BuildContext context) {
  SettingsBloc settingsBloc = SettingsBloc();
  ImageIconBloc imageIconBloc = ImageIconBloc();
  UserModel userModel = context.read<SplashscreenBloc>().userModel!;
  TextEditingController nameController =
      TextEditingController(text: userModel.name);
  ValueNotifier<bool> loading = ValueNotifier(false);
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => BlocListener<SettingsBloc, SettingsState>(
            bloc: settingsBloc,
            listener: (context, state) {
              if (state is SettingsSaveSuccessState) {
                context.read<SplashscreenBloc>().userModel=userModel;
                customSnackBar(context, 'updated succesfully');
                Navigator.pop(context);
              } else if (state is SettingsErrorState) {
                loading.value = false;
                customSnackBar(context, state.error);
              }
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 19.0),
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: 500,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BlocProvider(
                          create: (context) => imageIconBloc,
                          child: const ImageIconWidget(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: CustomTextfield(
                              label: 'Name', controller: nameController),
                        ),
                        Row(
                          children: [
                            customSaveCancelButton(onTap: () {
                              Navigator.pop(context);
                            }, save: false),
                            customSaveCancelButton(
                                onTap: () {
                                  log(imageIconBloc.imageUrl.toString());
                                  if (nameController.text.trim().isNotEmpty) {
                                    loading.value = true;
                                    userModel.name = nameController.text;
                                    userModel.image = imageIconBloc.imageUrl;
                                    settingsBloc.add(SettingsEditUserSaveButtonPressedEvent(userModel: userModel));
                                  }
                                },
                                loading: loading),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ));
}
