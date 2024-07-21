import 'package:adast/%20themes/themes.dart';
import 'package:adast/constants/constants.dart';
import 'package:adast/models/reservation_model.dart';
import 'package:flutter/material.dart';

Widget statusWidget1(ReservationModel reservation) {
  var days = reservation.reservationTime
      .add(Duration(days: reservation.days))
      .difference(DateTime.now())
      .inDays;
  var hours = reservation.reservationTime
          .add(Duration(days: reservation.days))
          .difference(DateTime.now())
          .inHours %
      24;
  var minutes = reservation.reservationTime
          .add(Duration(days: reservation.days))
          .difference(DateTime.now())
          .inMinutes %
      60;
  var difference = '';
  if (days > 0) {
    difference += '$days days ';
  }
  if (hours > 0) {
    difference += '$hours hours ';
  }
  difference += '$minutes minutes';
  String text = reservation.status == ReservationStatus.purchased.name
      ? 'Order Completed'
      : reservation.reservationTime
              .add(Duration(days: reservation.days))
              .isBefore(DateTime.now())
          ? 'Reserved days are over'
          : '$difference left to pick';
  return Align(
    alignment: Alignment.bottomLeft,
    child: Text(
      text,
      style: greyMediumTextStyle,
    ),
  );
}
