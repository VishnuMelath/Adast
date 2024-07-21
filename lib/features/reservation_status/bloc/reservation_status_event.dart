part of 'reservation_status_bloc.dart';

@immutable
sealed class ReservationStatusEvent {}

class ReservationTileLoadingEvent extends ReservationStatusEvent{
  final String itemId;
  final String sellerId;

  ReservationTileLoadingEvent({required this.itemId, required this.sellerId});
}

class ReservationRelodEvent extends ReservationStatusEvent{}