part of 'subscriptions_bloc.dart';

@immutable
sealed class SubscriptionsEvent {}

class SubscriptionsLoadingEvent extends SubscriptionsEvent{
 final List subscriptionsId;

  SubscriptionsLoadingEvent({required this.subscriptionsId});
}