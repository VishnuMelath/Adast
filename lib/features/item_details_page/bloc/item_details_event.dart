part of 'item_details_bloc.dart';

@immutable
sealed class ItemDetailsEvent {}

class ItemDetailsSizeChangedEvent extends ItemDetailsEvent {
  final String size;

  ItemDetailsSizeChangedEvent({required this.size});
}

class ItemDetailsPageSwitchEvent extends ItemDetailsEvent{
final int index;

  ItemDetailsPageSwitchEvent({required this.index});
}

class ItemSaveUnSavePressedEvent extends ItemDetailsEvent{
  final String itemId;
  final UserModel userModel;

  ItemSaveUnSavePressedEvent({required this.userModel,required this.itemId});
}

class ItemSellerLoadingEvent extends ItemDetailsEvent{}

class ItemsReserverPressedEvent extends ItemDetailsEvent{}

class ItemReservationPaymentEvent extends ItemDetailsEvent{
  final Map<String, dynamic> options;

  ItemReservationPaymentEvent({required this.options});
}

class ItemReservationPaymentCompletionEvent extends ItemDetailsEvent{
 final Map<String,dynamic>? options;
 final PaymentSuccessResponse? response;

  ItemReservationPaymentCompletionEvent({ this.options, this.response});
}

class ItemReservationReplacementEvent extends ItemDetailsEvent{}