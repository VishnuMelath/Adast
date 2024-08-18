part of 'map_bloc.dart';

@immutable
sealed class MapEvent {}

class MapTapedEvent extends MapEvent {
  final LatLng latLng;

  MapTapedEvent({required this.latLng});
}
class MapCurrentLocationTappedEvent extends MapEvent{
  final GoogleMapController googleMapController;

  MapCurrentLocationTappedEvent({required this.googleMapController});
}

class MapSavePressedEvent extends MapEvent {
final GlobalKey<FormState> formkey;
 final String name;
 final String address;
 final LatLng latLng;
 final String? image;
 final String email;
  MapSavePressedEvent({required this.name, required this.address, required this.latLng, required this.image,required this.email,required this.formkey});
}

class MapMarkerLoadingEvent extends MapEvent{
  final List<QueryDocumentSnapshot> doc;

  MapMarkerLoadingEvent({required this.doc});

}

class MapBuildCompletedEvent extends MapEvent{}

class MapSellerSearchEvent extends MapEvent{
  final String querry;

  MapSellerSearchEvent({required this.querry});
}

class MapSearchClearEvent extends MapEvent{}

class MapImageLoadingEvent extends MapEvent{
 final Map<String,dynamic> data;
  MapImageLoadingEvent({required this.data});
}