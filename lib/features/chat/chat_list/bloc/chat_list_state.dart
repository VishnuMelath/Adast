part of 'chat_list_bloc.dart';

@immutable
sealed class ChatListState {}

final class ChatListInitial extends ChatListState {}

class ChatListLoadingState extends ChatListState{}

class ChatListLoadedState extends ChatListState{}

class ChatListTileLoadingState extends ChatListState{}

class ChatListTileLoadedState extends ChatListState{}
