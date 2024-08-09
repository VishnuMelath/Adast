import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/%20themes/themes.dart';
import 'package:adast/features/home_screen/UI/widgets/feed_widget/bloc/feed_widget_bloc.dart';
import 'package:adast/features/home_screen/bloc/home_bloc.dart';
import 'package:adast/features/item_details_page/UI/item_detail.dart';
import 'package:adast/features/item_details_page/bloc/item_details_bloc.dart';
import 'package:adast/features/seller_profile/UI/seller_profile.dart';
import 'package:adast/features/seller_profile/bloc/seller_profile_bloc.dart';
import 'package:adast/features/splash_screen/bloc/splashscreen_bloc.dart';
import 'package:adast/methods/common_methods.dart';
import 'package:adast/models/cloth_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class FeedWidget extends StatelessWidget {
  final ClothModel clothModel;
  final HomeBloc homeBloc;
  const FeedWidget(
      {super.key, required this.clothModel, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    FeedWidgetBloc feedWidgetBloc = FeedWidgetBloc();
    var constraints = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 28.0),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              ItemDetailsBloc itemDetailsBloc =
                  ItemDetailsBloc(item: clothModel);
              itemDetailsBloc.sellerModel =
                  homeBloc.sellers[clothModel.sellerID]!;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => ItemDetailsBloc(
                        item: clothModel,
                      ),
                      child: ItemDetails(
                        homeBloc: homeBloc,
                      ),
                    ),
                  ));
            },
            child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [   SizedBox(

                  height:constraints.height<constraints.width?MediaQuery.sizeOf(context).height*0.9 :MediaQuery.sizeOf(context).width * 1.5,
                  child: PageView(
                    onPageChanged: (value) {
                      feedWidgetBloc.add(FeedImageChangedEvent(page: value));
                    },
                    children: [
                      ...clothModel.images.map(
                        (e) => Align(
                          alignment:Alignment.centerLeft ,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: e,
                              fit: BoxFit.fitHeight,
                              placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              child: Center(child: CircularProgressIndicator(
                                color: green,
                              ),),
                              decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(30)),
                              width: constraints.width,
                              height:constraints.height<constraints.width?MediaQuery.sizeOf(context).height*0.9 :MediaQuery.sizeOf(context).width * 1.5
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                            ),
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
              
  ],
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.sizeOf(context).width,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      SellerProfileBloc sellerProfileBloc = SellerProfileBloc(
                          sellerModel: homeBloc.sellers[clothModel.sellerID]!,
                          subscribed: context
                              .read<SplashscreenBloc>()
                              .userModel!
                              .subscriptions
                              .contains(clothModel.sellerID))
                        ..add(SellerProfileItemLoadingEvent());
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => sellerProfileBloc,
                              child: SellerProfile(
                                homeBloc: homeBloc,
                              ),
                            ),
                          ));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          width: 40,
                          imageUrl:
                              homeBloc.sellers[clothModel.sellerID]!.image!),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        capitalize(homeBloc.sellers[clothModel.sellerID]!.name),
                        style: mediumWhiteTextStyle,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: clothModel.images.length > 1,
                    child: BlocBuilder<FeedWidgetBloc, FeedWidgetState>(
                      bloc: feedWidgetBloc,
                      builder: (context, state) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            '${feedWidgetBloc.currentPage + 1}/${clothModel.images.length}',
                            style: whiteTextStyle,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
