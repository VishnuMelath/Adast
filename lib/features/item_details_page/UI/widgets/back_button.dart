import 'package:flutter/material.dart';

import '../../../../ themes/colors_shemes.dart';

Widget backButton(BuildContext context,bool reload)
{
  return Positioned(
                      top: 0,
                      left: 0,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context, reload);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: white,
                          )),
                    );
}