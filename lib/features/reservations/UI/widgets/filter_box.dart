
import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/%20themes/themes.dart';
import 'package:adast/features/reservations/bloc/reservations_bloc.dart';
import 'package:flutter/material.dart';

Widget filterBox({required String selected,required String value,required ReservationsBloc reservationsBloc})
{
  return GestureDetector(
    onTap: () {
      reservationsBloc.add(ReservationsFilterSelectedEvent(value: value));
    },
    child: Container(
      // height: 50,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color:selected==value? greentransparent:white,borderRadius: BorderRadius.circular(10)),
      child: Text(value,style: selected!=value? greenTextStyle:whiteTextStyle,),
    ),
  );
}