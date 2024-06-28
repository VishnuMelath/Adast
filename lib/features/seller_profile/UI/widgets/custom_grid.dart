
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../ themes/colors_shemes.dart';
import '../../../../models/cloth_model.dart';

class CustomGrid extends StatelessWidget {
  final ClothModel clothModel;
  const CustomGrid({
    super.key,
    required this.clothModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top:  MediaQuery.of(context).size.width*0.01,left:  MediaQuery.of(context).size.width*0.01),
      child: Container(
        padding:  EdgeInsets.all( MediaQuery.of(context).size.width*0.01),
        decoration: BoxDecoration(border: Border.all(color: greentransparent),borderRadius: BorderRadius.circular(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width*0.443,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  fit: BoxFit.fitWidth,
                  imageUrl: clothModel.images[0],
                 
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      color: Colors.grey[300],
                      height: MediaQuery.of(context).size.width*0.443*1.5,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Text(
              '₹ ${clothModel.price}',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            Text(
              clothModel.name,
              style: const TextStyle(fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
