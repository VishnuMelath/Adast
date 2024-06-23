part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

abstract class ProfileActionState extends ProfileState{}

class ProfileNavigateToProfileState extends ProfileActionState{}

class ProfileNavigateToReservationsState extends ProfileActionState{}

class ProfileNavigateToSavedState extends ProfileActionState{}

class ProfileNavigateToSettingsState extends ProfileActionState{}