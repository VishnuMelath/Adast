part of 'item_details_bloc.dart';

@immutable
sealed class ItemDetailsEvent {}

class ItemDetailsSizeChangedEvent extends ItemDetailsEvent {
  final String size;

  ItemDetailsSizeChangedEvent({required this.size});
}