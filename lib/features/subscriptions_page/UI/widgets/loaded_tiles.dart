import 'package:adast/features/home_screen/bloc/home_bloc.dart';
import 'package:adast/features/subscriptions_page/UI/widgets/subscriber_tile.dart';
import 'package:flutter/material.dart';

import '../../../../models/seller_model.dart';

class LoadedTilesSubscriptions extends StatelessWidget {
 final List<SellerModel> sellers;
 final HomeBloc homeBloc;
  const LoadedTilesSubscriptions({super.key,required this.sellers,required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: sellers.length,
      itemBuilder: (context, index) => SubscriberTile(seller: sellers[index],homeBloc: homeBloc,),);
  }
}