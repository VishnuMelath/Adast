
import 'package:adast/%20themes/themes.dart';
import 'package:adast/methods/common_methods.dart';
import 'package:adast/models/reservation_model.dart';
import 'package:flutter/material.dart';

import '../../../../ themes/colors_shemes.dart';
import '../../../../constants/constants.dart';

Widget customStepper(ReservationModel reservation) {
  if(reservation.status == ReservationStatus.purchased.name)
  {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Stepper(
        physics: const NeverScrollableScrollPhysics(),
        connectorColor: const WidgetStatePropertyAll(green),
        controlsBuilder: (context, _) => Container(),
        steps: [
          Step(
            state: StepState.complete,
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Item reserved for ${reservation.days} days',
                    style: blackTextStyle,
                  ),
                  Text(
                    dateTimeString(reservation.reservationTime),
                    style: greyMediumTextStyle,
                  )
                ],
              ),
              content: const Text('')),
          Step(
            state: StepState.complete,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Item purchased',
                    style: blackTextStyle,
                  ),
                  Text(
                    dateTimeString(reservation.reservationTime.add(Duration(days: reservation.days))),
                    style: greyMediumTextStyle,
                  )
                ],
              ),
              content: const Text(''))
        ],
      ),
    );
  }
  else
  {
  if (DateTime.now().isBefore(
      reservation.reservationTime.add(Duration(days: reservation.days)))) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Stepper(
        physics: const NeverScrollableScrollPhysics(),
          controlsBuilder: (context, _) => Container(),
          steps: List.generate(
            reservation.days + 1,
            (index) {
              return Step(
                  state: DateTime.now().isAfter(
                          reservation.reservationTime.add(Duration(days: index)))
                      ? StepState.complete
                      : StepState.disabled,
                  isActive: DateTime.now().isAfter(
                      reservation.reservationTime.add(Duration(days: index))),
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        index == 0 ? 'Item reserved for ${reservation.days} days' : 'day $index ',
                        style: blackTextStyle,
                      ),
                      Text(
                        index == 0
                            ? dateTimeString(reservation.reservationTime
                                .add(Duration(days: index)))
                            : dateString(reservation.reservationTime
                                .add(Duration(days: index))),
                        style: greyMediumTextStyle,
                      )
                    ],
                  ),
                  content: const Text(''));
            },
          )),
    );
  } else {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Stepper(
        physics: const NeverScrollableScrollPhysics(),
        connectorColor: const WidgetStatePropertyAll(Colors.red),
        controlsBuilder: (context, _) => Container(),
        steps: [
          Step(
            state: StepState.complete,
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Item reserved for ${reservation.days} days',
                    style: blackTextStyle,
                  ),
                  Text(
                    dateTimeString(reservation.reservationTime),
                    style: greyMediumTextStyle,
                  )
                ],
              ),
              content: const Text('')),
          Step(
            state: StepState.error,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reserved days are over',
                    style: blackTextStyle,
                  ),
                  Text(
                    dateTimeString(reservation.reservationTime.add(Duration(days: reservation.days))),
                    style: greyMediumTextStyle,
                  )
                ],
              ),
              content: const Text(''))
        ],
      ),
    );
  }
}
}