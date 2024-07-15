import 'dart:async';

import 'package:adast/features/item_details_page/methods/itemsleft.dart';
import 'package:adast/models/cloth_model.dart';
import 'package:adast/models/seller_model.dart';
import 'package:adast/models/user_model.dart';
import 'package:adast/services/seller_database_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../services/user_database_services.dart';

part 'item_details_event.dart';
part 'item_details_state.dart';

class ItemDetailsBloc extends Bloc<ItemDetailsEvent, ItemDetailsState> {
   ClothModel item;
   SellerModel? sellerModel;
   String? selectedSize;
   int page=1;
  ItemDetailsBloc({required this.item}) : super(ItemDetailsInitial()) {
    on<ItemDetailsSizeChangedEvent>(itemDetailsSizeChangedEvent);
    on<ItemDetailsPageSwitchEvent>(itemDetailsPageSwitchEvent);
    on<ItemSaveUnSavePressedEvent>(itemSaveUnSavePressedEvent);
    on<ItemSellerLoadingEvent>(itemSellerLoadingEvent);
    on<ItemsReserverPressedEvent>(itemsReservePressedEvent);
  }

    FutureOr<void> itemDetailsSizeChangedEvent(
      ItemDetailsSizeChangedEvent event, Emitter<ItemDetailsState> emit) {
        if(event.size==selectedSize)
        {
          selectedSize=null;
        }
        else{
          selectedSize = event.size;
        }
    
    emit(ItemDetailsSizeChangedState());
  }

  FutureOr<void> itemDetailsPageSwitchEvent(ItemDetailsPageSwitchEvent event, Emitter<ItemDetailsState> emit) {
    page=event.index;
    emit(ItemDetailsPageChangedState());
  }

  FutureOr<void> itemSaveUnSavePressedEvent(ItemSaveUnSavePressedEvent event, Emitter<ItemDetailsState> emit) async{
     if (event.userModel.saved.contains(event.itemId)) {
      event.userModel.saved.remove(event.itemId);
    } else {
     event. userModel.saved.add(event.itemId);
    }
    await  UserDatabaseServices().updateUser(event.userModel);
    emit(ItemSavedChangedState());
  }

  FutureOr<void> itemSellerLoadingEvent(ItemSellerLoadingEvent event, Emitter<ItemDetailsState> emit) async{
    emit(ItemDetailsLoadingState());
    sellerModel=await SellerDatabaseServices().getSeller(item.sellerID);
    emit(ItemDetailsLoadedState());
  }

  FutureOr<void> itemsReservePressedEvent(ItemsReserverPressedEvent event, Emitter<ItemDetailsState> emit) {
    
    if(selectedSize==null)
    {
      emit(ItemDetailsErrorState(error: 'Please select a size'));
    }
    else{
      var itemsLeft=itemsLeftPerSize(item, selectedSize!);
      if(itemsLeft==0)
      {
        emit(ItemDetailsErrorState(error: 'No items available for that size'));
      }
      else
      {
        emit(ItemShowBottomSheetState());
      }
    }
  }
}
