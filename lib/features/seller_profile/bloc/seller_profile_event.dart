part of 'seller_profile_bloc.dart';

@immutable
sealed class SellerProfileEvent {}

class SellerProfileItemTappedEvent extends SellerProfileEvent{}

class SellerProfileItemLoadingEvent extends SellerProfileEvent{
}

class SellerProfileMessageTappedEvent extends SellerProfileEvent{
final String userId;

  SellerProfileMessageTappedEvent({required this.userId});
}

class SellerProfileSubscribeUnsubEvent extends SellerProfileEvent{
  final UserModel userModel;
  final HomeBloc homeBloc;

  SellerProfileSubscribeUnsubEvent({required this.userModel,required this.homeBloc});
}

class SellerProfileAddReviewLoadingEvent extends SellerProfileEvent{
  final UserModel userModel;

  SellerProfileAddReviewLoadingEvent({required this.userModel});
}

class SellerProfileAddUpdateReviewEvent extends SellerProfileEvent{
  final RatingModel ratingModel;

  SellerProfileAddUpdateReviewEvent({required this.ratingModel});
}