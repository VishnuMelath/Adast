import 'package:flutter/material.dart';

import '../../../../ themes/themes.dart';

radio({required String label, required ValueNotifier groupValueNotifier,required String price}) {
  return Padding(
    padding: const EdgeInsets.only(right: 10.0),
    child: GestureDetector(
      onTap: () {
         groupValueNotifier.value = label;
      },
      child: Row(
        children: [
          ValueListenableBuilder(
            valueListenable: groupValueNotifier,
            builder: (context, value, _) => Radio(
                groupValue: groupValueNotifier.value,
                value: price,
                onChanged: (value) {
                  groupValueNotifier.value = price;
                }),
          ),
          Text(
              label,
              style: blackTextStyle,
            ),
            Expanded(
              
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '₹$price',
                  style: blackTextStyle,
                ),
              ),
            )
        ],
      ),
    ),
  );
}
