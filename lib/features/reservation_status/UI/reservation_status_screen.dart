import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/features/reservation_status/UI/widgets/cloth_detail.dart';
import 'package:adast/features/reservation_status/UI/widgets/custom_stepper.dart';
import 'package:adast/features/reservation_status/UI/widgets/network_image.dart';
import 'package:adast/features/reservation_status/UI/widgets/seller_tile.dart';
import 'package:adast/features/reservation_status/bloc/reservation_status_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReservationStatusScreen extends StatelessWidget {
  const ReservationStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ReservationStatusBloc reservationStatusBloc = context.read();
    return Container(
      color: backgroundColor,
      child: SafeArea(
        child: Scaffold(
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
                            const SellerTile(),
                            clothDetail(reservationStatusBloc)
                          ],
                        ),
                      ),
                      networkImage(
                        reservationStatusBloc.clothModel!.images.first,
                        80,
                      )
                    ],
                  ),
                  customStepper(reservationStatusBloc.reservationModel)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
