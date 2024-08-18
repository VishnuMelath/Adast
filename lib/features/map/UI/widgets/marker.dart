

import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/%20themes/themes.dart';
import 'package:flutter/material.dart';

class CustomMarker extends StatelessWidget {
  final String image;
  final String name;
  const CustomMarker({super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Icon(Icons.location_on,size: 80,color: red,),
            Positioned(
              top: 10,
              left: 20,
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(image),
              ),
            ),
          ],
        ),
        Text(name,style:blackTextStyle,)
      ],
    );
  }
}
