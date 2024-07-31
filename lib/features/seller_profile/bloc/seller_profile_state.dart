part of 'seller_profile_bloc.dart';

@immutable
sealed class SellerProfileState {

}

final class SellerProfileInitial extends SellerProfileState {

}

class SellerProfileItemsLoadingState extends SellerProfileState{

}

class SellerProfileItemsLoadedState extends SellerProfileState{}

class SellerSubscribedState extends SellerProfileState{
}

class SellerProfileNavigateToChatState extends SellerProfileState{
 final ChatRoomModel chatRoomModel;

  SellerProfileNavigateToChatState({required this.chatRoomModel});
}

class SellerProfileErrorState extends SellerProfileState{
  final String error;

  SellerProfileErrorState({required this.error});
}

class SellerProfileReviewLoadingState extends SellerProfileState{}

class SellerProfileReviewLoadedState extends SellerProfileState{}

class SellerReviewSavingState extends SellerProfileState{}

class SellerReviewSavedState extends SellerProfileState{}