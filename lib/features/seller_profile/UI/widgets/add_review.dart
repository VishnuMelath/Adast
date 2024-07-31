import 'dart:developer';

import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/%20themes/themes.dart';
import 'package:adast/custom_widgets/custom_snackbar.dart';
import 'package:adast/features/seller_profile/UI/widgets/rating_widget.dart';
import 'package:adast/features/seller_profile/bloc/seller_profile_bloc.dart';
import 'package:adast/features/splash_screen/bloc/splashscreen_bloc.dart';
import 'package:adast/models/rating_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void addRating(BuildContext context,
    {required SellerProfileBloc sellerProfileBloc}) async {
  showDialog(
    context: context,
    builder: (context) {
      int rating = 0;
      TextEditingController controller = TextEditingController();
      if (sellerProfileBloc.ratingModel != null) {
        controller.text = sellerProfileBloc.ratingModel!.comments;
        rating = sellerProfileBloc.ratingModel!.rating.toInt();
      }
      return Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: white, borderRadius: BorderRadius.circular(10)),
          child: Container(
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rating:',
                          style: blackTextStyle,
                        ),
                        RatingBar(
                          initialRating: rating,
                          onRatingChanged: (p0) {
                            rating = p0;
                            log(rating.toString());
                          },
                        ),
                      ],
                    ),
                    BlocConsumer<SellerProfileBloc, SellerProfileState>(
                      listener: (context, state) {
                        if(state is SellerReviewSavedState)
                        {
                          Navigator.pop(context);

                        }
                      },
                      bloc: sellerProfileBloc,
                      builder: (context, state) {
                        if (state is SellerReviewSavingState) {
                          return const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(),
                          );
                        }
                        return IconButton(
                            onPressed: () {
                              if(rating==0)
                              {
                                customSnackBar(context,'please give a stars to save');
                              }
                              else if(controller.text.trim().isEmpty)
                              {
                                customSnackBar(context,'please comment something to save');
                              }
                              else 
                              {sellerProfileBloc.add(
                                  SellerProfileAddUpdateReviewEvent(
                                      ratingModel: RatingModel(
                                          rating: rating.toDouble(),
                                          comments: controller.text,
                                          time: DateTime.now(),
                                          sellerId:
                                              sellerProfileBloc.sellerModel.id!,
                                          userId: context
                                              .read<SplashscreenBloc>()
                                              .userModel!
                                              .id!)));}
                            },
                            icon: const Icon(Icons.check));
                      },
                    )
                  ],
                ),
                Text(
                  'Comment:',
                  style: blackTextStyle,
                ),
                Material(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: TextField(
                    controller: controller,
                    style: blueMediumTextStyle,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(5),
                        hintText: 'comments',
                        hintStyle: greyMediumTextStyle,
                        border: InputBorder.none),
                    minLines: 2,
                    maxLines: 5,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
