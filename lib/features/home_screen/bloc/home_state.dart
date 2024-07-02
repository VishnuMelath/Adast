part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class HomeShopSelectedState extends HomeState{}

class HomeItemSavedUnSavedState extends HomeState{}

class HomeLoadingState extends HomeState{}

class HomeLoadedState extends HomeState{}

class HomeErrorState extends HomeState{final String error;

  HomeErrorState({required this.error});}