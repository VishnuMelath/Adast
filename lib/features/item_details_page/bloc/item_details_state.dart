part of 'item_details_bloc.dart';

@immutable
sealed class ItemDetailsState {}

final class ItemDetailsInitial extends ItemDetailsState {}

class ItemDetailsSizeChangedState extends ItemDetailsState{}