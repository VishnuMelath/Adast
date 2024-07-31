
import 'dart:developer';

import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/features/home_screen/bloc/home_bloc.dart';
import 'package:adast/features/item_details_page/bloc/item_details_bloc.dart';
import 'package:adast/features/saved_items/bloc/saved_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../models/cloth_model.dart';
import '../../../item_details_page/UI/item_detail.dart';

Widget loadedTiles(List<ClothModel> items, BuildContext context,HomeBloc homeBloc,SavedBloc savedBloc) {
  var temp=(items.length / 3).ceil();
  return ListView(
    children: List.generate(
      temp,
      (index) => loadedRow(context,items,temp==index+1,index,homeBloc,savedBloc),
    ),
  );
}

Widget loadedRow(BuildContext context,List<ClothModel> items,bool last,int row,HomeBloc homeBloc,SavedBloc savedBloc) {
  return Row(
    children: List.generate(
      3,
      (index) {

        return loadedTile(context,
      index>=(items.length%3)&&last,items,row*3+(index)
      ,homeBloc,savedBloc);
      },
    ),
  );
}

Widget loadedTile(BuildContext context,bool notvisible,List<ClothModel> item,int pos ,HomeBloc homeBloc,SavedBloc savedBloc){
  var pos1=item.length>pos?pos:0;
  return Expanded(
    child: GestureDetector(
      onTap: () {
        ItemDetailsBloc itemDetailsBloc=ItemDetailsBloc(item: item[pos1]);
         itemDetailsBloc.add(ItemSellerLoadingEvent());
         Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => itemDetailsBloc,
                    child: ItemDetails(homeBloc: homeBloc),
                  ),
                )).then((value) {
                  log('message');
                  savedBloc.add(SavedItemsLoadingEvent(ids: homeBloc.userModel.saved));
                },);
      },
      child: Visibility(
        visible: !notvisible,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: CachedNetworkImage(
            imageUrl:item[pos1].images.first,
            placeholder:(context, url) {
              return Shimmer.fromColors(
              period: const Duration(seconds: 2),
              baseColor: Colors.grey[300]!,
              highlightColor: greentransparent,
              child: Container(
                  margin: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      color: backgroundColor,),
                  height: ((MediaQuery.sizeOf(context).width / 3) - 6) * 1.5),
            );
            },
          ),
        ),
      ),
    ),
  );
}
