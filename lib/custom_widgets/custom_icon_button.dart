

import 'package:flutter/material.dart';

import '../ themes/themes.dart';
import '../constants/constants.dart';

class CustomIconButton extends StatelessWidget {
  final Function() onTap;
  final String icon;
  const CustomIconButton({super.key, required this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Material(
                              borderRadius: BorderRadius.circular(20),
                              child: IconButton(
                                  onPressed:onTap,
                                  icon: Icon(icons[icon])),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                             Text(
                              icon,
                              style: whiteTextStyle,
                            )
                          ],
                        ),
                      );
  }
}