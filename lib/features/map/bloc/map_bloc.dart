import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapInitial()) {
    on<MapTapedEvent>(mapTapedEvent);
    on<MapCurrentLocationTappedEvent>(mapCurrentLocationTappedEvent);
  }

  FutureOr<void> mapTapedEvent(MapTapedEvent event, Emitter<MapState> emit) {
    emit(MapMarkerShowState(
        marker: Marker(markerId: const MarkerId('1'), position: event.latLng)));
    emit(MapBottomSheetState(latLng:  event.latLng));
  }



  FutureOr<void> mapCurrentLocationTappedEvent(MapCurrentLocationTappedEvent event, Emitter<MapState> emit) async{
    var locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
    }
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var zoom = await event.googleMapController.getZoomLevel();
    event.googleMapController.moveCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: zoom)));
  }
}


