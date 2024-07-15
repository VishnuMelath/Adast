import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../ themes/themes.dart';
import '../../bloc/item_details_bloc.dart';

Widget pageIndicator(BuildContext context,int length,ItemDetailsBloc itemDetailsBloc){
  return Positioned(
                      top: 10,
                      right: 10,
                      child: BlocBuilder<ItemDetailsBloc, ItemDetailsState>(
                        builder: (context, state) {
                          return Visibility(
                            visible: length > 1,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                '${itemDetailsBloc.page}/$length',
                                style: whiteTextStyle,
                              ),
                            ),
                          );
                        },
                      ),
                    );
}