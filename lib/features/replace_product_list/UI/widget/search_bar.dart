import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/%20themes/themes.dart';
import 'package:adast/features/replace_product_list/UI/widget/filter_widget.dart';
import 'package:adast/features/replace_product_list/UI/widget/sort_widget.dart';

import 'package:flutter/material.dart';

import '../../../../services/methods/debouncer.dart';
import '../../bloc/replace_bloc.dart';


class CustomSearchBar extends StatelessWidget {
  final SearchBloc searchBloc;
  const CustomSearchBar({super.key, required this.searchBloc});

  @override
  Widget build(BuildContext context) {
    final debouncer = Debouncer(500);
    return Container(
      margin: const EdgeInsets.all(18),
      decoration: BoxDecoration(
          color: greentransparent.withOpacity(0.1),
          border: Border.all(color: greentransparent.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(10)),
      child: TextField(
        style: blackPlainTextStyle,
        decoration: InputDecoration(
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () {
                    showFilters(context, searchBloc);
                    }, icon: const Icon(Icons.filter_alt)),
                IconButton(onPressed: () {
                  showSortBottomSheet(context, searchBloc);
                }, icon: const Icon(Icons.sort)),
              ],
            ),
            counterStyle: greenTextStyle,
            border: InputBorder.none,
            prefixIcon: const Icon(
              Icons.search,
              color: grey,
            ),
            hintStyle: greyMediumTextStyle,
            hintText: 'what are you looking for ?'),
        onChanged: (value) {
          searchBloc.searchQuery = value;
          debouncer.call(
            () {
              searchBloc.add(SearchValueChangedEvent());
            },
          );
        },
      ),
    );
  }
}
