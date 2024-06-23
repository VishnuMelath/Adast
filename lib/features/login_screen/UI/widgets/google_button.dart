import 'package:flutter/material.dart';


class GoogleButton extends StatelessWidget {
  final Function() onTap;
  const GoogleButton({super.key ,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.all(18.0),
    child: GestureDetector(
      // borderRadius: BorderRadius.circular(10),
      // splashColor: greentransparent,
      onTap: onTap,
      child: Container(
          width: MediaQuery.of(context).size.width - 100,
          height: 40,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      'assets/images/android_neutral_sq_ctn@4x.png')))),
    ),
  );
  }
}