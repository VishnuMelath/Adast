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
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(
            image,
          ),
        ),
        Text(name,style:blackTextStyle,)
      ],
    );
  }
}
