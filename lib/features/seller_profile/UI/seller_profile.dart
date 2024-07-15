import 'package:adast/%20themes/themes.dart';
import 'package:adast/custom_widgets/custom_button.dart';
import 'package:adast/features/chat/chat_screen/UI/chat_screen.dart';
import 'package:adast/features/chat/chat_screen/bloc/chat_bloc.dart';
import 'package:adast/features/home_screen/bloc/home_bloc.dart';
import 'package:adast/features/item_details_page/UI/item_detail.dart';
import 'package:adast/features/item_details_page/bloc/item_details_bloc.dart';
import 'package:adast/features/seller_profile/bloc/seller_profile_bloc.dart';
import 'package:adast/features/splash_screen/bloc/splashscreen_bloc.dart';
import 'package:adast/methods/common_methods.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/custom_grid.dart';

class SellerProfile extends StatelessWidget {
  final HomeBloc homeBloc;
  const SellerProfile({super.key, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    SellerProfileBloc sellerProfileBloc = context.read();

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: sellerProfileBloc.sellerModel.image!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        capitalize(sellerProfileBloc.sellerModel.name),
                        style: mediumBlackTextStyle,
                      ),
                      subtitle: const Text('kozhikode'),
                    ),
                  ),
                  BlocBuilder<SellerProfileBloc, SellerProfileState>(
                    buildWhen: (previous, current) =>
                        current is SellerSubscribedState,
                    builder: (context, state) {
                      if (sellerProfileBloc.subscribed) {
                        return SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.34,
                          height: 70,
                          child: CustomButton(
                              onTap: () {
                                sellerProfileBloc.add(
                                    SellerProfileSubscribeUnsubEvent(
                                        userModel: context
                                            .read<SplashscreenBloc>()
                                            .userModel!,
                                        homeBloc: homeBloc));
                              },
                              text: 'subscribed'),
                        );
                      } else {
                        return SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.34,
                          height: 70,
                          child: CustomButton(
                              icon: true,
                              onTap: () {
                                sellerProfileBloc.add(
                                    SellerProfileSubscribeUnsubEvent(
                                        userModel: context
                                            .read<SplashscreenBloc>()
                                            .userModel!,
                                        homeBloc: homeBloc));
                              },
                              text: 'subscribe'),
                        );
                      }
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Shop for Best Men and Women Products at best price only at ${capitalize(sellerProfileBloc.sellerModel.name)} Stores',
                  style: greyTextStyle,
                ),
              ),
              BlocListener<SellerProfileBloc, SellerProfileState>(
                listener: (context, state) {
                  if (state is SellerProfileNavigateToChatState) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => ChatBloc(
                                sellerModel: sellerProfileBloc.sellerModel,
                                chatRoomModel: state.chatRoomModel),
                                child:const ChatScreen(),
                          ),
                          
                        ));
                  }
                },
                child: CustomButton(
                  onTap: () {
                    sellerProfileBloc.add(SellerProfileMessageTappedEvent(
                        userId:
                            context.read<SplashscreenBloc>().userModel!.email));
                  },
                  text: 'Message',
                  icon: true,
                ),
              ),
              const Divider(),
              BlocBuilder<SellerProfileBloc, SellerProfileState>(
                builder: (context, state) {
                  if (state is SellerProfileItemsLoadingState) {
                    return SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.5,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    if (sellerProfileBloc.items.isEmpty) {
                      return const Center(
                        child: Text('No items available'),
                      );
                    }
                    return SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        children: [
                          ...sellerProfileBloc.items.map(
                            (e) => Builder(builder: (context) {
                              return GestureDetector(
                                onTap: () {
                                  ItemDetailsBloc itemDetailsBloc =
                                      ItemDetailsBloc(item: e);
                                  itemDetailsBloc.sellerModel =
                                      sellerProfileBloc.sellerModel;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                          create: (context) => itemDetailsBloc,
                                          child: ItemDetails(
                                            homeBloc: homeBloc,
                                          ),
                                        ),
                                      ));
                                },
                                child: CustomGrid(clothModel: e),
                              );
                            }),
                          )
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
