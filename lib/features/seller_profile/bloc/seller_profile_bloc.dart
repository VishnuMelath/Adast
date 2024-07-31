import 'dart:async';
import 'dart:developer';

import 'package:adast/features/home_screen/bloc/home_bloc.dart';
import 'package:adast/models/chat_room_model.dart';
import 'package:adast/models/cloth_model.dart';
import 'package:adast/models/rating_model.dart';
import 'package:adast/models/seller_model.dart';
import 'package:adast/models/user_model.dart';
import 'package:adast/services/chat_room_database_services.dart';
import 'package:adast/services/item_database_services.dart';
import 'package:adast/services/messages_database_services.dart';
import 'package:adast/services/rating_database_services.dart';
import 'package:adast/services/reservation_databaase_services.dart';
import 'package:adast/services/user_database_services.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'seller_profile_event.dart';
part 'seller_profile_state.dart';

class SellerProfileBloc extends Bloc<SellerProfileEvent, SellerProfileState> {
  late bool subscribed;
  List<ClothModel> items = [];
  SellerModel sellerModel;
  RatingModel? ratingModel;
  bool reviewable = false;

  SellerProfileBloc({required this.sellerModel, required this.subscribed})
      : super(SellerProfileInitial()) {
    on<SellerProfileItemLoadingEvent>(sellerProfileItemLoadingEvent);
    on<SellerProfileSubscribeUnsubEvent>(sellerProfileSubscribeUnsubEvent);
    on<SellerProfileMessageTappedEvent>(sellerProfileMessageTappedEvent);
    on<SellerProfileAddReviewLoadingEvent>(sellerProfileAddReviewLoadingEvent);
    on<SellerProfileAddUpdateReviewEvent>(sellerProfileAddUpdateReviewEvent);
  }

  FutureOr<void> sellerProfileItemLoadingEvent(
      SellerProfileItemLoadingEvent event,
      Emitter<SellerProfileState> emit) async {
    emit(SellerProfileItemsLoadingState());
    try {
      items.addAll(
          await ItemDatabaseServices().getAllSellerItems(sellerModel.email));
      emit(SellerProfileItemsLoadedState());
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  FutureOr<void> sellerProfileSubscribeUnsubEvent(
      SellerProfileSubscribeUnsubEvent event,
      Emitter<SellerProfileState> emit) async {
    subscribed = !subscribed;
    if (subscribed) {
      event.userModel.subscriptions.add(sellerModel.email);
    } else {
      event.userModel.subscriptions.remove(sellerModel.email);
    }
    event.homeBloc.add(HomeInitialEvent(userModel: event.userModel));

    await UserDatabaseServices().updateUser(event.userModel);
    emit(SellerSubscribedState());
  }

  FutureOr<void> sellerProfileMessageTappedEvent(
      SellerProfileMessageTappedEvent event,
      Emitter<SellerProfileState> emit) async {
    try {
      ChatRoomModel chatRoomModel = await ChatRoomDatabaseServices()
          .checkWheatherChatroomExists(sellerModel.email, event.userId);
      chatRoomModel.roomId =
          MessagesDatabaseServices().generateChatRoomId(chatRoomModel);
      emit(SellerProfileNavigateToChatState(chatRoomModel: chatRoomModel));
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  FutureOr<void> sellerProfileAddReviewLoadingEvent(
      SellerProfileAddReviewLoadingEvent event,
      Emitter<SellerProfileState> emit) async {
        emit(SellerProfileReviewLoadingState());
    reviewable = await ReservationDatabaseServices()
        .checkPurchased(sellerModel.email, event.userModel.email);
        log(reviewable.toString());
    if (reviewable) {
      ratingModel = await RatingDatabaseServices()
          .checkReview(event.userModel.id!, sellerModel.id!);
    }
    emit(SellerProfileReviewLoadedState());
  }

  FutureOr<void> sellerProfileAddUpdateReviewEvent(SellerProfileAddUpdateReviewEvent event, Emitter<SellerProfileState> emit) async{
    emit(SellerReviewSavingState());
    await RatingDatabaseServices().addRating(event.ratingModel);
    emit(SellerReviewSavedState());
  }
}
