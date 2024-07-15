import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../ themes/colors_shemes.dart';

List<Widget> stringToImageListWidget(List images,BuildContext context)
{
return images.map(
                (e) {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: CachedNetworkImage(
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitWidth,
                      imageUrl: e,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          color: green,
                          height: MediaQuery.of(context).size.width * 1.5,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  );
                },
              ).toList();
}