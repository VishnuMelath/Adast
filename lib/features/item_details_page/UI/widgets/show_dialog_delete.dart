
import 'package:flutter/material.dart';

import '../../../../ themes/colors_shemes.dart';
import '../../../../ themes/themes.dart';

showDialogueDelete(BuildContext context,  {required void Function() onPressed}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        title: const Text('Delete'),
        content: const Text('are you sure you want to delete?'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('cancel'),
          ),
          ElevatedButton(
            style:const ButtonStyle(backgroundColor: WidgetStatePropertyAll(green)),
            onPressed: onPressed,
            child:  Text(
              'confirm',
              style: whiteTextStyle,
            ),
          )
        ],
      );
    },
  );
}
