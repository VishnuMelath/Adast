import 'package:adast/%20themes/colors_shemes.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingTile extends StatelessWidget {
  const LoadingTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListTile(
        leading: ClipRRect(

          borderRadius: BorderRadius.circular(20),
          child: Shimmer.fromColors(
            period: Durations.extralong4,
              baseColor: greentransparent,
              highlightColor: white,
              child: CircleAvatar(
                backgroundColor: backgroundColor,
              )),
        ),
        title:Shimmer.fromColors(
            period: Durations.extralong4,
              baseColor: greentransparent,
              highlightColor: white,
              child: Container(
                width: MediaQuery.sizeOf(context).width*0.6,
                height: 20,
                color: backgroundColor,
              )),
          subtitle: Shimmer.fromColors(
            period: Durations.extralong4,
              baseColor: greentransparent,
              highlightColor: white,
              child: Container(
                height: 10,
                color: backgroundColor,
              )),
      ),
    );
  }
}
