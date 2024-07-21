import 'dart:async';

import 'package:adast/models/chat_room_model.dart';
import 'package:adast/models/seller_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../../services/chat_room_database_services.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SellerModel sellerModel;
  final ChatRoomModel chatRoomModel;
  ChatBloc({required this.sellerModel,required this.chatRoomModel}) : super(ChatInitial()) {
   on<ChatSetUserUnseenCountZero>(chatSetUserUnseenCountZero);
  }
  FutureOr<void> chatSetUserUnseenCountZero(ChatSetUserUnseenCountZero event, Emitter<ChatState> emit) async{
    try { 
      chatRoomModel.sellerUnreadCount=0;
       ChatRoomDatabaseServices().updateChatRoomUnseenCount(chatRoomModel);
    } on FirebaseException catch (_) {

      
    }
  }
}
