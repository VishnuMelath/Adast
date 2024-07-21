
import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/%20themes/themes.dart';
import 'package:adast/features/home_screen/bloc/home_bloc.dart';
import 'package:adast/features/search_screen/UI/widget/custom_list_tile.dart';
import 'package:adast/features/search_screen/UI/widget/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/search_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SearchBloc searchBloc = SearchBloc()..add(SearchInitialEvent());
    HomeBloc homeBloc = context.read<HomeBloc>();
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
