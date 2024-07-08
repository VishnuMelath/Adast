part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class SearchInitialEvent extends SearchEvent{}

class SearchValueChangedEvent extends SearchEvent{
}