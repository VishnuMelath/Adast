import 'dart:async';
import 'dart:developer';
import 'package:adast/methods/network_check.dart';
import 'package:adast/models/cloth_model.dart';
import 'package:adast/models/seller_model.dart';
import 'package:adast/models/user_model.dart';
import 'package:adast/services/item_database_services.dart';
import 'package:adast/services/seller_database_services.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late UserModel userModel;
  Map<String,SellerModel> sellers = {};
  String? shopSelected;
  List<ClothModel> fullItemList = [];
  List<ClothModel> showingList = [];
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeSaveOrRemoveTappedEvent>(homeSaveOrRemoveTappedEvent);
    on<HomeSellerTappedEvent>(homeSellerTappedEvent);
  }

  FutureOr<void> homeSaveOrRemoveTappedEvent(
      HomeSaveOrRemoveTappedEvent event, Emitter<HomeState> emit) async {
    if (userModel.saved.contains(event.itemId)) {
      userModel.saved.remove(event.itemId);
    } else {
      userModel.saved.add(event.itemId);
    }
    emit(HomeItemSavedUnSavedState());
  }

  FutureOr<void> homeSellerTappedEvent(
      HomeSellerTappedEvent event, Emitter<HomeState> emit) {
        shopSelected=event.email;
        if(shopSelected==null)
        {
          showingList=fullItemList;
        }
        else
        {
          showingList=fullItemList.where((element) => element.sellerID==shopSelected,).toList();
        }
        emit(HomeShopSelectedState());
      }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    userModel = event.userModel;
    emit(HomeLoadingState());
    if (!await hasNetwork()) {
      emit(HomeErrorState(error: 'please check your network connection'));
    } else {
      emit(HomeLoadedState());
      try {
        for (var value in userModel.subscriptions) {
          log(value);
          var seller=await SellerDatabaseServices().getSeller(value);
          sellers[seller.email]=seller;
        }

        fullItemList = await ItemDatabaseServices()
            .getItemOfSubscribedSeller(userModel.subscriptions);
            showingList=fullItemList;
        emit(HomeLoadedState());
      } on FirebaseException catch (e) {
        log(e.toString());
        emit(HomeErrorState(error: e.code));
      }
    }
  }
}
