import 'package:adast/%20themes/themes.dart';
import 'package:flutter/material.dart';

Widget errorMsg({required String msg})
{
  return  SliverFillRemaining(child:  Center(child: Text(msg,style: greyMediumTextStyle,),));
}

Widget circularLoading()
{
 return const SliverFillRemaining(child:  Center(child: CircularProgressIndicator(),));
}