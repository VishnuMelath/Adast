import 'package:adast/%20themes/colors_shemes.dart';
import 'package:flutter/material.dart';

import '../../../../../ themes/themes.dart';

class SortFilterWidget extends StatelessWidget {
  final void Function()? onTap;
  final IconData icons;
  final String label;
  const SortFilterWidget(
      {super.key, this.onTap, required this.icons, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
        decoration: BoxDecoration(border: Border.all(color: grey)),
        child: InkWell(
          onTap: onTap,
          child: Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icons,color: grey,),
                Text(label, style: greyMediumTextStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
