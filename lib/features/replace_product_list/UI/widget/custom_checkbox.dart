


import 'package:flutter/material.dart';

import '../../../../ themes/themes.dart';
import '../../bloc/replace_bloc.dart';

class CustomCheckbox extends StatelessWidget {
  final String label;
  final SearchBloc searchBloc;
  final int index;
  const CustomCheckbox(
      {super.key,
      required this.label,
      required this.searchBloc,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          groupValue: searchBloc.sortOption,
          value: index,
          onChanged: (value) {
            searchBloc.sortOption=value as int;
            searchBloc.add(SearchValueChangedEvent());
            Navigator.pop(context);
          },
        ),
        Text(
          label,
          style: blackTextStyle,
        )
      ],
    );
  }
}
