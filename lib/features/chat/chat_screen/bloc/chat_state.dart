part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

class ChatLoadedState extends ChatState{}

class ChatLoadingState extends ChatState{}