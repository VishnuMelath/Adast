import 'package:adast/models/cloth_model.dart';
import 'package:adast/models/reservation_model.dart';
import 'package:adast/models/seller_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'reservation_status_event.dart';
part 'reservation_status_state.dart';

class ReservationStatusBloc extends Bloc<ReservationStatusEvent, ReservationStatusState> {
  late SellerModel sellerModel;
  ReservationModel reservationModel;
  ClothModel? clothModel;
  ReservationStatusBloc({required this.reservationModel}) : super(ReservationStatusInitial()) {
    on<ReservationStatusEvent>((event, emit) {
    });
  }
}
