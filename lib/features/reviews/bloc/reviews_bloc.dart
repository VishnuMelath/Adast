import 'dart:async';

import 'package:adast/models/rating_model.dart';
import 'package:adast/models/seller_model.dart';
import 'package:adast/models/user_model.dart';
import 'package:adast/services/rating_database_services.dart';
import 'package:adast/services/user_database_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'reviews_event.dart';
part 'reviews_state.dart';

class ReviewsBloc extends Bloc<ReviewsEvent, ReviewsState> {
  List<RatingModel> ratings=[];
  Map<String,UserModel> users={};
  SellerModel sellerModel;
  ReviewsBloc({required this.sellerModel}) : super(ReviewsInitial()) {
    on<ReviewsLoadingEvent>(reviewsLoadingEvent);
  }

  FutureOr<void> reviewsLoadingEvent(ReviewsLoadingEvent event, Emitter<ReviewsState> emit) async{
    emit(ReviewsLoadingState());
    ratings=await RatingDatabaseServices().getAllRatings(event.sellerId);
    for (var element in ratings) {
      if(!users.containsKey(element.id))
      {
        users[element.id!]=await UserDatabaseServices().getUserById(element.userId); 
      }
      
    }
    emit(ReviewsLoadedState());
  }
}
