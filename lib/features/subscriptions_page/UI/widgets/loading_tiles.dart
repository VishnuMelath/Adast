import 'package:adast/features/chat/chat_list/UI/widgets/loading_tile.dart';
import 'package:flutter/material.dart';

class LoadingTilesSubscriptions extends StatelessWidget {
  final int length;
  const LoadingTilesSubscriptions({super.key,required this.length});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: length,
      itemBuilder: (context, index) =>const LoadingTile(),);
  }
}