import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfilesNavigateToProfileEvent>(profileNavigateToProfileEvent);
    on<ProfileNavigateToReservationEvent>(profileNavigateToReservationEvent);
     on<ProfileNavigateToSavedEvent>(profileNavigateToSavedEvent);
     on<ProfileNavigateToSettingsEvent>(profileNavigateToSettingsEvent);
  }

  FutureOr<void> profileNavigateToProfileEvent(ProfilesNavigateToProfileEvent event, Emitter<ProfileState> emit) {
  emit(ProfileNavigateToProfileState());
  }

  FutureOr<void> profileNavigateToReservationEvent(ProfileNavigateToReservationEvent event, Emitter<ProfileState> emit) {
  emit(ProfileNavigateToReservationsState());
  }

  FutureOr<void> profileNavigateToSavedEvent(ProfileNavigateToSavedEvent event, Emitter<ProfileState> emit) {
  emit(ProfileNavigateToSavedState());
  }
  FutureOr<void> profileNavigateToSettingsEvent(ProfileNavigateToSettingsEvent event, Emitter<ProfileState> emit) {
  emit(ProfileNavigateToSavedState());
  }
}
