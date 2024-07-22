part of 'settings_bloc.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

class SettingsErrorState extends SettingsState{
  final String error;

  SettingsErrorState({required this.error});
}

class SettingsSaveSuccessState extends SettingsState{}