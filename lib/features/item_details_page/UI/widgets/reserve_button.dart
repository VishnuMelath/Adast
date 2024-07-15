import 'package:flutter/material.dart';

import '../../../../ themes/colors_shemes.dart';
import '../../../../ themes/themes.dart';

FloatingActionButton reserveButton(void Function() onPressed)
{
  return FloatingActionButton.extended(
              onPressed:onPressed,
              backgroundColor: green,
              label: Text(
                'reserve',
                style: whiteTextStyle,
              ));
}