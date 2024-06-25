import 'dart:typed_data';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

 
  Future<Marker> generateMarkersFromWidget(Map<String, dynamic> data,void Function()? onTap) async {
    try {
  RenderRepaintBoundary boundary = data['globalKey']
      .currentContext
      .findRenderObject() as RenderRepaintBoundary;
  var image = await boundary.toImage();
  GeoPoint geoPoint=data['data']['latlng'];

  ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
  return Marker(
    flat: true,
    onTap: onTap,
      markerId: MarkerId(data['data']['emailaddress']),
      position: LatLng(geoPoint.latitude,geoPoint.longitude),
      icon: BitmapDescriptor.bytes(byteData!.buffer.asUint8List()));
} on Exception  {
  rethrow;
}
  }