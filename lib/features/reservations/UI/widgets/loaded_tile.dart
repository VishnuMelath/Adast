import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/models/cloth_model.dart';
import 'package:adast/models/seller_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget loadedTile(ClothModel item,SellerModel seller)
{
  return  Shimmer.fromColors(
    baseColor: greentransparent,
    highlightColor: white,
    child: Container(),

  );
}