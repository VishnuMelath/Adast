import 'package:adast/%20themes/colors_shemes.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget loadingTiles(int length, BuildContext context) {
  var temp=(length / 3).ceil();
  return ListView(
    children: List.generate(
      temp,
      (index) => loadingRow(context,length,temp==index+1),
    ),
  );
}

Widget loadingRow(BuildContext context,int length,bool last) {
  return Row(
    children: List.generate(
      3,
      (index) {
        return loadingTile(context,
      index>=(length%3)&&last
      );
      },
    ),
  );
}

Widget loadingTile(BuildContext context,bool notvisible) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(1.0),
      child: Visibility(
        visible: !notvisible,
        child: Shimmer.fromColors(
          period: const Duration(seconds: 2),
          baseColor: Colors.grey[300]!,
          highlightColor: greentransparent,
          child: Container(
              margin: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                  color: backgroundColor,),
              height: ((MediaQuery.sizeOf(context).width / 3) - 6) * 1.5),
        ),
      ),
    ),
  );
}
