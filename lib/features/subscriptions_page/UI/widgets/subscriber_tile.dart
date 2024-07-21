import 'package:adast/%20themes/themes.dart';
import 'package:adast/custom_widgets/custom_cached_network_image.dart';
import 'package:adast/models/seller_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home_screen/bloc/home_bloc.dart';
import '../../../seller_profile/UI/seller_profile.dart';
import '../../../seller_profile/bloc/seller_profile_bloc.dart';
import '../../../splash_screen/bloc/splashscreen_bloc.dart';

class SubscriberTile extends StatelessWidget {
  final SellerModel seller;
    final HomeBloc homeBloc;
  const SubscriberTile({super.key,required this.seller,required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8,top: 5),
      child: Card(
        child: ListTile(
          onTap: () {
             bool subscribed = context
            .read<SplashscreenBloc>()
            .userModel!
            .subscriptions
            .contains(seller.email);
        SellerProfileBloc sellerProfileBloc =
            SellerProfileBloc(sellerModel: seller, subscribed: subscribed)..add(SellerProfileItemLoadingEvent());
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => sellerProfileBloc,
                child: SellerProfile(homeBloc: homeBloc),
              ),
            ));
          },
          leading: CustomCachedNetworkImage(image: seller.image!),
          title: Text(seller.name,style: blackTextStyle,),
          subtitle: Text(seller.place,style: greyMediumTextStyle,),
        ),
      ),
    );
  }
}