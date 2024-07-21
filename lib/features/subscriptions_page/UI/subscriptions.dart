import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/%20themes/themes.dart';
import 'package:adast/custom_widgets/custom_appbar.dart';
import 'package:adast/features/home_screen/bloc/home_bloc.dart';
import 'package:adast/features/subscriptions_page/UI/widgets/loaded_tiles.dart';
import 'package:adast/features/subscriptions_page/UI/widgets/loading_tiles.dart';
import 'package:adast/features/subscriptions_page/bloc/subscriptions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubscriptionsScreen extends StatelessWidget {
  final HomeBloc homeBloc;
  const SubscriptionsScreen({super.key,required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    SubscriptionsBloc subscriptionsBloc=SubscriptionsBloc();
    if(homeBloc.userModel.subscriptions.isNotEmpty)
    {
      subscriptionsBloc.add(SubscriptionsLoadingEvent(subscriptionsId: homeBloc.userModel.subscriptions));
    }
    return Container(
      color: white,
      child: SafeArea(child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: customAppBar('Subscriptions', context),
        body: BlocBuilder(
          bloc: subscriptionsBloc,
          builder: (context, state) {
            if(state is SubscriptionsLoadingState)
            {
              return LoadingTilesSubscriptions(length: homeBloc.userModel.subscriptions.length);
            }
            else if(state is SubscriptionsLoadedState)
            {
              return LoadedTilesSubscriptions(
                sellers: subscriptionsBloc.subscriptions.values.toList(),
                homeBloc: homeBloc,
              );
            }
            else if(state is SubscriptionsErrorState)
            {
              return  Center(child: Text(state.error,style: greyMediumTextStyle,),);
            }
            else
            {return Container();}
        },),
      ),),
    );
  }
}