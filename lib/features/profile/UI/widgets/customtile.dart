
import 'package:adast/%20themes/themes.dart';
import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';


Widget customListTile(String title,Function()? onTap)
{
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListTile(
      onTap:onTap ,
      leading: Icon(icons[title]),
      title: Text(title,style: blackPlainTextStyle,),
      
    ),
  );

}