part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeSellerTappedEvent extends HomeEvent{
  final String? email;

  HomeSellerTappedEvent({required this.email});
}

class HomeSaveOrRemoveTappedEvent extends HomeEvent{
  final UserModel userModel;
  final String itemId;

  HomeSaveOrRemoveTappedEvent({required this.userModel,required this.itemId});
}

class HomeInitialEvent extends HomeEvent{
  final UserModel userModel;

  HomeInitialEvent({required this.userModel});

}

