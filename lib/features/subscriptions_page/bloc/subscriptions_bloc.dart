import 'dart:async';

import 'package:adast/models/seller_model.dart';
import 'package:adast/services/seller_database_services.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meta/meta.dart';

part 'subscriptions_event.dart';
part 'subscriptions_state.dart';

class SubscriptionsBloc extends Bloc<SubscriptionsEvent, SubscriptionsState> {
  Map<String,SellerModel> subscriptions={};
  SubscriptionsBloc() : super(SubscriptionsInitial()) {
  on<SubscriptionsLoadingEvent>(subscriptionsLoadingEvent);
  }

  FutureOr<void> subscriptionsLoadingEvent(SubscriptionsLoadingEvent event, Emitter<SubscriptionsState> emit) async{
    emit(SubscriptionsLoadingState());
    try {
      for (var element in event.subscriptionsId) {
        if(!subscriptions.containsKey(element))
        {
          subscriptions[element]=await SellerDatabaseServices().getSeller(element);
        }
      }
      emit(SubscriptionsLoadedState());
    } on FirebaseException catch (e) {
      emit(SubscriptionsErrorState(error:e.code));
    }
  }
}
