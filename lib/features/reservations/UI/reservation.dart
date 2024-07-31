import 'dart:developer';

import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/custom_widgets/custom_appbar.dart';
import 'package:adast/features/reservation_status/UI/reservation_status_screen.dart';
import 'package:adast/features/reservation_status/bloc/reservation_status_bloc.dart';
import 'package:adast/features/reservations/UI/widgets/filter_reservations_widget.dart';
import 'package:adast/features/reservations/UI/widgets/loaded_tile.dart';
import 'package:adast/features/reservations/bloc/reservations_bloc.dart';
import 'package:adast/features/reservations/methods/filter_reservations.dart';
import 'package:adast/features/splash_screen/bloc/splashscreen_bloc.dart';
import 'package:adast/models/reservation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home_screen/bloc/home_bloc.dart';
import 'widgets/loading_container.dart';

class ReservationsList extends StatelessWidget {
  final HomeBloc homeBloc;
  const ReservationsList({super.key, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    ReservationsBloc reservationsBloc = ReservationsBloc();
    final email = context.read<SplashscreenBloc>().userModel!.email;
    reservationsBloc.add(ReservationInitialEvent(email: email));
    return Container(
      color: white,
      child: SafeArea(
          child: Scaffold(
        appBar: customAppBar('My reservations', context),
        backgroundColor: backgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            filterReservationsWidget(context, reservationsBloc),
            Expanded(
              child: BlocBuilder<ReservationsBloc, ReservationsState>(
                bloc: reservationsBloc,
                buildWhen: (previous, current) {
                  return current is ReservationsLoadedState ||
                      current is ReservationsLoadingState;
                },
                builder: (context, state) {
                  if (state is ReservationsLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    log(reservationsBloc.filter);
                     List<ReservationModel> filteredList=reservationsBloc.reservations;
                    if (reservationsBloc.filter != 'All') {
                        filteredList =
                            filterReservations(reservationsBloc.filter,
                                reservationsBloc.reservations);
                      }
                    if (filteredList.isEmpty) {
                      return const Center(
                        child: Text('no reservations'),
                      );
                    } else {
                      
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          var reservationDetails =
                              filteredList[index];
                          var reservationStatusBloc = ReservationStatusBloc(
                              reservationModel: reservationDetails);
                          reservationStatusBloc.reservationModel =
                              reservationDetails;
                          reservationStatusBloc.add(ReservationTileLoadingEvent(
                              itemId: reservationDetails.itemId,
                              sellerId: reservationDetails.sellerId));

                          return BlocBuilder(
                            bloc: reservationStatusBloc,
                            buildWhen: (previous, current) =>
                                current is ReservationTileLoadingState ||
                                current is ReservationTileLoadedState,
                            builder: (context, state) {
                              if (state is ReservationTileLoadingState) {
                                return loadingTile();
                              } else if (state is ReservationTileLoadedState) {
                                return loadedTile(
                                  reservationStatusBloc,
                                  () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ReservationStatusScreen(
                                            homeBloc: homeBloc,
                                            reservationStatusBloc:
                                                reservationStatusBloc,
                                          ),
                                        )).then(
                                      (value) {
                                        if (value != null) {
                                          reservationsBloc.add(
                                              ReservationInitialEvent(
                                                  email: email));
                                        }
                                      },
                                    );
                                  },
                                );
                              } else {
                                return loadingTile();
                              }
                            },
                          );
                        },
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
