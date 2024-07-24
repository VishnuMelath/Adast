import 'dart:developer';

import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/features/profile/UI/widgets/customtile.dart';
import 'package:adast/features/profile/UI/widgets/profiletile.dart';
import 'package:adast/features/profile/bloc/profile_bloc.dart';
import 'package:adast/features/reservations/UI/reservation.dart';
import 'package:adast/features/saved_items/UI/saved_items.dart';
import 'package:adast/features/settings/UI/settings.dart';
import 'package:adast/features/splash_screen/bloc/splashscreen_bloc.dart';
import 'package:adast/features/subscriptions_page/UI/subscriptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home_screen/bloc/home_bloc.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ProfileBloc profileBloc = ProfileBloc();
  @override
  Widget build(BuildContext context) {
    log('hello');
    HomeBloc homeBloc = context.read<HomeBloc>();
    final user = context.read<SplashscreenBloc>().userModel;
    return SafeArea(
      child: Scaffold(
        backgroundColor: greentransparent.withOpacity(0.1),
        body: BlocListener<ProfileBloc, ProfileState>(
          bloc: profileBloc,
          listener: (context, state) {},
          child: Column(
            children: [
              Profiletile(user: user!),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // customListTile(
                      //   'Personal Details',
                      //   () {},
                      // ),
                      customListTile(
                        'My Reservations',
                        () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReservationsList(
                                  homeBloc: homeBloc,
                                ),
                              ));
                        },
                      ),
                      customListTile(
                        'Subscriptions',
                        () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SubscriptionsScreen(homeBloc: homeBloc),
                              ));
                        },
                      ),
                      customListTile(
                        'Saved',
                        () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SavedItemsScreen(
                                  homeBloc: homeBloc,
                                ),
                              ));
                        },
                      ),
                      customListTile(
                        'Settings',
                        () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SettingsPage(),
                              )).then(
                            (value) {
                              setState(() {});
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
