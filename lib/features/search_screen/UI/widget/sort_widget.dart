import 'package:adast/features/search_screen/bloc/search_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../ themes/themes.dart';
import 'custom_checkbox.dart';

void showSortBottomSheet(BuildContext context, SearchBloc searchBloc) {
  showModalBottomSheet(
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    isDismissible: true,
    context: context,
    builder: (context) => Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding:  EdgeInsets.only(left: MediaQuery.sizeOf(context).width*.0),
          child: Text('Sort by',style: greyTextStyle,),
        ),
        CustomCheckbox(label: 'price : low to high', searchBloc: searchBloc, index: 1),
        CustomCheckbox(label: 'price : high to low', searchBloc: searchBloc, index: 2),
        CustomCheckbox(label: 'item : new to old', searchBloc: searchBloc, index: 3),
        CustomCheckbox(label: 'item : old to new', searchBloc: searchBloc, index: 4),
        const SizedBox(height: 30,)
      ],
    ),
  );
}
