
import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/features/home_screen/bloc/home_bloc.dart';
import 'package:adast/features/map/UI/widgets/search_bar.dart';
import 'package:adast/features/map/UI/widgets/seller_tile.dart';
import 'package:adast/features/map/bloc/map_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchWidget extends StatelessWidget {
  final MapBloc mapBloc;
  const SearchWidget({super.key, required this.mapBloc});

  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc=context.read();
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SearchBarMapScreen(mapBloc: mapBloc),
            BlocBuilder<MapBloc, MapState>(
              bloc: mapBloc,
              builder: (context, state) {
                if (state is MapSearchedState) {
                  if (mapBloc.sellers.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('not found'),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        ...mapBloc.sellers.map(
                          (e) => SellerTile(sellerModel: e,googleMapController: mapBloc.googleMapController,homeBloc: homeBloc,),
                        )
                      ]),
                    );
                  }
                } else if (state is MapSearchingState) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
