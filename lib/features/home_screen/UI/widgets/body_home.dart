import 'package:adast/features/home_screen/UI/widgets/subscription_home.dart';
import 'package:adast/features/home_screen/bloc/home_bloc.dart';
import 'package:flutter/material.dart';

import 'feed_list.dart';

Widget homeBody(BuildContext context,{required HomeBloc homeBloc})
{
  return SliverFillRemaining(
    fillOverscroll: true,
                        hasScrollBody: false,
                        child: Column(
                         mainAxisSize: MainAxisSize.min,
                          children: [
                            subscriptionsHorizontalList(
                                context: context, homeBloc: homeBloc),
                            Expanded(child: feedList(context: context, homeBloc: homeBloc)),
                          ],
                        ),
                      );
}