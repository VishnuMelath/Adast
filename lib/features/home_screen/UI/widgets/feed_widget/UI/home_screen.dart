
import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/%20themes/themes.dart';
import 'package:adast/custom_widgets/custom_cached_network_image.dart';
import 'package:adast/features/chat/chat_list/UI/chat_list_page.dart';
import 'package:adast/features/chat/chat_list/bloc/chat_list_bloc.dart';
import 'package:adast/features/home_screen/UI/widgets/feed_widget/UI/widgets/feed_widget.dart';
import 'package:adast/features/splash_screen/bloc/splashscreen_bloc.dart';
import 'package:adast/models/seller_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    GlobalKey key1 = GlobalKey();
    HomeBloc homeBloc = context.read();
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HomeNoSubState) {
          return Scaffold(
            appBar: AppBar(
              title: Image.asset(
                'assets/images/logo.png',
                height: 100,
              ),
            ),
            body: const Center(
              child: Text('You haven\'t subscribed to any shops'),
            ),
          );
        } else if (state is HomeLoadedState || state is HomeShopSelectedState) {
          return SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                homeBloc.add(HomeInitialEvent(
                    userModel: context.read<SplashscreenBloc>().userModel!));
              },
              child: Scaffold(
                  backgroundColor: greentransparent.withOpacity(0.01),
                  body: CustomScrollView(
                    controller: scrollController,
                    key: key1,
                    slivers: [
                      SliverAppBar(
                        titleSpacing: 0,
                        title: Align(
                          alignment: Alignment.centerLeft,
                          child: Image.asset(
                            'assets/images/logo.png',
                            height: 100,
                          ),
                        ),
                        elevation: 10,
                        stretch: true,
                        floating: true,
                        actions: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                        create: (context) => ChatListBloc(),
                                        child: const ChatListPage(),
                                      ),
                                    ));
                              },
                              icon: const Icon(
                                Icons.chat_bubble_outline,
                                color: green,
                              ))
                        ],
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        sliver: SliverToBoxAdapter(
                          child: Column(
                            children: [
                              SizedBox(
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
                                          color:
                                              greentransparent.withOpacity(.6),
                                          border: homeBloc.shopSelected == null
                                              ? Border.all(
                                                  color: green, width: 3)
                                              : Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        width: 60,
                                        child: Center(
                                          child: Text(
                                            'All',
                                            style: whiteTextStyle,
                                          ),
                                        ),
                                      ),
                                    ),
                                    ...context
                                        .read<SplashscreenBloc>()
                                        .userModel!
                                        .subscriptions
                                        .map(
                                      (email) {
                                        SellerModel e =
                                            homeBloc.sellers[email]!;
                                        return GestureDetector(
                                          onTap: () {
                                            homeBloc.add(HomeSellerTappedEvent(
                                                email: e.email));
                                          },
                                          child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: green,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border:
                                                      homeBloc.shopSelected ==
                                                              e.email
                                                          ? Border.all(
                                                              color: green,
                                                              width: 3)
                                                          : Border.all(),
                                                ),
                                                child: CustomCachedNetworkImage(
                                                    image: e.image!),
                                              )),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        sliver: homeBloc.showingList.isEmpty
                            ? SliverToBoxAdapter(
                                child: SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.6,
                                  child: const Center(
                                    child: Text('No items Available'),
                                  ),
                                ),
                              )
                            : SliverList(
                                delegate: SliverChildListDelegate([
                                ...homeBloc.showingList.map(
                                  (e) => FeedWidget(
                                      clothModel: e, homeBloc: homeBloc),
                                ),
                                const SizedBox(
                                  height: 100,
                                )
                              ])),
                      )
                    ],
                  )),
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
