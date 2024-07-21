part of 'saved_bloc.dart';

@immutable
sealed class SavedEvent {}

class SavedItemsLoadingEvent extends SavedEvent{
 final List ids;

  SavedItemsLoadingEvent({required this.ids});
}