import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Marker createMarker(DocumentSnapshot doc) {
  GeoPoint geoPoint = doc['latlng'];

  final location = LatLng(geoPoint.latitude, geoPoint.longitude);
  
return Marker(
    markerId: MarkerId(doc.id),
    icon: BitmapDescriptor.defaultMarkerWithHue(1),
    position: location,
    onTap: () {},
    infoWindow: InfoWindow(
      title: doc['name'] as String,
    ),
  );
}
Future<Marker> createImageMarker(DocumentSnapshot doc) async{
  GeoPoint geoPoint = doc['latlng'];

  final location = LatLng(geoPoint.latitude, geoPoint.longitude);
  final icon=await getMarkerIcon(doc['image']);
return Marker(
    markerId: MarkerId(doc.id),
    icon: icon,
    position: location,
    onTap: () {},
    infoWindow: InfoWindow(
      title: doc['name'] as String,
    ),
  );
}
Future<BitmapDescriptor> getMarkerIcon(String imageUrl) async {
   int targetWidth = 60;
  final File markerImageFile =
      await DefaultCacheManager().getSingleFile(imageUrl);
  final Uint8List markerImageBytes = await markerImageFile.readAsBytes();
  final Codec markerImageCodec = await instantiateImageCodec(
    markerImageBytes,
    targetWidth: targetWidth,
  );
  final FrameInfo frameInfo = await markerImageCodec.getNextFrame();
  final ByteData? byteData = await frameInfo.image.toByteData(
    format: ImageByteFormat.png,
  );
  final Uint8List resizedMarkerImageBytes = byteData!.buffer.asUint8List();
  return BitmapDescriptor.bytes(resizedMarkerImageBytes,height: 40);
}
