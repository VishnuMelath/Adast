import 'dart:developer';

import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/%20themes/themes.dart';
import 'package:adast/features/search_screen/UI/widget/search_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/search_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SearchBloc searchBloc = SearchBloc()..add(SearchInitialEvent());
    return Container(
      color: greentransparent.withOpacity(0.1),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              CustomSearchBar(
                searchBloc: searchBloc,
              ),
              BlocConsumer<SearchBloc, SearchState>(
                bloc: searchBloc,
                listener: (context, state) {},
                builder: (context, state) {
                  log(state.runtimeType.toString());
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
                                  return Row(
                                    children: [
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 1.0, top: 2, right: 1),
                                        child: Center(
                                            child: CachedNetworkImage(
                                                imageUrl: searchBloc
                                                    .items[start].images[0])),
                                      )),
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 1.0, top: 2, right: 1),
                                        child: Visibility(
                                            visible: start + 2 <=
                                                searchBloc.items.length,
                                            child: Center(
                                                child: start + 2 <=
                                                        searchBloc.items.length
                                                    ? CachedNetworkImage(
                                                        imageUrl: searchBloc
                                                            .items[start + 1]
                                                            .images[0])
                                                    : const SizedBox())),
                                      )),
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 1.0, top: 2, right: 1),
                                        child: Visibility(
                                            visible: start + 3 <=
                                                searchBloc.items.length,
                                            child: Center(
                                                child: start + 3 <=
                                                        searchBloc.items.length
                                                    ? CachedNetworkImage(
                                                        imageUrl: searchBloc
                                                            .items[start + 2]
                                                            .images[0])
                                                    : const SizedBox())),
                                      )),
                                    ],
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
