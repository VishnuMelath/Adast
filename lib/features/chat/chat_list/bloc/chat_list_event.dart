part of 'chat_list_bloc.dart';

@immutable
sealed class ChatListEvent {}

class ChatListLoadingEvent extends ChatListEvent{
  final String userId;

  ChatListLoadingEvent({required this.userId});
}

class ChatListTileLoadingEvent extends ChatListEvent{
  final String sellerId;

  ChatListTileLoadingEvent({required this.sellerId});
}