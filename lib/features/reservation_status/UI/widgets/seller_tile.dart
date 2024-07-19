import 'package:adast/%20themes/themes.dart';
import 'package:adast/features/reservation_status/UI/widgets/network_image.dart';
import 'package:adast/features/reservation_status/bloc/reservation_status_bloc.dart';
import 'package:adast/models/seller_model.dart';
import 'package:flutter/material.dart';


class SellerTile extends StatelessWidget {
  final ReservationStatusBloc reservationStatusBloc;
  const SellerTile({super.key,required this.reservationStatusBloc});

  @override
  Widget build(BuildContext context) {
    SellerModel sellerModel=reservationStatusBloc.sellerModel;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        networkImageUsingWidth(sellerModel.image!, 50),
        const SizedBox(width: 10,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(sellerModel.name,style: mediumBlackTextStyle,),
          Text(sellerModel.place,style: greySmallTextStyle,),
        ],
      ),
      ]
         
        );
  }
}
