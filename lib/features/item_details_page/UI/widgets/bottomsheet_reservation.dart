import 'dart:developer';

import 'package:adast/custom_widgets/custom_button.dart';
import 'package:adast/features/item_details_page/UI/widgets/custom_checkbox.dart';
import 'package:adast/features/item_details_page/bloc/item_details_bloc.dart';
import 'package:adast/features/splash_screen/bloc/splashscreen_bloc.dart';
import 'package:adast/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

void showBottomSheetForReservation(
    BuildContext context, ItemDetailsBloc itemDetailsBloc) {
  var razorpay = Razorpay();
  ValueNotifier groupValueNotifier = ValueNotifier('');
  showModalBottomSheet(
    context: context,
    builder: (context) => Column(
      children: [
        radio(
            label: 'for one day',
            groupValueNotifier: groupValueNotifier,
            price: '0'),
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
        CustomButton(
            onTap: () {
              try {
                Map<String, dynamic> options = {
                  'key': rpaykey,
                  'amount': int.parse(groupValueNotifier.value) * 100,
                  'name': context.read<SplashscreenBloc>().userModel!.name,
                  'description': 'reservation',
                  'prefill': {
                    'buyer': context.read<SplashscreenBloc>().userModel!.email,
                    'items_id': itemDetailsBloc.item.id,
                  }
                };

                razorpay.on(
                    Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                    handlePaymentSuccessResponse);
                // razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);

                razorpay.open(options);
              } catch (e) {
                log(e.toString());
              }
            },
            text: 'Proceed to pay')
      ],
    ),
  );
}

void handlePaymentErrorResponse(PaymentFailureResponse response) {
  log("Payment Failed Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
}

void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
  log('Payment Successful ,Payment ID: ${response.paymentId}');
}
