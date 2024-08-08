
import 'package:adast/features/map/bloc/map_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../ themes/colors_shemes.dart';
import '../../../../ themes/themes.dart';
import '../../../../methods/debouncer.dart';

class SearchBarMapScreen extends StatelessWidget {
  final MapBloc mapBloc;
  const SearchBarMapScreen({super.key, required this.mapBloc});

  @override
  Widget build(BuildContext context) {

    TextEditingController searchController = TextEditingController(text: mapBloc.searchQuery);
    final debouncer = Debouncer(500);
    return Container(
      decoration: BoxDecoration(
          color: white,
          border: Border.all(color: greentransparent.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(10)),
      child: TextField(
        
        controller: searchController,
        style: blackPlainTextStyle,
        decoration: InputDecoration(
          suffixIcon: IconButton(onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();

            searchController.clear();
            mapBloc.add(MapSearchClearEvent());
          }, icon: const Icon(Icons.clear_sharp,color: grey,)),
            counterStyle: greenTextStyle,
            border: InputBorder.none,
            prefixIcon: const Icon(
              Icons.search,
              color: grey,
            ),
            hintStyle: greyMediumTextStyle,
            hintText: 'search for stores...'),
        onChanged: (value) {
          mapBloc.searchQuery=value;
          debouncer.call(
            () {
              mapBloc.add(MapSellerSearchEvent(querry: value));
            },
          );
        },
      ),
    );
  }
}
