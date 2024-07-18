import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/%20themes/themes.dart';
import 'package:flutter/material.dart';

AppBar customAppBar(String title,BuildContext context)
{
  return AppBar(
    automaticallyImplyLeading: false,
    leading: IconButton(onPressed: () {
      Navigator.pop(context);
    }, icon:const Icon(Icons.arrow_back,color: green,)),
    title: Text(title,style: greenTextStyle,),backgroundColor: backgroundColor,);
}