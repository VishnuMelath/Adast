import 'package:flutter/material.dart';
import '../../../../ themes/colors_shemes.dart';
import '../../bloc/item_details_bloc.dart';

class SizeWidget extends StatelessWidget {
  final ItemDetailsBloc itemDetailsBloc;
  const SizeWidget({super.key, required this.itemDetailsBloc});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...itemDetailsBloc.item.size.keys.map(
          (e) => GestureDetector(
            onTap: () {
              itemDetailsBloc.add(ItemDetailsSizeChangedEvent(size: e));
            },
            child: Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: grey),
                  color: e == itemDetailsBloc.selectedSize ? green : white),
              child: Center(
                child: Text(
                  e,
                  style: TextStyle(
                      fontSize: 10,
                      color: e == itemDetailsBloc.selectedSize ? white : black),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
