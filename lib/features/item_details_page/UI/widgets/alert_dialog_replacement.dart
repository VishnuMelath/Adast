import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/%20themes/themes.dart';
import 'package:adast/features/item_details_page/bloc/item_details_bloc.dart';
import 'package:flutter/material.dart';

void replacementDialog(BuildContext context,ItemDetailsBloc itemDetailsBloc)
{
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text('Confirm',style: largeBlackTextStyle,),
      content: Text('Are you sure you want to replace ?',style: blackPlainTextStyle,),
      actions: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: green
          ),
          child: IconButton(onPressed: () {
            Navigator.pop(context);
           itemDetailsBloc.add(ItemReservationReplacementEvent());
          }, icon: const Icon(Icons.check_rounded,color: white,)),
        ),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: red
          ),
          child: IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: const Icon(Icons.clear_outlined,color: white,)),
        )
      ],
    ),);
}