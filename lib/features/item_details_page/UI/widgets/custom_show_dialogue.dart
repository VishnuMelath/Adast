import 'package:adast/%20themes/themes.dart';
import 'package:adast/custom_widgets/custom_button.dart';
import 'package:adast/features/home_screen/bloc/home_bloc.dart';
import 'package:adast/features/item_details_page/bloc/item_details_bloc.dart';
import 'package:adast/features/reservation_status/UI/reservation_status_screen.dart';
import 'package:adast/features/reservation_status/bloc/reservation_status_bloc.dart';
import 'package:adast/models/reservation_model.dart';
import 'package:flutter/material.dart';

Future customShowDialogue(
    BuildContext context, ItemDetailsBloc itemDetailsBloc,ReservationModel reservation,HomeBloc homeBloc) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'Success',
          style: largeBlackTextStyle,
        ),
        content: Text(
          'item reserved successfully',
          style: blackPlainTextStyle,
        ),
        actions: [
          Center(
            child: SizedBox(
              width: 100,
              height: 70,
              child: Center(
                child: CustomButton(
                    onTap: () {
                      ReservationStatusBloc reservationStatusBloc=ReservationStatusBloc(reservationModel: reservation);
                      reservationStatusBloc.clothModel=itemDetailsBloc.item;
                      reservationStatusBloc.sellerModel=itemDetailsBloc.sellerModel!;
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReservationStatusScreen(reservationStatusBloc: reservationStatusBloc,homeBloc: homeBloc,),
                          ));
                    },
                    text: 'ok'),
              ),
            ),
          )
        ],
      );
    },
  );
}
