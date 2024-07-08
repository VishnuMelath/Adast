import 'dart:async';

import 'package:adast/models/cloth_model.dart';
import 'package:adast/models/seller_model.dart';
import 'package:adast/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../services/user_database_services.dart';

part 'item_details_event.dart';
part 'item_details_state.dart';

class ItemDetailsBloc extends Bloc<ItemDetailsEvent, ItemDetailsState> {
   ClothModel item;
   SellerModel sellerModel;
   String? selectedSize;
   int page=1;
  ItemDetailsBloc({required this.item,required this.sellerModel}) : super(ItemDetailsInitial()) {
    on<ItemDetailsSizeChangedEvent>(itemDetailsSizeChangedEvent);
    on<ItemDetailsPageSwitchEvent>(itemDetailsPageSwitchEvent);
    on<ItemSaveUnSavePressedEvent>(itemSaveUnSavePressedEvent);
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
}
