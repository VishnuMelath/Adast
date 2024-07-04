import 'dart:developer';

import 'package:adast/features/home_screen/bloc/home_bloc.dart';
import 'package:adast/features/map/UI/widgets/marker.dart';
import 'package:adast/features/seller_profile/bloc/seller_profile_bloc.dart';
import 'package:adast/models/seller_model.dart';
import 'package:adast/services/seller_database_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../ themes/colors_shemes.dart';
import '../../seller_profile/UI/seller_profile.dart';
import '../../splash_screen/bloc/splashscreen_bloc.dart';
import '../bloc/map_bloc.dart';
import '../methods/markers_from_widget.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  bool isloaded = false;
  GlobalKey<FormState> formkey = GlobalKey();
  final Map<String, Marker> markers = {};
  LatLng center = const LatLng(11.2588, 75.7804);
  late GoogleMapController mapController;
  MapBloc mapBloc = MapBloc();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  late Stream<QuerySnapshot> _locationsStream;
  List<Map<String, dynamic>> data = [];
  @override
  void initState() {
    _locationsStream = SellerDatabaseServices().getAllSellers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      HomeBloc homeBloc=context.read();
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: _locationsStream,
          builder: (context, snapshot) {
            final locations = snapshot.data?.docs;
            final length = locations?.length ?? 0;
            locations?.forEach(
              (element) {
                data.add({'globalKey': GlobalKey(), 'data': element});
              },
            );
            SchedulerBinding.instance
                .addPostFrameCallback((_) => onBuildCompleted(homeBloc));
            return BlocBuilder<MapBloc, MapState>(
              bloc: mapBloc,
              builder: (context, state) {
                return Stack(
                  children: [
                    ListView(
                      children: [
                        for (int i = 0; i < length; i++)
                          Transform.translate(
                            offset: Offset(
                                -MediaQuery.of(context).size.width * 2,
                                -MediaQuery.of(context).size.height * 2),
                            child: RepaintBoundary(
                              key: data[i]['globalKey'],
                              child: CustomMarker(
                                image: data[i]['data']['image'],
                                name: data[i]['data']['name'],
                              ),
                            ),
                          )
                      ],
                    ),
                    GoogleMap(
                      buildingsEnabled: false,
                      markers: markers.values.toSet(),
                      onTap: (latlng) {},
                      mapType: MapType.normal,
                      zoomControlsEnabled: false,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      onMapCreated: (controller) {
                        mapController = controller;
                      },
                      initialCameraPosition: CameraPosition(
                        target: center,
                        zoom: 13.0,
                      ),
                    ),
                    Positioned(
                      bottom: MediaQuery.sizeOf(context).height * 0.152,
                      right: MediaQuery.sizeOf(context).height * 0.01,
                      child: FloatingActionButton(
                        child:const Icon(Icons.my_location_sharp),
                        onPressed: () {
                          mapBloc.add(MapCurrentLocationTappedEvent(
                              googleMapController: mapController));
                        },
                      ),
                    )
                  ],
                );
              },
            );
          }),
    );
  }

  Future<void> onBuildCompleted(HomeBloc homeBloc) async {

    await Future.wait(data.map(
      (e) async {
        try {
          Marker marker = await generateMarkersFromWidget(
            e,
            () {
              final subscribed=context.read<SplashscreenBloc>().userModel!.subscriptions.contains(e['data']['emailaddress']);
            
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => SellerProfileBloc(sellerModel: SellerModel.fromJson(e['data']),subscribed: subscribed),
                      child:  SellerProfile(homeBloc: homeBloc,),
                    ),
                  ));
            },
          );
          markers[marker.markerId.value] = marker;
        } on Exception catch (e) {
          log(e.toString());
        }
      },
    ));
    log(markers.toString());
    mapBloc.add(MapBuildCompletedEvent());
  }
}
