import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/%20themes/themes.dart';
import 'package:adast/features/chat/chat_screen/UI/chat_screen.dart';
import 'package:adast/features/chat/chat_screen/bloc/chat_bloc.dart';
import 'package:adast/methods/common_methods.dart';
import 'package:adast/models/chat_room_model.dart';
import 'package:adast/models/seller_model.dart';
import 'package:adast/services/chat_room_database_services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/chat_list_bloc.dart';

class RecieverTile extends StatelessWidget {
  final SellerModel sellerModel;
  const RecieverTile({super.key, required this.sellerModel});

  @override
  Widget build(BuildContext context) {
    ChatListBloc chatListBloc = context.read<ChatListBloc>();
    ChatRoomModel chatRoomModel = chatListBloc.chatrooms.firstWhere(
      (element) => sellerModel.email == element.sellerId,
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: () async {
          chatRoomModel.userUnreadCount = 0;
           ChatRoomDatabaseServices().updateChatRoom(chatRoomModel);
          Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => ChatBloc(
                          sellerModel: sellerModel,
                          chatRoomModel: chatListBloc.chatrooms.firstWhere(
                            (element) => element.sellerId == sellerModel.email,
                          )),
                      child: const ChatScreen(),
                    ),
                  ));
        },
        leading: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CachedNetworkImage(width: 40, imageUrl: sellerModel.image!)),
        title: Text(
          capitalize(sellerModel.name),
          style: blackTextStyle,
        ),
        subtitle: Text(
          chatRoomModel.lastMessage,
          style: greySmallTextStyle,
        ),
        trailing: Visibility(
          visible: chatRoomModel.userUnreadCount != 0,
          child: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  color: green, borderRadius: BorderRadius.circular(15)),
              padding: const EdgeInsets.all(5),
              child: Center(
                child: Text(
                  chatRoomModel.userUnreadCount.toString(),
                  style: whiteTextStyle,
                ),
              )),
        ),
      ),
    );
  }
}
