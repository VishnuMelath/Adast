import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/%20themes/themes.dart';
import 'package:adast/features/reservations/UI/widgets/network_image.dart';
import 'package:adast/models/cloth_model.dart';
import 'package:adast/models/seller_model.dart';
import 'package:flutter/material.dart';

Widget loadedTile(ClothModel item, SellerModel seller,Function()? onTap) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap:onTap ,
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 1,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: backgroundColor,
              // border: Border.all(color: grey.withOpacity(0.3))
              ),
          padding: const EdgeInsets.all(8),
          height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              networkImage(item.images.first, 84),
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
