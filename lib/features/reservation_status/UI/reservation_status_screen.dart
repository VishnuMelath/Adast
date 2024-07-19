import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/custom_widgets/custom_appbar.dart';
import 'package:adast/features/reservation_status/UI/widgets/cloth_detail.dart';
import 'package:adast/features/reservation_status/UI/widgets/custom_stepper.dart';
import 'package:adast/features/reservation_status/UI/widgets/network_image.dart';
import 'package:adast/features/reservation_status/UI/widgets/seller_tile.dart';
import 'package:adast/features/reservation_status/UI/widgets/status.dart';
import 'package:adast/features/reservation_status/bloc/reservation_status_bloc.dart';
import 'package:flutter/material.dart';

class ReservationStatusScreen extends StatelessWidget {
  final ReservationStatusBloc reservationStatusBloc;
  const ReservationStatusScreen({super.key, required this.reservationStatusBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: SafeArea(
        child: Scaffold(
          appBar: customAppBar('Reservation Details',context),
          body: SingleChildScrollView(
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
                             SellerTile(reservationStatusBloc: reservationStatusBloc),
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
          ),
        ),
      ),
    );
  }
}
