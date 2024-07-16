import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/features/reservations/UI/widgets/loaded_tile.dart';
import 'package:adast/features/reservations/bloc/reservations_bloc.dart';
import 'package:adast/features/splash_screen/bloc/splashscreen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/loading_container.dart';

class ReservationsList extends StatelessWidget {
  const ReservationsList({super.key});

  @override
  Widget build(BuildContext context) {
    ReservationsBloc reservationsBloc = ReservationsBloc();
    final email = context.read<SplashscreenBloc>().userModel!.email;
    reservationsBloc.add(ReservationInitialEvent(email: email));
    return Container(
      color: backgroundColor,
      child: SafeArea(
          child: Scaffold(
        body: BlocBuilder<ReservationsBloc, ReservationsState>(
          buildWhen: (previous, current) {
            return current is ReservationsLoadedState &&
                current is ReservationsLoadingState;
          },
          builder: (context, state) {
            if (state is ReservationsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (reservationsBloc.reservations.isEmpty) {
                return const Center(
                  child: Text('no reservations'),
                );
              }
              return ListView.builder(
                itemCount: reservationsBloc.reservations.length,
                itemBuilder: (context, index) {
                  return BlocBuilder(
                    buildWhen: (previous, current) =>
                        current is ReservationTileLoadingState &&
                        current is ReservationTileLoadedState,
                    bloc: reservationsBloc,
                    builder: (context, state) {
                      if (state is ReservationTileLoadingState) {
                        return loadingTile();
                      } else  if(state is ReservationTileLoadedState){
                        return loadedTile(state.clothModel,state.sellerModel);
                      }
                      else 
                      {
                        return loadingTile();
                      }
                    },
                  );
                },
              );
            }
          },
        ),
      )),
    );
  }
}
