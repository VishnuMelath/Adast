part of 'replace_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

class SearchLoadingState extends SearchState{}

class SearchLoadedState extends SearchState{}

class SearchEmptyState extends SearchState{}

class SearchErrorState extends SearchState{
  final String error;

  SearchErrorState({required this.error});
}