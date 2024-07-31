import 'dart:async';
import 'dart:developer';

import 'package:adast/constants/constants.dart';
import 'package:adast/features/item_details_page/methods/itemsleft.dart';
import 'package:adast/services/item_database_services.dart';
import 'package:adast/services/methods/network_check.dart';
import 'package:adast/models/cloth_model.dart';
import 'package:adast/models/reservation_model.dart';
import 'package:adast/models/seller_model.dart';
import 'package:adast/models/user_model.dart';
import 'package:adast/services/reservation_databaase_services.dart';
import 'package:adast/services/seller_database_services.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../services/user_database_services.dart';

part 'item_details_event.dart';
part 'item_details_state.dart';

class ItemDetailsBloc extends Bloc<ItemDetailsEvent, ItemDetailsState> {
  ReservationModel? reservationModel;
  bool replace = false;
  bool success = true;
  ClothModel item;
  Map<String, dynamic> options = {};
  SellerModel? sellerModel;
  String? selectedSize;
  int page = 1;
  ItemDetailsBloc({required this.item}) : super(ItemDetailsInitial()) {
    on<ItemDetailsSizeChangedEvent>(itemDetailsSizeChangedEvent);
    on<ItemDetailsPageSwitchEvent>(itemDetailsPageSwitchEvent);
    on<ItemSaveUnSavePressedEvent>(itemSaveUnSavePressedEvent);
    on<ItemSellerLoadingEvent>(itemSellerLoadingEvent);
    on<ItemsReserverPressedEvent>(itemsReservePressedEvent);
    on<ItemReservationPaymentEvent>(itemReservationPaymentEvent);
    on<ItemReservationPaymentCompletionEvent>(
        itemReservationPaymentCompletionEvent);
    on<ItemReservationReplacementEvent>(itemReservationReplacementEvent);
  }

  FutureOr<void> itemDetailsSizeChangedEvent(
      ItemDetailsSizeChangedEvent event, Emitter<ItemDetailsState> emit) {
    if (event.size == selectedSize) {
      selectedSize = null;
    } else {
      selectedSize = event.size;
    }

    emit(ItemDetailsSizeChangedState());
  }

  FutureOr<void> itemDetailsPageSwitchEvent(
      ItemDetailsPageSwitchEvent event, Emitter<ItemDetailsState> emit) {
    page = event.index;
    emit(ItemDetailsPageChangedState());
  }

  FutureOr<void> itemSaveUnSavePressedEvent(
      ItemSaveUnSavePressedEvent event, Emitter<ItemDetailsState> emit) async {
    if (event.userModel.saved.contains(event.itemId)) {
      event.userModel.saved.remove(event.itemId);
    } else {
      event.userModel.saved.add(event.itemId);
    }
    await UserDatabaseServices().updateUser(event.userModel);
    emit(ItemSavedChangedState());
  }

  FutureOr<void> itemSellerLoadingEvent(
      ItemSellerLoadingEvent event, Emitter<ItemDetailsState> emit) async {
    emit(ItemDetailsLoadingState());
    sellerModel = await SellerDatabaseServices().getSeller(item.sellerID);
    emit(ItemDetailsLoadedState());
  }

  FutureOr<void> itemsReservePressedEvent(
      ItemsReserverPressedEvent event, Emitter<ItemDetailsState> emit) {
    if (selectedSize == null) {
      emit(ItemDetailsErrorState(error: 'Please select a size'));
    } else {
      var itemsLeft = itemsLeftPerSize(item, selectedSize!);
      if (itemsLeft == 0) {
        emit(ItemDetailsErrorState(error: 'Items not available for that size'));
      } else {
        emit(ItemShowBottomSheetState());
      }
    }
  }

  FutureOr<void> itemReservationPaymentEvent(
      ItemReservationPaymentEvent event, Emitter<ItemDetailsState> emit) async {
    var razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
        PaymentHandler(itemDetailsBloc: this).handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        PaymentHandler(itemDetailsBloc: this).handlePaymentSuccessResponse);
    if ((await hasNetwork())) {
      try {
        options = event.options;
        razorpay.open(options);
      } catch (e) {
        emit(ItemDetailPaymentErrorState());
      }
    } else {
      emit(
          ItemDetailsErrorState(error: 'please check your network connection'));
    }
  }

  FutureOr<void> itemReservationPaymentCompletionEvent(
      ItemReservationPaymentCompletionEvent event,
      Emitter<ItemDetailsState> emit) async {
        emit(ItemDetailsLoadingState());
    var days = 0;
    switch (event.options!['amount']) {
      case 1000:
        days = 1;
        break;
      case 3000:
        days = 2;
        break;
      case 4000:
        days = 3;
        break;
      case 5000:
        days = 4;
        break;
      default:
        days = 0;
        break;
    }
    if (success) {
      reservationModel = ReservationModel(
          size: selectedSize!,
          amount: event.options!['amount'],
          id: null,
          days: days,
          transactionId: event.response!.paymentId!,
          sellerId: sellerModel!.email,
          itemId: item.id!,
          userId: event.options!['prefill']['buyer'],
          reservationTime: DateTime.now(),
          status: ReservationStatus.reserved.name);

      await ReservationDatabaseServices()
          .addReservation(reservationModel!)
          .then(
        (value) async {
          if (!item.reservedCount.containsKey(selectedSize)) {
            item.reservedCount[selectedSize!] = 0;
          }
          var temp = int.parse(item.reservedCount[selectedSize!].toString());
          temp += 1;
          item.reservedCount[selectedSize!] = temp;
          item.revenue += reservationModel!.amount;
          await ItemDatabaseServices().updateItem(item);
          await SellerDatabaseServices().updateSellerWallet(reservationModel!.amount,reservationModel!.sellerId);
          emit(ItemDetailPaymentSuccessState(
              reservationModel: reservationModel!));
        },
      );
    } else {
      emit(ItemDetailPaymentErrorState());
    }
  }

  FutureOr<void> itemReservationReplacementEvent(
      ItemReservationReplacementEvent event,
      Emitter<ItemDetailsState> emit) async {
    reservationModel!.itemId = item.id!;
    log(selectedSize.toString());
    try {
      if (selectedSize == null) {
        emit(ItemDetailsErrorState(error: 'Please select a size'));
      } else {
        var itemsLeft = itemsLeftPerSize(item, selectedSize!);
        if (itemsLeft == 0) {
          emit(ItemDetailsErrorState(
              error: 'Items not available for that size'));
        } else {
          await ReservationDatabaseServices()
              .updateReservation(reservationModel!);
          if (!item.reservedCount.containsKey(selectedSize)) {
            item.reservedCount[selectedSize!] = 0;
          }
          var temp = int.parse(item.reservedCount[selectedSize!].toString());
          temp += 1;
          item.reservedCount[selectedSize!] = temp;
          item.revenue += reservationModel!.amount;
          await ItemDatabaseServices().updateItem(item);
          emit(ItemReservationReplacedState());
        }
      }
    } on FirebaseException catch (e) {
      emit(ItemDetailsErrorState(error: e.toString()));
    }
  }
}

class PaymentHandler {
  final ItemDetailsBloc itemDetailsBloc;
  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    itemDetailsBloc.add(ItemReservationPaymentCompletionEvent());
  }

//
  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    itemDetailsBloc.add(ItemReservationPaymentCompletionEvent(
        options: itemDetailsBloc.options, response: response));
  }

  PaymentHandler({required this.itemDetailsBloc});
}
