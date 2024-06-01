part of 'bottom_nav_bloc.dart';

@immutable
sealed class BottomNavState {}

final class BottomNavInitial extends BottomNavState {}

class BottomNavUserLoadingState extends BottomNavState{}

class BottomNavUserLoadingSuccessState extends BottomNavState{}

class BottomNavUserLoadingErrorState extends BottomNavState{}