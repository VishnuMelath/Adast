import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class CustomCachedNetworkImage extends StatelessWidget {
  final String image;
  const CustomCachedNetworkImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return   ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: CachedNetworkImage(
                      
                        fit: BoxFit.fill,
                        imageUrl: image,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10)),
                            width: 60,
                            height: 60
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
    );
  }
}