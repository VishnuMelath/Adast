import 'package:adast/%20themes/themes.dart';
import 'package:adast/custom_widgets/custom_cached_network_image.dart';
import 'package:adast/features/reviews/UI/widgets/star_widget.dart';
import 'package:adast/features/reviews/bloc/reviews_bloc.dart';
import 'package:adast/models/rating_model.dart';
import 'package:adast/models/user_model.dart';
import 'package:adast/methods/common_methods.dart';
import 'package:flutter/material.dart';

import '../../../../ themes/colors_shemes.dart';

Widget loadedReviewTile({required ReviewsBloc reviewsBloc,required int index})
{
  RatingModel ratingModel=reviewsBloc.ratings[index];
  UserModel userModel=reviewsBloc.users[ratingModel.id!]!;
  return Container( 
    decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: green,
            gradient: LinearGradient(
                colors: [
                  backgroundColor,
                  white.withOpacity(0.3),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: const [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          padding: const EdgeInsets.all(8),
          margin:  const EdgeInsets.all(8),
          child: Column( 
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ 
              Row(
                children: [
                  SizedBox(
                    width: 40,height: 40,
                    child: CustomCachedNetworkImage(image: userModel.image!)),
                   const  SizedBox(width: 10,),
                    Expanded(child: Text(capitalize(userModel.name),style: blackTextStyle,))
                    ,
                ],
              ),
              RatingBar(rating: ratingModel.rating.toInt()),
              Text('Comments :',style: blackTextStyle,)
              ,Text(ratingModel.comments,style: greyMediumTextStyle,),Align(
                alignment: Alignment.centerRight,
                child: Text(dateTimeString(ratingModel.time),style: greySmallTextStyle,)),
            ],
          ),
  );
}