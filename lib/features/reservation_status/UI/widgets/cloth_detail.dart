import 'package:adast/%20themes/themes.dart';
import 'package:adast/features/reservation_status/bloc/reservation_status_bloc.dart';
import 'package:flutter/material.dart';

Widget clothDetail(ReservationStatusBloc reservationStatusBloc) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          reservationStatusBloc.clothModel!.brand,
          style: greenTextStyle,
        ),
        Text(
          reservationStatusBloc.clothModel!.name,
          style: mediumBlackTextStyle,
        ),
        Text(
          'size : ${reservationStatusBloc.reservationModel.size}',
          style: greyMediumTextStyle,
        ),
        Text(
          'price : ₹${reservationStatusBloc.clothModel!.price}',
          style: greyMediumTextStyle,
        ),
        Text(
          'Amount paid : ₹${reservationStatusBloc.reservationModel.amount ~/ 100}',
          style: greyMediumTextStyle,
        )
      ],
    ),
  );
}
