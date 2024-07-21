import 'dart:async';

import 'package:adast/models/cloth_model.dart';
import 'package:adast/services/item_database_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'saved_event.dart';
part 'saved_state.dart';

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  Map<String, ClothModel> items = {};
  SavedBloc() : super(SavedInitial()) {
    on<SavedItemsLoadingEvent>(savedItemsLoadingEvent);
  }

  FutureOr<void> savedItemsLoadingEvent(
      SavedItemsLoadingEvent event, Emitter<SavedState> emit) async {
    emit(SavedLoadingState());
    for (var element in event.ids) {
      if (!items.containsKey(element)) {
        items[element] = await ItemDatabaseServices().getItem(element);
      }
    }
    emit(SavedLoadedState());
  }
}
