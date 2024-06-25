import 'dart:async';
import 'dart:developer';

import 'package:adast/models/cloth_model.dart';
import 'package:adast/models/seller_model.dart';
import 'package:adast/services/item_database_services.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'seller_profile_event.dart';
part 'seller_profile_state.dart';

class SellerProfileBloc extends Bloc<SellerProfileEvent, SellerProfileState> {
  List<ClothModel> items = [];
  SellerModel sellerModel;
  SellerProfileBloc({required this.sellerModel})
      : super(SellerProfileInitial()) {
    on<SellerProfileItemLoadingEvent>(sellerProfileItemLoadingEvent);
  }

  FutureOr<void> sellerProfileItemLoadingEvent(
      SellerProfileItemLoadingEvent event,
      Emitter<SellerProfileState> emit) async {
    emit(SellerProfileItemsLoadingState());
    try {
      items.addAll(await ItemDatabaseServices().getAllItems(sellerModel.email));
      emit(SellerProfileItemsLoadedState());
    } on FirebaseException catch (e) {
      log(e.code);
    }
  }
}
