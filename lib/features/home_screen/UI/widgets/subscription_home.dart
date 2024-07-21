import 'package:adast/features/home_screen/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../ themes/colors_shemes.dart';
import '../../../../ themes/themes.dart';
import '../../../../custom_widgets/custom_cached_network_image.dart';
import '../../../../models/seller_model.dart';
import '../../../splash_screen/bloc/splashscreen_bloc.dart';

Widget subscriptionsHorizontalList({required BuildContext context,required HomeBloc homeBloc})
{
  return     Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
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
                        );
                        
}