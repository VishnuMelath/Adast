import 'package:adast/features/search_screen/bloc/search_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';
import '../../../../../ themes/themes.dart';
import '../../../../custom_widgets/custom_button.dart';
import 'custom_multi_select.dart';
import 'price_range_widget.dart';

void showFilters(BuildContext context, SearchBloc searchBloc) {
  showModalBottomSheet(
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    isDismissible: true,
    context: context,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 10,
          right: 10),
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Filter',
                      style: greyTextStyle,
                    ),
                  ),
                  TextButton(onPressed: () {
                    searchBloc.add(SearchClearFilterEvent());
                  Navigator.pop(context);
                  showFilters(context, searchBloc);
                  }, child: Text('clear',style: mediumRedTextStyle,))
                ],
              ),
              CustomMultiSelectFilter(
                options: searchBloc.categories.toList(),
                searchBloc: searchBloc,
                hint: 'Category',
                selectedOptions: searchBloc.selectedCategory,
              ),
              CustomMultiSelectFilter(
                options: searchBloc.brands.toList(),
                searchBloc: searchBloc,
                hint: 'Brand',
                selectedOptions: searchBloc.selectedBrands,
              ),
              PriceRangeWidget(searchBloc: searchBloc),
              CustomMultiSelectFilter(
                  options: fabric,
                  searchBloc: searchBloc,
                  hint: 'Fabric',
                  selectedOptions: searchBloc.selectedFabric),
              CustomMultiSelectFilter(
                  options: fits,
                  searchBloc: searchBloc,
                  hint: 'Fit',
                  selectedOptions: searchBloc.selectedFit),
              CustomButton(
                  onTap: () {
                    searchBloc.add(SearchValueChangedEvent());
                    Navigator.pop(context);
                  },
                  text: 'apply'),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    ),
  );
}
