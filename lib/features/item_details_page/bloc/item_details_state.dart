part of 'item_details_bloc.dart';

@immutable
sealed class ItemDetailsState {}

final class ItemDetailsInitial extends ItemDetailsState {}

class ItemDetailsSizeChangedState extends ItemDetailsState{}

class ItemDetailsPageChangedState extends ItemDetailsState{}

class ItemSavedChangedState extends ItemDetailsState{}

class ItemDetailsLoadingState extends ItemDetailsState{}

class ItemDetailsLoadedState extends ItemDetailsState{}