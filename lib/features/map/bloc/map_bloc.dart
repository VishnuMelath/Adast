import 'dart:async';
import 'dart:typed_data';

import 'package:adast/models/seller_model.dart';
import 'package:adast/services/seller_database_services.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../methods/data_to_markers.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  late GoogleMapController googleMapController;
  String searchQuery='';
  List<SellerModel> sellers = [];
  Set<Marker> markers = {};
  Map<String , Uint8List> images={};
  MapBloc() : super(MapInitial()) {
    on<MapTapedEvent>(mapTapedEvent);
    on<MapCurrentLocationTappedEvent>(mapCurrentLocationTappedEvent);
    on<MapMarkerLoadingEvent>(mapMarkerLoadingEvent);
    on<MapBuildCompletedEvent>(mapBuildCompletedEvent);
    on<MapSellerSearchEvent>(mapSearchEvent);
    on<MapSearchClearEvent>(mapSearchClearEvent);
    on<MapImageLoadingEvent>(mapImageLoadingEvent);
  }

  FutureOr<void> mapTapedEvent(MapTapedEvent event, Emitter<MapState> emit) {
    emit(MapMarkerShowState(
        marker: Marker(markerId: const MarkerId('1'), position: event.latLng)));
    emit(MapBottomSheetState(latLng: event.latLng));
  }

  FutureOr<void> mapCurrentLocationTappedEvent(
      MapCurrentLocationTappedEvent event, Emitter<MapState> emit) async {
    var locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
    }
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var zoom = await event.googleMapController.getZoomLevel();
    event.googleMapController.moveCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: zoom)));
  }

  FutureOr<void> mapMarkerLoadingEvent(
      MapMarkerLoadingEvent event, Emitter<MapState> emit) async {
    for (var element in event.doc) {
      try {
        final marker = await createImageMarker(element);
        markers.add(marker);
      } on Exception catch (_) {
        rethrow;
      }
    }
    emit(MapMarkerUpdatedState());
  }

  FutureOr<void> mapBuildCompletedEvent(
      MapBuildCompletedEvent event, Emitter<MapState> emit) {
    emit(MapWidgetMarkerUpdatedState());
  }

  FutureOr<void> mapSearchEvent(
      MapSellerSearchEvent event, Emitter<MapState> emit) async {
        if(searchQuery=='')
        {
          emit(MapSearchClearedState());
          return;
        }
    emit(MapSearchingState());
    sellers = await SellerDatabaseServices().getAllSellers1();
    sellers = sellers
        .where(
          (element) => element.name.contains(event.querry),
        )
        .toList();
    emit(MapSearchedState());
  }

  FutureOr<void> mapSearchClearEvent(MapSearchClearEvent event, Emitter<MapState> emit) {
    sellers.clear();
    searchQuery='';
    emit(MapSearchClearedState());
  }

  FutureOr<void> mapImageLoadingEvent(MapImageLoadingEvent event, Emitter<MapState> emit) async{
    
  }
}
