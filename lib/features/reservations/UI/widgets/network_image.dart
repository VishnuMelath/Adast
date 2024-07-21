import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget networkImage(String image,double height)
{
  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: CachedNetworkImage(
      placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10)),
                            width: height/1.5,
                            height: height
                          ),
                        ),
      imageUrl: image,height: height,));
}