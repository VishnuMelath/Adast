part of 'reservations_bloc.dart';

@immutable
sealed class ReservationsState {}

final class ReservationsInitial extends ReservationsState {}

class ReservationsLoadingState extends ReservationsState{}

class ReservationsLoadedState extends ReservationsState{}


class ReservationsErrorState extends ReservationsState{
  final String error;

  ReservationsErrorState({required this.error});
}