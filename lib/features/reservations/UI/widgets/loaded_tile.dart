import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/%20themes/themes.dart';
import 'package:adast/features/reservation_status/bloc/reservation_status_bloc.dart';
import 'package:adast/features/reservations/UI/widgets/network_image.dart';
import 'package:adast/models/cloth_model.dart';
import 'package:adast/models/seller_model.dart';
import 'package:flutter/material.dart';

import 'status.dart';

Widget loadedTile(ReservationStatusBloc reservationsBloc,Function()? onTap) {
  ClothModel item=reservationsBloc.clothModel!;
  SellerModel seller=reservationsBloc.sellerModel!; 
  return Padding(
    padding: const EdgeInsets.only(left :8.0,top: 8,right: 8),
    child: InkWell(
      onTap:onTap ,
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 1,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: white,
              // border: Border.all(color: grey.withOpacity(0.3))
              ),
          padding: const EdgeInsets.all(8),
          height: 80,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              networkImage(item.images.first, 64),
              Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: mediumBlackTextStyle,
                    ),
                    Text(
                      seller.name,
                      style: greySmallTextStyle,
                    ),
                    Expanded(child: statusWidget1(reservationsBloc.reservationModel))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
