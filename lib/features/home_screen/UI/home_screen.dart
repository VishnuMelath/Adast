import 'dart:developer';

import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/%20themes/themes.dart';
import 'package:adast/features/home_screen/UI/widgets/feed_widget/UI/feed_widget.dart';
import 'package:adast/features/splash_screen/bloc/splashscreen_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    GlobalKey key1 = GlobalKey();
    HomeBloc homeBloc = HomeBloc()
      ..add(HomeInitialEvent(
          userModel: context.read<SplashscreenBloc>().userModel!));

    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => current is! HomeShopSelectedState,
      bloc: homeBloc,
      builder: (context, state) {
        log(state.runtimeType.toString());
        if (state is HomeLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HomeLoadedState) {
          return Scaffold(
            body: BlocBuilder<HomeBloc, HomeState>(
               bloc: homeBloc,
                          buildWhen: (previous, current) =>
                              current is HomeShopSelectedState,
              builder: (context, state) {
                return CustomScrollView(
                  controller: scrollController,
                  key: key1,
                  slivers: [
                    SliverAppBar(
                      stretch: true,
                      floating: true,
                      title: Image.asset(
                        'assets/images/logo.png',
                        height: 100,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        height: 60,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            GestureDetector(
                              onTap: () {
                                homeBloc.add(
                                    HomeSellerTappedEvent(email: null));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                  color: greentransparent.withOpacity(.6),
                                  border: homeBloc.shopSelected == null
                                      ? Border.all(color: green, width: 3)
                                      : Border.all(),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: 60,
                                child: const Center(
                                  child: Text(
                                    'All',
                                    style: whiteTextStyle,
                                  ),
                                ),
                              ),
                            ),
                            ...homeBloc.sellers.values.map(
                              (e) => GestureDetector(
                                onTap: () {
                                  homeBloc.add(HomeSellerTappedEvent(
                                      email: e.email));
                                },
                                child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: green,
                                        borderRadius:
                                            BorderRadius.circular(12),
                                        border:
                                            homeBloc.shopSelected == e.email
                                                ? Border.all(
                                                    color: green, width: 3)
                                                : Border.all(),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                            fit: BoxFit.fill,
                                            useOldImageOnUrlChange: true,
                                            imageUrl: e.image!),
                                      ),
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      ...homeBloc.showingList.map(
                        (e) => FeedWidget(clothModel: e, homeBloc: homeBloc),
                      )
                    ]))
                  ],
                );
              },
            ),
          );
        } else if (state is HomeErrorState) {
          return Center(
            child: Text(state.error),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
