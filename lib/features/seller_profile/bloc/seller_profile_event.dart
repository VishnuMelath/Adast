part of 'seller_profile_bloc.dart';

@immutable
sealed class SellerProfileEvent {}

class SellerProfileItemTappedEvent extends SellerProfileEvent{}

class SellerProfileItemLoadingEvent extends SellerProfileEvent{
}

class SellerProfileMessageTappedEvent extends SellerProfileEvent{}

class SellerProfileSubscribeUnsubEvent extends SellerProfileEvent{}