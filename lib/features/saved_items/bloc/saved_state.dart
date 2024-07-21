part of 'saved_bloc.dart';

@immutable
sealed class SavedState {}

final class SavedInitial extends SavedState {}

class SavedErrorState extends SavedState{
  final String error;
  SavedErrorState({required this.error});
}

class SavedLoadedState extends SavedState{}

class SavedLoadingState extends SavedState{}