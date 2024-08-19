import 'package:adast/%20themes/themes.dart';
import 'package:adast/features/chat/chat_list/UI/widgets/loading_tile.dart';
import 'package:adast/features/chat/chat_list/UI/widgets/reciever_tile.dart';
import 'package:adast/features/chat/chat_list/bloc/chat_list_bloc.dart';
import 'package:adast/features/splash_screen/bloc/splashscreen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../ themes/colors_shemes.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    ChatListBloc chatListBloc = context.read<ChatListBloc>()
      ..add(ChatListLoadingEvent(
          userId: context.read<SplashscreenBloc>().userModel!.email));
    return Container(
      color: white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: green,
                )),
            automaticallyImplyLeading: false,
            title: Text(
              'Inbox',
              style: greenTextStyle,
            ),
            backgroundColor: backgroundColor,
          ),
          body: BlocBuilder<ChatListBloc, ChatListState>(
            builder: (context, state) {
              if (state is ChatListLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (chatListBloc.sellers.isEmpty) {
                  return Center(
                      child: Text(
                    'No chats',
                    style: greyTextStyle,
                  ));
                } else {
                  return ListView(
                    children: [
                      ...chatListBloc.sellers.map(
                        (e) {
                          if (chatListBloc.loadedSellers.keys.contains(e)) {
                            return RecieverTile(
                                sellerModel: chatListBloc.loadedSellers[e]!);
                          } else {
                            chatListBloc
                                .add(ChatListTileLoadingEvent(sellerId: e));
                            return const LoadingTile();
                          }
                        },
                      ),
                    ],
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
