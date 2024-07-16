import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/%20themes/themes.dart';
import 'package:adast/methods/common_methods.dart';
import 'package:adast/models/reservation_model.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

Widget customStepper(ReservationModel reservation) {
  return Stepper(
      connectorColor: DateTime.now()
              .add(Duration(days: reservation.days))
              .isAfter(DateTime.now())
          ? const WidgetStatePropertyAll(green)
          : const WidgetStatePropertyAll(Colors.red),
      controlsBuilder: (context, _) => Container(),
      steps: List.generate(
        reservation.days,
        (index) => Step(
            isActive: DateTime.now().isAfter(
                reservation.reservationTime.add(Duration(days: index))),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  index == 0 ? 'Item reserved' : 'day $index ',
                  style: blackTextStyle,
                ),
                Text(
                  dateTimeString(
                      reservation.reservationTime.add(Duration(days: index))),
                  style: greyMediumTextStyle,
                )
              ],
            ),
            content: const Text('')),
      ));
}
