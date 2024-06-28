import 'package:flutter/material.dart';

import '../../../../ themes/colors_shemes.dart';


Widget drawerHolder(BuildContext context)
{
  return Material(
                              // elevation: 10,
                              color: Colors.transparent,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 10,
                                    bottom: 3.0,
                                    right: MediaQuery.of(context).size.width * 0.3,
                                    left: MediaQuery.of(context).size.width * 0.3),
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  width: 60,
                                  height: 8,
                                  decoration: BoxDecoration(
                                      color: grey.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            );
}

