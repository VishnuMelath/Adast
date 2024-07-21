
import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/custom_widgets/custom_appbar.dart';
import 'package:adast/features/reservation_status/UI/widgets/cloth_detail.dart';
import 'package:adast/features/reservation_status/UI/widgets/custom_stepper.dart';
import 'package:adast/features/reservation_status/UI/widgets/network_image.dart';
import 'package:adast/features/reservation_status/UI/widgets/seller_tile.dart';
import 'package:adast/features/reservation_status/UI/widgets/status.dart';
import 'package:adast/features/reservation_status/bloc/reservation_status_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home_screen/bloc/home_bloc.dart';
import '../../replace_product_list/UI/replace_screen.dart';

class ReservationStatusScreen extends StatelessWidget {
  final HomeBloc homeBloc;
  final ReservationStatusBloc reservationStatusBloc;
  const ReservationStatusScreen(
      {super.key, required this.reservationStatusBloc, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReplaceProduct(
                      reservationModel: reservationStatusBloc.reservationModel,
                      homeBloc: homeBloc,
                    ),
                  )).then(
                (value) {
                  if (value != null) {
                    reservationStatusBloc.reservationModel = value;
                    reservationStatusBloc.add(ReservationTileLoadingEvent(itemId: reservationStatusBloc.reservationModel.itemId,sellerId: reservationStatusBloc.reservationModel.sellerId));
                  }
                },
              );
            },
            label: const Text('Replace item'),
          ),
          appBar: customAppBar('Reservation Details', context),
          body: BlocBuilder<ReservationStatusBloc, ReservationStatusState>(
            bloc: reservationStatusBloc,
            builder: (context, state) {
              if(state is ReservationTileLoadingState)
              {
                return const Center(child: CircularProgressIndicator(),);

              }
              else
              {
                return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SellerTile(
                                    reservationStatusBloc:
                                        reservationStatusBloc),
                                clothDetail(reservationStatusBloc)
                              ],
                            ),
                          ),
                          networkImageUsingWidth(
                            reservationStatusBloc.clothModel!.images.first,
                            80,
                          )
                        ],
                      ),
                      customStepper(reservationStatusBloc.reservationModel),
                      statusWidget(reservationStatusBloc.reservationModel)
                    ],
                  ),
                ),
              );
              }
              
            },
          ),
        ),
      ),
    );
  }
}
