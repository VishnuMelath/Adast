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
