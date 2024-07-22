import 'dart:async';

import 'package:adast/models/user_model.dart';
import 'package:adast/services/user_database_services.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<SettingsEditUserSaveButtonPressedEvent>(
        settingsEditUserSaveButtonPressedEvent);
  }

  FutureOr<void> settingsEditUserSaveButtonPressedEvent(
      SettingsEditUserSaveButtonPressedEvent event,
      Emitter<SettingsState> emit) async {
        try{
          await UserDatabaseServices().updateUser(event.userModel);
          emit(SettingsSaveSuccessState());
        }
        on FirebaseException catch (e)
        {
          emit(SettingsErrorState(error:e.code));
        }
      }
}
