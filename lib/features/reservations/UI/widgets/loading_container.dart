import 'package:adast/%20themes/colors_shemes.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget loadingTile()
{
  return  Padding(
    padding: const EdgeInsets.all(8.0),
    child: Shimmer.fromColors(
      baseColor: greentransparent,
      highlightColor: white,
      child: Container(
        decoration: BoxDecoration(
           color: white,
          borderRadius: BorderRadius.circular(10)),
        width: double.infinity,
        height: 100,
       
      ),
    
    ),
  );
}