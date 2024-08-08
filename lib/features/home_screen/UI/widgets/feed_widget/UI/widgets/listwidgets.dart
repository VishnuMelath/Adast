import 'package:adast/features/home_screen/UI/widgets/feed_widget/bloc/feed_widget_bloc.dart';
import 'package:adast/features/home_screen/bloc/home_bloc.dart';
import 'package:adast/models/cloth_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../ themes/themes.dart';
import '../../../../../../../methods/common_methods.dart';
import '../../../../../../splash_screen/bloc/splashscreen_bloc.dart';

List<Widget> feedcontains(BuildContext context,FeedWidgetBloc feedWidgetBloc,Size constraints,ClothModel clothModel,HomeBloc homeBloc)
{
  return [
    SizedBox(

                  height:constraints.height<constraints.width?MediaQuery.sizeOf(context).height*0.9 :MediaQuery.sizeOf(context).width * 1.5,
                  child: PageView(
                    onPageChanged: (value) {
                      feedWidgetBloc.add(FeedImageChangedEvent(page: value));
                    },
                    children: [
                      ...clothModel.images.map(
                        (e) => ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: e,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${capitalize(clothModel.name)} ( ₹${clothModel.price})',
                                style: mediumBlackTextStyle,
                              ),
                              Text(
                                clothModel.description,
                                style: blackPlainTextStyle,
                              ),
                              Text(
                                'Available sizes ${clothModel.size.keys}',
                                style: blackPlainTextStyle,
                              ),
                              Text(
                                dateString(clothModel.date),
                                style: greySmallTextStyle,
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              homeBloc.add(HomeSaveOrRemoveTappedEvent(
                                  userModel: context
                                      .read<SplashscreenBloc>()
                                      .userModel!,
                                  itemId: clothModel.id!));
                            },
                            child: context
                                    .read<SplashscreenBloc>()
                                    .userModel!
                                    .saved
                                    .contains(clothModel.id)
                                ? const Icon(Icons.bookmark)
                                : const Icon(Icons.bookmark_border))
                      ],
                    ),
                  ),
                ),
              
  ];
}
