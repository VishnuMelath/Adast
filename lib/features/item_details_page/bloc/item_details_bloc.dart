import 'dart:async';

import 'package:adast/models/cloth_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'item_details_event.dart';
part 'item_details_state.dart';

class ItemDetailsBloc extends Bloc<ItemDetailsEvent, ItemDetailsState> {
   ClothModel item;
   String? selectedSize;
   int page=1;
  ItemDetailsBloc({required this.item}) : super(ItemDetailsInitial()) {
    on<ItemDetailsSizeChangedEvent>(itemDetailsSizeChangedEvent);
    on<ItemDetailsPageSwitchEvent>(itemDetailsPageSwitchEvent);
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
}
