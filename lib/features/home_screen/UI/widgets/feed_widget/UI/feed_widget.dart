import 'package:adast/%20themes/themes.dart';
import 'package:adast/features/home_screen/UI/widgets/feed_widget/bloc/feed_widget_bloc.dart';
import 'package:adast/features/home_screen/bloc/home_bloc.dart';
import 'package:adast/methods/common_methods.dart';
import 'package:adast/models/cloth_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedWidget extends StatelessWidget {
  final ClothModel clothModel;
  final HomeBloc homeBloc;
  const FeedWidget(
      {super.key, required this.clothModel, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    FeedWidgetBloc feedWidgetBloc = FeedWidgetBloc();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).width * 1.5,
                child: PageView(
                  onPageChanged: (value) {
                    feedWidgetBloc.add(FeedImageChangedEvent(page: value));
                  },
                  children: [
                    ...clothModel.images.map(
                      (e) => CachedNetworkImage(imageUrl: e),
                    )
                  ],
                ),
              ),
              Positioned(
                top: 10,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.sizeOf(context).width,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            width: 40,
                            imageUrl:
                                homeBloc.sellers[clothModel.sellerID]!.image!),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            capitalize(
                                homeBloc.sellers[clothModel.sellerID]!.name),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
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
          )
        ],
      ),
    );
  }
}
