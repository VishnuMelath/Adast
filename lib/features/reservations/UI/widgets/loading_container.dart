import 'package:adast/%20themes/colors_shemes.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget loadingTile()
{
  return  Visibility(
    visible: true,
    child: Padding(
      padding: const EdgeInsets.only(left :8.0,top: 8,right: 8),
      child: Shimmer.fromColors(
        baseColor: backgroundColor,
        highlightColor: white,
        child: Container(
          decoration: BoxDecoration(
             color: white,
            borderRadius: BorderRadius.circular(10)),
          width: double.infinity,
          height: 80,
         
        ),
      
      ),
    ),
  );
}