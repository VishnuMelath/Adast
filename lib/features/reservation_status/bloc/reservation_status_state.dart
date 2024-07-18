part of 'reservation_status_bloc.dart';

@immutable
sealed class ReservationStatusState {}

final class ReservationStatusInitial extends ReservationStatusState {}

class ReservationTileLoadedState extends ReservationStatusState{
}

class ReservationTileLoadingState extends ReservationStatusState{

}