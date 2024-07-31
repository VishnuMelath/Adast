import 'package:adast/%20themes/themes.dart';
import 'package:adast/features/reviews/UI/widgets/loaded_tile.dart';
import 'package:adast/features/reviews/UI/widgets/star_widget.dart';
import 'package:adast/features/reviews/bloc/reviews_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../custom_widgets/custom_cached_network_image.dart';
import '../../../../services/methods/common_methods.dart';

Widget loadedReviews(BuildContext context,ReviewsBloc reviewsBloc)
{

  double overallRating=0;
  if (reviewsBloc.ratings.isNotEmpty) {
  for(var items in reviewsBloc.ratings)
  {
    overallRating=overallRating+items.rating;
  }
  overallRating=overallRating/reviewsBloc.ratings.length;
}

  if (reviewsBloc.ratings.isNotEmpty) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        SizedBox(
                    width: 70,height: 70,
                    child: CustomCachedNetworkImage(image: reviewsBloc.sellerModel.image!)),
                   const  SizedBox(width: 10,),
                    Text(capitalize(reviewsBloc.sellerModel.name),style: largeBlackTextStyle,),
        Text('Overall Rating',style: blackPlainTextStyle,),
        RatingBar(rating: overallRating.toInt()),
        const SizedBox(height: 20,),
        Align(
          alignment: Alignment.centerLeft,
          child: Text('Ratings and Comments :',style: blackTextStyle,))
        ,Expanded(child:ListView.builder(
              itemCount: reviewsBloc.ratings.length,
              itemBuilder: (context, index) {
                return loadedReviewTile(reviewsBloc: reviewsBloc, index: index);
              },) )
      ],
    ),
  );
}
else 
{
  return Center(child: Text('No one reviewed',style: greyTextStyle,),);
}
}