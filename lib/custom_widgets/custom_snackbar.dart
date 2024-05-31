import 'package:flutter/material.dart';

import '../ themes/colors_shemes.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> customSnackBar(BuildContext context,String message)
{
  return  ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                  backgroundColor: green,
                    content: Text(message)));
}