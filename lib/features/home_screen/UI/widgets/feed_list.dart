import 'package:adast/features/home_screen/bloc/home_bloc.dart';
import 'package:flutter/material.dart';

import 'feed_widget/UI/widgets/feed_widget.dart';

Widget feedList({required BuildContext context,required HomeBloc homeBloc})
{
  return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: homeBloc.showingList.isEmpty
                          ? SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.6,
                            child: const Center(
                              child: Text('No items Available'),
                            ),
                          )
                          : Column(
                            mainAxisSize: MainAxisSize.min,
                              children: [
                              ...homeBloc.showingList.map(
                                (e) => FeedWidget(
                                    clothModel: e, homeBloc: homeBloc),
                              ),
                              const SizedBox(
                                height: 100,
                              )
                            ]),
                    );
}