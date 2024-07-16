import 'package:adast/%20themes/colors_shemes.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget loadingTile()
{
  return  Shimmer.fromColors(
    baseColor: greentransparent,
    highlightColor: white,
    child: Container(),

  );
}