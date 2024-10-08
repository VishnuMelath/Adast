import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../ themes/colors_shemes.dart';
import '../../../chat/chat_list/UI/chat_list_page.dart';
import '../../../chat/chat_list/bloc/chat_list_bloc.dart';

SliverAppBar sliverAppBar({required BuildContext context}) {
  return SliverAppBar(
    backgroundColor: backgroundColor,
    titleSpacing: 0,
    title: Align(
      alignment: Alignment.centerLeft,
      child: Image.asset(
        'assets/images/logo.png',
        height: 100,
      ),
    ),
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              backgroundColor,
              white,
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: const [0.0, 1.0],
            tileMode: TileMode.mirror),
      ),
    ),
    elevation: 1,
    stretch: true,
    floating: true,
    actions: [
      IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => ChatListBloc(),
                    child: const ChatListPage(),
                  ),
                ));
          },
          icon: const Icon(
            Icons.chat_bubble_outline,
            color: green,
          ))
    ],
  );
}
