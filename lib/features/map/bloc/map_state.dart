part of 'map_bloc.dart';

@immutable
sealed class MapState {}

final class MapInitial extends MapState {}

abstract class MapActionState extends MapState{}

class MapBottomSheetState extends MapState{
  final LatLng latLng;

  MapBottomSheetState({required this.latLng});
}

class MapMarkerShowState extends MapActionState{
  final Marker marker;

  MapMarkerShowState({required this.marker});

}



class MapSaveErrorState extends MapState{
 final String error;

  MapSaveErrorState({required this.error});
}

class MapFormImageNotAddedState extends MapActionState{}


