
import 'package:adast/features/map/methods/data_to_markers.dart';
import 'package:adast/services/seller_database_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../ themes/colors_shemes.dart';
import '../../../custom_widgets/custom_snackbar.dart';
import '../bloc/map_bloc.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GlobalKey<FormState> formkey = GlobalKey();
  final Set<Marker> markers = {};
  LatLng center = const LatLng(11.2588, 75.7804);
  late GoogleMapController mapController;
  MapBloc mapBloc = MapBloc();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  late Stream<QuerySnapshot> _locationsStream;
@override
  void initState() {
    _locationsStream=SellerDatabaseServices().getAllSellers();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: greentransparent,
      child: SafeArea(
        child: Scaffold(
          // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          floatingActionButton: FloatingActionButton(
            backgroundColor: green,
            child: const Icon(
              Icons.my_location_sharp,
              color: white,
            ),
            onPressed: () {
              mapBloc.add(MapCurrentLocationTappedEvent(
                  googleMapController: mapController));
            },
          ),
          body: BlocConsumer<MapBloc, MapState>(
            bloc: mapBloc,
            listener: (context, state) {
              if (state is MapSaveErrorState) {
                customSnackBar(context, state.error);
              }
        
              if (state is MapBottomSheetState) {}
            },
            builder: (context, state) {
              return StreamBuilder<QuerySnapshot> (
                  stream: _locationsStream,
                  builder: (context, snapshot) {
                    
                    if (snapshot.hasError) {
                      
                    }
        
                    if (!snapshot.hasData) {
                    //  dataToMarker(snapshot, markers);
                    }
                    final locations = snapshot.data?.docs;
                    final markers = locations?.map((doc) => createMarker(doc)).toSet();
                    return GoogleMap(
                      markers: markers??{},
                      onTap: (latlng) {},
                      mapType: MapType.normal,
                      zoomControlsEnabled: false,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      onMapCreated: (controller) {
                        mapController = controller;
                      },
                      initialCameraPosition: CameraPosition(
                        target: center, // Example coordinates (San Francisco)
                        zoom: 13.0,
                      ),
                    );
                  });
            },
          ),
        ),
      ),
    );
  }


}
