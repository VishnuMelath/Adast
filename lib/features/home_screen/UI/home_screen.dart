import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/features/home_screen/UI/widgets/body_home.dart';
import 'package:adast/features/home_screen/UI/widgets/box_to_sliver.dart';
import 'package:adast/features/home_screen/UI/widgets/sliver_appbar.dart';
import 'package:adast/features/splash_screen/bloc/splashscreen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    GlobalKey key1 = GlobalKey();
    HomeBloc homeBloc = context.read();
    return Container(
      color: backgroundColor,
      child: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            homeBloc.add(HomeInitialEvent(
                userModel: context.read<SplashscreenBloc>().userModel!));
          },
          child: BlocBuilder<HomeBloc, HomeState>(
            
            builder: (context, state) {
              late Widget widget= errorMsg( msg: '');
                   if (state is HomeLoadingState) {
                      widget= circularLoading();
                    } else if (state is HomeNoSubState) {
                      widget= errorMsg(msg: 'Please check your network');
                    } else if (state is HomeLoadedState ||
                        state is HomeShopSelectedState) {
                      widget= homeBody(context, homeBloc: homeBloc);
                    } else if (state is HomeErrorState) {
                      widget=errorMsg(msg: state.error);
                    }
              return CustomScrollView(
                key: key1,
                controller: scrollController, slivers: [
                sliverAppBar(context: context),
                widget
              ]);
            },
          ),
        ),
      ),
    );
  }
}
