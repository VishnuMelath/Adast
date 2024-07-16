part of 'reservations_bloc.dart';

@immutable
sealed class ReservationsState {}

final class ReservationsInitial extends ReservationsState {}

class ReservationsLoadingState extends ReservationsState{}

class ReservationsLoadedState extends ReservationsState{}

class ReservationTileLoadingState extends ReservationsState{}

class ReservationTileLoadedState extends ReservationsState{
  final SellerModel sellerModel;
  final ClothModel clothModel;

  ReservationTileLoadedState({required this.sellerModel, required this.clothModel});
}

class ReservationsErrorState extends ReservationsState{
  final String error;

  ReservationsErrorState({required this.error});
}