part of 'subscriptions_bloc.dart';

@immutable
sealed class SubscriptionsState {}

final class SubscriptionsInitial extends SubscriptionsState {}

class SubscriptionsLoadingState extends SubscriptionsState{}

class SubscriptionsLoadedState extends SubscriptionsState{}

class SubscriptionsErrorState extends SubscriptionsState{
  final String error;

  SubscriptionsErrorState({required this.error});
}