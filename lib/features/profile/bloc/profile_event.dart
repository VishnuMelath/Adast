part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class ProfilesNavigateToProfileEvent extends ProfileEvent{}

class ProfileNavigateToReservationEvent extends ProfileEvent{}

class ProfileNavigateToSavedEvent extends ProfileEvent{}

class ProfileNavigateToSettingsEvent extends ProfileEvent{}