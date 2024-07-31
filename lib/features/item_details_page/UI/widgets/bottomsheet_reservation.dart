
import 'package:adast/custom_widgets/custom_button.dart';
import 'package:adast/custom_widgets/custom_snackbar.dart';
import 'package:adast/features/home_screen/bloc/home_bloc.dart';
import 'package:adast/features/item_details_page/UI/widgets/custom_checkbox.dart';
import 'package:adast/features/item_details_page/UI/widgets/custom_show_dialogue.dart';
import 'package:adast/features/item_details_page/bloc/item_details_bloc.dart';
import 'package:adast/features/splash_screen/bloc/splashscreen_bloc.dart';
import 'package:adast/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showBottomSheetForReservation(HomeBloc homeBloc,
    BuildContext context, ItemDetailsBloc itemDetailsBloc) {
  ValueNotifier groupValueNotifier = ValueNotifier('');
  showModalBottomSheet(
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          radio(
              label: 'for one day',
              groupValueNotifier: groupValueNotifier,
              price: '10'),
          radio(
              label: 'for two days',
              groupValueNotifier: groupValueNotifier,
              price: '30'),
          radio(
              label: 'for three days',
              groupValueNotifier: groupValueNotifier,
              price: '40'),
          radio(
              label: 'for four days',
              groupValueNotifier: groupValueNotifier,
              price: '50'),
          BlocListener<ItemDetailsBloc, ItemDetailsState>(
            bloc: itemDetailsBloc,
            listener: (context, state) {
              if (state is ItemDetailPaymentSuccessState) {
                Navigator.pop(context);
                customShowDialogue(
                    context, itemDetailsBloc, state.reservationModel,homeBloc);
              } else if (state is ItemDetailPaymentErrorState) {
              } else if (state is ItemDetailsErrorState) {
                customSnackBar(context, state.error);
              }
            },
            child: CustomButton(
                onTap: () {
                  Map<String, dynamic> options = {
                    'key': rpaykey,
                    'amount': int.parse(groupValueNotifier.value) * 100,
                    'name': context.read<SplashscreenBloc>().userModel!.name,
                    'description': 'reservation',
                    'prefill': {
                      'buyer':
                          context.read<SplashscreenBloc>().userModel!.email,
                      'items_id': itemDetailsBloc.item.id,
                    }
                  };
                  
                  itemDetailsBloc
                      .add(ItemReservationPaymentEvent(options: options));
                      
                },
                text: 'Proceed to pay'),
          )
        ],
      ),
    ),
  );
}
