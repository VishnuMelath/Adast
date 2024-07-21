
import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/%20themes/themes.dart';
import 'package:adast/features/home_screen/bloc/home_bloc.dart';
import 'package:adast/features/replace_product_list/UI/widget/custom_list_tile.dart';
import 'package:adast/features/replace_product_list/UI/widget/search_bar.dart';
import 'package:adast/models/reservation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/replace_bloc.dart';

class ReplaceProduct extends StatelessWidget {
  final ReservationModel reservationModel;
  final HomeBloc homeBloc;
  const ReplaceProduct({super.key,required this.reservationModel,required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    SearchBloc searchBloc = SearchBloc(reservationModel: reservationModel)..add(SearchInitialEvent());
    return Container(
      color: white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: Column(
            children: [
              CustomSearchBar(
                searchBloc: searchBloc,
              ),
              BlocConsumer<SearchBloc, SearchState>(
                bloc: searchBloc,
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is SearchLoadingState || state is SearchInitial) {
                    return const Expanded(
                        child: Center(
                      child: CircularProgressIndicator(),
                    ));
                  } else {
                    return Expanded(
                        child: searchBloc.items.isEmpty
                            ? Center(
                                child: Text(
                                  'No items found',
                                  style: greyMediumTextStyle,
                                ),
                              )
                            : ListView.builder(
                                itemCount: (searchBloc.items.length / 3).ceil(),
                                itemBuilder: (context, index) {
                                  final start = index * 3;
                                  return CustomListTile(
                                    reservationModel: reservationModel,
                                    start: start,
                                    searchBloc: searchBloc,
                                    homeBloc: homeBloc,
                                  );
                                }));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
