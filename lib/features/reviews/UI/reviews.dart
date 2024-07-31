import 'package:adast/features/reviews/UI/widgets/loaded_reviews_body.dart';
import 'package:adast/features/reviews/UI/widgets/loaded_tile.dart';
import 'package:adast/features/reviews/bloc/reviews_bloc.dart';
import 'package:adast/features/splash_screen/bloc/splashscreen_bloc.dart';
import 'package:adast/models/seller_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewsWidget extends StatelessWidget {
  final SellerModel sellerModel;
  const ReviewsWidget({super.key, required this.sellerModel});

  @override
  Widget build(BuildContext context) {
    ReviewsBloc reviewsBloc=ReviewsBloc(sellerModel: sellerModel)..add(ReviewsLoadingEvent(sellerId:sellerModel.id!));
    return  Scaffold(
      appBar: AppBar(),
      body: BlocBuilder(
        bloc: reviewsBloc,
        builder: (context, state) {
        if(state is ReviewsLoadingState)
        {
          return const Center(child: CircularProgressIndicator(),);
        }
        else{
        return  loadedReviews(context, reviewsBloc);
        }
      },),
    );
  }
}