
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

  Marker createMarker(DocumentSnapshot doc) {
   GeoPoint geoPoint=doc['latlng'];


 
    final location = LatLng(geoPoint.latitude, geoPoint.longitude);

    // Create a Marker with details from the document
    return Marker(
      markerId: MarkerId(doc.id),
      position: location,
      infoWindow: InfoWindow(
        title: doc['name'] as String,
        // Additional info from the document can be displayed here
      ),
    );
  }