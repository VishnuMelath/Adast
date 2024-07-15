import 'dart:async';

import 'package:adast/models/chat_room_model.dart';
import 'package:adast/models/seller_model.dart';
import 'package:adast/services/chat_room_database_services.dart';
import 'package:adast/services/seller_database_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chat_list_event.dart';
part 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  List<ChatRoomModel> chatrooms=[];
  Set<String> sellers = {};
  Map<String ,SellerModel> loadedSellers={};
  ChatListBloc() : super(ChatListInitial()) {
    on<ChatListLoadingEvent>(chatListLoadingEvent);
    on<ChatListTileLoadingEvent>(chatListTileLoadingEvent);
  }

  FutureOr<void> chatListLoadingEvent(
      ChatListLoadingEvent event, Emitter<ChatListState> emit) async {
    emit(ChatListLoadingState());
   
   await emit.forEach(
     ChatRoomDatabaseServices().getAllChatRooms(event.userId),
      onData: (data) {
        chatrooms.clear();
        for (var element in data.docs) {
          chatrooms.add(ChatRoomModel.fromSnapShot(element));
        }
        chatrooms.sort((a, b) => b.time.compareTo(a.time),);
        sellers.clear();
        sellers.addAll(chatrooms.map((e) => e.sellerId,));
        return ChatListLoadedState();
      },
    );
  }

  FutureOr<void> chatListTileLoadingEvent(ChatListTileLoadingEvent event, Emitter<ChatListState> emit) async{
    var seller=await SellerDatabaseServices().getSeller(event.sellerId);
    loadedSellers[event.sellerId]=seller;
    emit(ChatListTileLoadedState());
  }
}
