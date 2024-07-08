import 'dart:developer';

import 'package:adast/features/home_screen/bloc/home_bloc.dart';
import 'package:adast/models/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../ themes/colors_shemes.dart';
import '../../../../ themes/themes.dart';
import '../../../../methods/common_methods.dart';
import '../../../seller_profile/UI/seller_profile.dart';
import '../../../seller_profile/bloc/seller_profile_bloc.dart';
import '../../../splash_screen/bloc/splashscreen_bloc.dart';
import '../../bloc/item_details_bloc.dart';
import 'drawer_holder.dart';
import 'size_widget.dart';

class ResizableContainer extends StatefulWidget {
  final double minHeight;
  final double maxHeight;
  final HomeBloc homeBloc;

  const ResizableContainer(
      {super.key,
      this.minHeight = 100.0,
      this.maxHeight = 700.0,
      required this.homeBloc});

  @override
  State<ResizableContainer> createState() => _ResizableContainerState();
}

class _ResizableContainerState extends State<ResizableContainer> {
  double currentHeight = 500.0; // Initial height

  void onDragUpdate(DragUpdateDetails details) {
    setState(() {
      currentHeight -= details.delta.dy;
      currentHeight = currentHeight.clamp(widget.minHeight, widget.maxHeight);
    });
  }

  @override
  Widget build(BuildContext context) {
    ItemDetailsBloc itemDetailsBloc = BlocProvider.of(context);
    return BlocBuilder<ItemDetailsBloc, ItemDetailsState>(
      builder: (context, state) {
        late int itemsLeft;
        if (itemDetailsBloc.selectedSize == null) {
          itemsLeft = itemDetailsBloc.item.size.values.fold<int>(
                0,
                (s, e) {
                  return s + e[0] as int;
                },
              ) -
              (itemDetailsBloc.item.soldCount
                      .containsKey(itemDetailsBloc.selectedSize)
                  ? itemDetailsBloc.item.soldCount[itemDetailsBloc.selectedSize]
                      as int
                  : 0);
        } else {
          itemsLeft = itemDetailsBloc.item.size[itemDetailsBloc.selectedSize]
                  [0] -
              (itemDetailsBloc.item.soldCount[itemDetailsBloc.selectedSize] ??
                  0);
        }
        log(itemDetailsBloc.item.toMap().toString());
        return Container(
          padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
          width: double.infinity,
          height: currentHeight,
          decoration: const BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onVerticalDragUpdate: onDragUpdate,
                  child: drawerHolder(context),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                        create: (context) => SellerProfileBloc(
                                            sellerModel:
                                                itemDetailsBloc.sellerModel,
                                            subscribed: context
                                                .read<SplashscreenBloc>()
                                                .userModel!
                                                .subscriptions
                                                .contains(itemDetailsBloc
                                                    .item.sellerID)),
                                        child: SellerProfile(
                                          homeBloc: widget.homeBloc,
                                        ),
                                      ),
                                    ));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    width: 40,
                                    imageUrl: widget
                                        .homeBloc
                                        .sellers[itemDetailsBloc.item.sellerID]!
                                        .image!),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  capitalize(widget
                                      .homeBloc
                                      .sellers[itemDetailsBloc.item.sellerID]!
                                      .name),
                                  style: largeBlackTextStyle,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                capitalize(itemDetailsBloc.item.brand),
                                style: mediumBlackTextStyle,
                              ),
                            ),
                            BlocBuilder<ItemDetailsBloc, ItemDetailsState>(
                              builder: (context, state) {
                                return IconButton(
                                    onPressed: () {
                                      UserModel userModel= context.read<SplashscreenBloc>().userModel!;
                                      itemDetailsBloc.add(ItemSaveUnSavePressedEvent(userModel:userModel, itemId: itemDetailsBloc.item.id!));
                                      widget.homeBloc.add(HomeInitialEvent(userModel: userModel));
                                    },
                                    icon: context
                                            .read<SplashscreenBloc>()
                                            .userModel!
                                            .saved
                                            .contains(itemDetailsBloc.item.id)
                                        ? const Icon(Icons.bookmark)
                                        : const Icon(Icons.bookmark_border));
                              },
                            )
                          ],
                        ),
                        Text(
                          itemDetailsBloc.item.name,
                          style: blackTextStyle,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            itemDetailsBloc.item.description,
                            style: greyTextStyle,
                          ),
                        ),
                        Text(
                          'size',
                          style: mediumBlackTextStyle,
                        ),
                        SizeWidget(itemDetailsBloc: itemDetailsBloc),
                        if (itemDetailsBloc.selectedSize != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 15),
                            decoration: greenBoxDecoration,
                            child: Text(
                              '$itemsLeft left',
                              style: whiteTextStyle,
                            ),
                          ),
                        const Divider(),
                        Text(
                          'Product details',
                          style: mediumBlackTextStyle,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width * .4,
                                    child: Text(
                                      'Material',
                                      style: greyTextStyle,
                                    ),
                                  ),
                                  Text(
                                    itemDetailsBloc.item.material,
                                    style: blackPlainTextStyle,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width * .4,
                                    child: Text(
                                      'Fit',
                                      style: greyTextStyle,
                                    ),
                                  ),
                                  Text(
                                    itemDetailsBloc.item.fit,
                                    style: blackPlainTextStyle,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width * .4,
                                    child: Text(
                                      'Category',
                                      style: greyTextStyle,
                                    ),
                                  ),
                                  Text(
                                    itemDetailsBloc.item.category,
                                    style: blackPlainTextStyle,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width * .4,
                                    child: Text(
                                      'Price',
                                      style: greyTextStyle,
                                    ),
                                  ),
                                  Text(
                                    '${itemDetailsBloc.item.price} ₹',
                                    style: blackPlainTextStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
