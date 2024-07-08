part of 'item_details_bloc.dart';

@immutable
sealed class ItemDetailsEvent {}

class ItemDetailsSizeChangedEvent extends ItemDetailsEvent {
  final String size;

  ItemDetailsSizeChangedEvent({required this.size});
}

class ItemDetailsPageSwitchEvent extends ItemDetailsEvent{
final int index;

  ItemDetailsPageSwitchEvent({required this.index});
}

class ItemSaveUnSavePressedEvent extends ItemDetailsEvent{
  final String itemId;
  final UserModel userModel;

  ItemSaveUnSavePressedEvent({required this.userModel,required this.itemId});
}