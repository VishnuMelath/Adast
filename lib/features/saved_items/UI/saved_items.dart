import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/custom_widgets/custom_appbar.dart';
import 'package:adast/features/home_screen/bloc/home_bloc.dart';
import 'package:adast/features/saved_items/UI/widgets/loaded_tiles.dart';
import 'package:adast/features/saved_items/bloc/saved_bloc.dart';
import 'package:adast/features/splash_screen/bloc/splashscreen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/loading_tiles.dart';

class SavedItemsScreen extends StatelessWidget {
  final HomeBloc homeBloc;
  const SavedItemsScreen({super.key, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    SavedBloc savedBloc = SavedBloc();
    SplashscreenBloc splashscreenBloc = context.read();
    if(splashscreenBloc.userModel!.saved.isNotEmpty)
    {
      savedBloc.add(SavedItemsLoadingEvent(ids:  splashscreenBloc.userModel!.saved));
    }
    return Container(
        color: white,
        child: SafeArea(
            child: Scaffold(
              backgroundColor: backgroundColor,
          appBar: customAppBar('Saved', context),
          body: BlocBuilder(
            bloc: savedBloc,
            builder: (context, state) {
              if (splashscreenBloc.userModel!.saved.isEmpty) {
                return const Center(
                      child: Text('No items saved'),
                    );
              } else if(state is SavedLoadingState){
                
               return  loadingTiles(splashscreenBloc.userModel!.saved.length,context);
              }
              else if(state is SavedErrorState)
              {
                 return  Center(
                      child: Text(state.error),
                    );
              }
              else 
              {
                return loadedTiles(savedBloc.items.values.toList(), context,homeBloc,savedBloc);
              }
            },
          ),
        )));
  }
}
