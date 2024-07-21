import 'dart:async';

import 'package:adast/models/cloth_model.dart';
import 'package:adast/models/reservation_model.dart';
import 'package:adast/services/item_database_services.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';


part 'replace_event.dart';
part 'replace_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  String? searchQuery;
  List<ClothModel> items = [];
  //  Map<String, SellerModel> sellers = {};
  ReservationModel reservationModel;
  Set<String> brands = {};
  Set<String> categories = {};
  List<String> selectedBrands = [];
  List<String> selectedFabric = [];
  List<String> selectedFit = [];
  List<String> selectedCategory = [];
  int sortOption = 0;
  RangeValues priceRangeValues = const RangeValues(0, 10000);
  SearchBloc({required this.reservationModel}) : super(SearchInitial()) {
    on<SearchInitialEvent>(searchInitialEvent);
    on<SearchValueChangedEvent>(searchValueChangedEvent);
    on<SearchClearFilterEvent>(searchClearFilterEvent);
  }

  FutureOr<void> searchInitialEvent(
      SearchInitialEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());
    items = await ItemDatabaseServices().getAllSellerItems(reservationModel.sellerId);
    for (var item in items) {
      brands.add(item.brand);
      categories.add(item.category);
    }
    emit(SearchLoadedState());
  }

  FutureOr<void> searchValueChangedEvent(
      SearchValueChangedEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());
    items = await ItemDatabaseServices().getAllSellerItems(reservationModel.sellerId);
    for (var item in items) {
      brands.add(item.brand);
      categories.add(item.category);
    }
    items = items
        .where(
          (element) => element.name.contains(searchQuery ?? ''),
        )
        .toList();
    if (selectedBrands.isNotEmpty) {
      items = items.where(
        (e) {
          return selectedBrands.contains(e.brand);
        },
      ).toList();
    }
    if (selectedCategory.isNotEmpty) {
      items = items.where(
        (e) {
          return selectedCategory.contains(e.category);
        },
      ).toList();
    }
    if (selectedFabric.isNotEmpty) {
      items = items
          .where(
            (e) => selectedFabric.contains(e.material),
          )
          .toList();
    }
    if (selectedFit.isNotEmpty) {
      items = items
          .where(
            (e) => selectedFit.contains(e.fit),
          )
          .toList();
    }

    items = items
        .where(
          (element) =>
              element.price <= priceRangeValues.end &&
              element.price >= priceRangeValues.start,
        )
        .toList();

    if (sortOption != 0) {
      switch (sortOption) {
        //price ascending order
        case 1:
          items.sort((a, b) => a.price.compareTo(b.price));
          break;
        //price desc order
        case 2:
          items.sort((a, b) => b.price.compareTo(a.price));
          break;
        //date ascending order
        case 3:
          items.sort((a, b) => a.date.compareTo(b.date));
          break;
        //date desc order
        case 4:
          items.sort((a, b) => b.date.compareTo(a.date));
          break;

        default:
          break;
      }
    }
    if (items.isEmpty) {
      emit(SearchEmptyState());
    } else {
      await Future.delayed(const Duration(milliseconds: 200));

      emit(SearchLoadedState());
    }
  }

  FutureOr<void> searchClearFilterEvent(SearchClearFilterEvent event, Emitter<SearchState> emit) async{
    emit(SearchLoadingState());
    selectedBrands.clear();
    selectedCategory.clear();
    selectedFabric.clear();
    selectedFit.clear();
    priceRangeValues = const RangeValues(0, 10000);
    items = await ItemDatabaseServices().getAllSellerItems(reservationModel.sellerId);
    emit(SearchLoadedState());

  }
}
