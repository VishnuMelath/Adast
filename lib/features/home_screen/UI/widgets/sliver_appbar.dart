import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../ themes/colors_shemes.dart';
import '../../../chat/chat_list/UI/chat_list_page.dart';
import '../../../chat/chat_list/bloc/chat_list_bloc.dart';

SliverAppBar sliverAppBar({required BuildContext context})
{
  return  SliverAppBar(
                      titleSpacing: 0,
                      title: Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 100,
                        ),
                      ),
                      elevation: 10,
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