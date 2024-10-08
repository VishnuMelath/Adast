import 'dart:async';

import 'package:adast/models/reservation_model.dart';
import 'package:adast/services/reservation_databaase_services.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'reservations_event.dart';
part 'reservations_state.dart';

class ReservationsBloc extends Bloc<ReservationsEvent, ReservationsState> {
  List<ReservationModel> reservations = [];
  String filter='All';
  ReservationsBloc() : super(ReservationsInitial()) {
    on<ReservationInitialEvent>(reservationInitialEvent);
    on<ReservationsFilterSelectedEvent>(reservationsFilterSelectedEvent);
  }

  FutureOr<void> reservationInitialEvent(
      ReservationInitialEvent event, Emitter<ReservationsState> emit) async {
    emit(ReservationsLoadingState());
    try {
     reservations= await ReservationDatabaseServices().loadReservations(event.email);
     reservations.sort((a, b) => b.reservationTime.compareTo(a.reservationTime),);
  emit(ReservationsLoadedState());
    } on FirebaseException catch (e) {
      emit(ReservationsErrorState(error: e.code));
    }
  }

  FutureOr<void> reservationsFilterSelectedEvent(ReservationsFilterSelectedEvent event, Emitter<ReservationsState> emit) {
    filter=event.value;
    emit(ReservationsLoadedState());
  }
}
