
import 'package:adast/%20themes/themes.dart';
import 'package:adast/custom_widgets/custom_cached_network_image.dart';
import 'package:adast/features/home_screen/bloc/home_bloc.dart';
import 'package:adast/features/seller_profile/UI/seller_profile.dart';
import 'package:adast/features/seller_profile/bloc/seller_profile_bloc.dart';
import 'package:adast/features/splash_screen/bloc/splashscreen_bloc.dart';
import 'package:adast/models/seller_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SellerTile extends StatelessWidget {
  final SellerModel sellerModel;
  final HomeBloc homeBloc;
  final GoogleMapController googleMapController;
  const SellerTile(
      {super.key,
      required this.sellerModel,
      required this.googleMapController,
      required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        bool subscribed = context
            .read<SplashscreenBloc>()
            .userModel!
            .subscriptions
            .contains(sellerModel.email);
        SellerProfileBloc sellerProfileBloc =
            SellerProfileBloc(sellerModel: sellerModel, subscribed: subscribed)..add(SellerProfileItemLoadingEvent());
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => sellerProfileBloc,
                child: SellerProfile(homeBloc: homeBloc),
              ),
            ));
      },
      leading: CustomCachedNetworkImage(image: sellerModel.image!),
      title: Text(
        sellerModel.name,
        style: blackPlainTextStyle,
      ),
      subtitle: Text(
        sellerModel.place,
        style: greySmallTextStyle,
      ),
      trailing: IconButton(
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            googleMapController.moveCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    zoom: 14,
                    target: LatLng(sellerModel.latLng!.latitude,
                        sellerModel.latLng!.longitude))));
          },
          icon: const Icon(Icons.location_on)),
    );
  }
}
