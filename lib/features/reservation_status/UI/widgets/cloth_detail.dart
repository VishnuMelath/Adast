import 'package:adast/%20themes/themes.dart';
import 'package:adast/features/reservation_status/bloc/reservation_status_bloc.dart';
import 'package:flutter/material.dart';

Widget clothDetail(ReservationStatusBloc reservationStatusBloc)
{
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(reservationStatusBloc.clothModel!.brand,style: greenTextStyle,)
        ,Text(reservationStatusBloc.clothModel!.name,style: mediumBlackTextStyle,),
        Text('price : ₹${reservationStatusBloc.clothModel!.price}',style: blackTextStyle,)
      ],
    ),
  );
}