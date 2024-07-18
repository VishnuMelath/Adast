import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget networkImage(String image,double height)
{
  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: CachedNetworkImage(imageUrl: image,height: height,));
}