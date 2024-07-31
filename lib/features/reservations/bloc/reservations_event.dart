part of 'reservations_bloc.dart';

@immutable
sealed class ReservationsEvent {}

class ReservationInitialEvent extends ReservationsEvent{
  final String email;

  ReservationInitialEvent({required this.email});
}

class ReservationsFilterSelectedEvent extends ReservationsEvent{
  final String value;

  ReservationsFilterSelectedEvent({required this.value});
}