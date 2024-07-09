import 'package:adast/%20themes/themes.dart';
import 'package:adast/features/home_screen/bloc/home_bloc.dart';
import 'package:adast/features/item_details_page/UI/item_detail.dart';
import 'package:adast/features/item_details_page/bloc/item_details_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/search_bloc.dart';

class CustomListTile extends StatelessWidget {
  final int start;
  final SearchBloc searchBloc;
  final HomeBloc homeBloc;
  const CustomListTile(
      {super.key,
      required this.start,
      required this.searchBloc,
      required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: GestureDetector(
          onTap: () {
            ItemDetailsBloc itemDetailsBloc =
                ItemDetailsBloc(item: searchBloc.items[start]);
            itemDetailsBloc.add(ItemSellerLoadingEvent());
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => itemDetailsBloc,
                    child: ItemDetails(homeBloc: homeBloc),
                  ),
                ));
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 1.0, top: 2, right: 1,bottom: 2),
            child: Column(
              children: [
                Center(
                    child: CachedNetworkImage(
                        imageUrl: searchBloc.items[start].images[0])),
                        Text( searchBloc.items[start].name,style: smallBlackTextStyle,),
                        Text('₹${searchBloc.items[start].price}',style: smallBlackTextStyle,)
              ],
            ),
          ),
        )),
        Expanded(
            child: GestureDetector(
          onTap: () {
            ItemDetailsBloc itemDetailsBloc =
                ItemDetailsBloc(item: searchBloc.items[start]);
            itemDetailsBloc.add(ItemSellerLoadingEvent());
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => itemDetailsBloc,
                    child: ItemDetails(homeBloc: homeBloc),
                  ),
                ));
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 1.0, top: 2, right: 1,bottom: 2),
            child: Visibility(
                visible: start + 2 <= searchBloc.items.length,
                child: Column(
                  children: [
                    Center(
                        child: start + 2 <= searchBloc.items.length
                            ? CachedNetworkImage(
                                imageUrl: searchBloc.items[start + 1].images[0])
                            : const SizedBox()),
                    Text(
                      start + 2 <= searchBloc.items.length
                          ? searchBloc.items[start + 1].name
                          : '',
                      style: smallBlackTextStyle,
                    ),
                    Text(
                      start + 2 <= searchBloc.items.length
                          ?'₹${searchBloc.items[start + 1].price}'
                          : '',
                      style: smallBlackTextStyle,
                    )
                  ],
                )),
          ),
        )),
        Expanded(
            child: GestureDetector(
          onTap: () {
            ItemDetailsBloc itemDetailsBloc =
                ItemDetailsBloc(item: searchBloc.items[start]);
            itemDetailsBloc.add(ItemSellerLoadingEvent());
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => itemDetailsBloc,
                    child: ItemDetails(homeBloc: homeBloc),
                  ),
                ));
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 1.0, top: 2, right: 1,bottom: 2),
            child: Visibility(
                visible: start + 3 <= searchBloc.items.length,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                        child: start + 3 <= searchBloc.items.length
                            ? CachedNetworkImage(
                                imageUrl: searchBloc.items[start + 2].images[0])
                            : const SizedBox()),
                    Text(
                      start + 3 <= searchBloc.items.length
                          ? searchBloc.items[start + 2].name
                          : '',
                      style: smallBlackTextStyle,
                    ),
                    Text(
                      start + 3 <= searchBloc.items.length
                          ?'₹${searchBloc.items[start + 2].price}'
                          : '',
                      style: smallBlackTextStyle,
                    )
                  ],
                )),
          ),
        )),
      ],
    );
  }
}
