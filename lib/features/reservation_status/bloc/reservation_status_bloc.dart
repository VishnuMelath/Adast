import 'dart:async';

import 'package:adast/models/cloth_model.dart';
import 'package:adast/models/reservation_model.dart';
import 'package:adast/models/seller_model.dart';
import 'package:adast/services/item_database_services.dart';
import 'package:adast/services/seller_database_services.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'reservation_status_event.dart';
part 'reservation_status_state.dart';

class ReservationStatusBloc
    extends Bloc<ReservationStatusEvent, ReservationStatusState> {
  SellerModel? sellerModel;
  ReservationModel reservationModel;
  ClothModel? clothModel;
  ReservationStatusBloc({required this.reservationModel})
      : super(ReservationStatusInitial()) {
    on<ReservationTileLoadingEvent>(reservationTileLoadingEvent);
    on<ReservationRelodEvent>(reservationReloadEvent);
  }

  FutureOr<void> reservationTileLoadingEvent(ReservationTileLoadingEvent event,
      Emitter<ReservationStatusState> emit) async {
    emit(ReservationTileLoadingState());
    try {
      sellerModel = await SellerDatabaseServices().getSeller(event.sellerId);

      clothModel =
          await ItemDatabaseServices().getItem(reservationModel.itemId);
      emit(ReservationTileLoadedState());
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  FutureOr<void> reservationReloadEvent(
      ReservationRelodEvent event, Emitter<ReservationStatusState> emit) {
    emit(ReservationTileLoadedState());
  }
}
