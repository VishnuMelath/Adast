import 'dart:developer';

import 'package:adast/custom_widgets/custom_snackbar.dart';
import 'package:adast/features/home_screen/bloc/home_bloc.dart';
import 'package:adast/features/item_details_page/UI/widgets/back_button.dart';
import 'package:adast/features/item_details_page/UI/widgets/page_indicator.dart';
import 'package:adast/features/item_details_page/UI/widgets/pageview.dart';
import 'package:adast/features/item_details_page/UI/widgets/reserve_button.dart';
import 'package:adast/features/item_details_page/UI/widgets/bottomsheet_reservation.dart';
import 'package:adast/features/item_details_page/UI/widgets/string_to_imagewidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ themes/colors_shemes.dart';
import '../bloc/item_details_bloc.dart';
import 'widgets/resizable_container.dart';

class ItemDetails extends StatelessWidget {
  final HomeBloc homeBloc;
  const ItemDetails({super.key, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    ItemDetailsBloc itemDetailsBloc = context.read();
    itemDetailsBloc.sellerModel=homeBloc.sellers[itemDetailsBloc.item.sellerID];
    log(itemDetailsBloc.item.name);
    bool reload = false;
    return Container(
      color: greentransparent,
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: BlocListener<ItemDetailsBloc, ItemDetailsState>(
            listener: (context, state) {
              
              if(state is ItemDetailsErrorState)
              {
                customSnackBar(context, state.error);
              }
              else if(state is ItemShowBottomSheetState)
              {
                // customShowDialogue(context);
                showBottomSheetForReservation(context, itemDetailsBloc);
              }
            },
            child: reserveButton(
              () {
                itemDetailsBloc.add(ItemsReserverPressedEvent());
              },
            ),
          ),
          body: BlocBuilder<ItemDetailsBloc, ItemDetailsState>(
            builder: (context, state) {
              List<Widget> images =
                  stringToImageListWidget(itemDetailsBloc.item.images, context);
              if (state is ItemDetailsLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    customPageView(context, itemDetailsBloc, images),
                    ResizableContainer(
                      minHeight: MediaQuery.of(context).size.height * .3,
                      homeBloc: homeBloc,
                    ),
                    pageIndicator(context, images.length, itemDetailsBloc),
                    backButton(context, reload),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
