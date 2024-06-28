import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../ themes/colors_shemes.dart';
import '../../../../ themes/themes.dart';
import '../../../../custom_widgets/custom_button.dart';
import '../../../../methods/common_methods.dart';
import '../../../../services/item_database_services.dart';
import '../../bloc/item_details_bloc.dart';
import 'drawer_holder.dart';
import 'show_dialog_delete.dart';
import 'size_widget.dart';

class ResizableContainer extends StatefulWidget {
  final double minHeight;
  final double maxHeight;

  const ResizableContainer({
    super.key,
    this.minHeight = 100.0,
    this.maxHeight = 700.0,
  });

  @override
  State<ResizableContainer> createState() => _ResizableContainerState();
}

class _ResizableContainerState extends State<ResizableContainer> {
  double currentHeight = 500.0; // Initial height

  void onDragUpdate(DragUpdateDetails details) {
    setState(() {
      currentHeight -= details.delta.dy;
      currentHeight = currentHeight.clamp(widget.minHeight, widget.maxHeight);
    });
  }

  @override
  Widget build(BuildContext context) {
    ItemDetailsBloc itemDetailsBloc = BlocProvider.of(context);
    return BlocBuilder<ItemDetailsBloc, ItemDetailsState>(
      builder: (context, state) {
        late int reservedCount;
        late int itemsLeft;
        log('message');
        if (itemDetailsBloc.selectedSize == null) {
          reservedCount = itemDetailsBloc.item.reservedCount.values.fold<int>(
            0,
            (s, e) {
              return s + (e[1] ?? 0) as int;
            },
          );
          itemsLeft = itemDetailsBloc.item.size.values.fold<int>(
                0,
                (s, e) {
                  return s + e[0] as int;
                },
              ) -
              (itemDetailsBloc.item.soldCount
                      .containsKey(itemDetailsBloc.selectedSize)
                  ? itemDetailsBloc.item.soldCount[itemDetailsBloc.selectedSize]
                      as int
                  : 0);
        } else {
          reservedCount = itemDetailsBloc
                  .item.reservedCount[itemDetailsBloc.selectedSize] ??
              0;
          itemsLeft = itemDetailsBloc.item.size[itemDetailsBloc.selectedSize]
                  [0] -
              (itemDetailsBloc.item.soldCount[itemDetailsBloc.selectedSize] ??
                  0);
        }
        log(itemDetailsBloc.item.toMap().toString());
        return Container(
          padding: const EdgeInsets.only(top: 10),
          width: double.infinity,
          height: currentHeight,
          decoration: const BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onVerticalDragUpdate: onDragUpdate,
                  child: drawerHolder(context),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 15),
                              decoration: greenBoxDecoration,
                              child: Text(
                                '$reservedCount reserved',
                                style: whiteTextStyle,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 15),
                              decoration: greenBoxDecoration,
                              child: Text(
                                '$itemsLeft left',
                                style: whiteTextStyle,
                              ),
                            )
                          ],
                        ),
                        Text(
                          capitalize(itemDetailsBloc.item.brand),
                          style: largeBlackTextStyle,
                        ),
                        Text(
                          itemDetailsBloc.item.name,
                          style: blackTextStyle,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            itemDetailsBloc.item.description,
                            style: greyTextStyle,
                          ),
                        ),
                        const Text(
                          'size',
                          style: mediumBlackTextStyle,
                        ),
                        SizeWidget(itemDetailsBloc: itemDetailsBloc),
                        const Divider(),
                        const Text(
                          'Product details',
                          style: mediumBlackTextStyle,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width * .4,
                                    child: const Text(
                                      'Material',
                                      style: greyTextStyle,
                                    ),
                                  ),
                                  Text(itemDetailsBloc.item.material),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width * .4,
                                    child: const Text(
                                      'Fit',
                                      style: greyTextStyle,
                                    ),
                                  ),
                                  Text(itemDetailsBloc.item.fit),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width * .4,
                                    child: const Text(
                                      'Category',
                                      style: greyTextStyle,
                                    ),
                                  ),
                                  Text(itemDetailsBloc.item.category),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width * .4,
                                    child: const Text(
                                      'Price',
                                      style: greyTextStyle,
                                    ),
                                  ),
                                  Text('${itemDetailsBloc.item.price} ₹'),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
