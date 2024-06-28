import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../ themes/colors_shemes.dart';
import '../../../ themes/themes.dart';
import '../bloc/item_details_bloc.dart';
import 'widgets/resizable_container.dart';

class ItemDetails extends StatelessWidget {
  const ItemDetails({super.key});

  @override
  Widget build(BuildContext context) {
    ItemDetailsBloc itemDetailsBloc = context.read();
    bool reload = false;
    return Container(
      color: greentransparent,
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () {},
              backgroundColor: green,
              label: const Text(
                'reserve',
                style: whiteTextStyle,
              )),
          body: BlocBuilder<ItemDetailsBloc, ItemDetailsState>(
            builder: (context, state) {
              //converting the images to widget List
              List<Widget> images = itemDetailsBloc.item.images.map(
                (e) {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: CachedNetworkImage(
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitWidth,
                      imageUrl: e,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          color: green,
                          height: MediaQuery.of(context).size.width * 1.5,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  );
                },
              ).toList();
              //

              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    color: green,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child:
                        PageView(onPageChanged: (value) {}, children: images),
                  ),
                  ResizableContainer(
                    minHeight: MediaQuery.of(context).size.height * .3,
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                      child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5)),
                        child: Text('${itemDetailsBloc.page}/${images.length}'),
                  ),),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context, reload);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: white,
                        )),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
