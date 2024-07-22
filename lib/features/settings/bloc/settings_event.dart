part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}

class SettingsEditUserSaveButtonPressedEvent extends SettingsEvent{
  final UserModel userModel;

  SettingsEditUserSaveButtonPressedEvent({required this.userModel});
}