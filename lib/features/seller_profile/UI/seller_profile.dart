import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/%20themes/themes.dart';
import 'package:adast/custom_widgets/custom_button.dart';
import 'package:adast/features/seller_profile/bloc/seller_profile_bloc.dart';
import 'package:adast/methods/common_methods.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/custom_grid.dart';

class SellerProfile extends StatelessWidget {
  const SellerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    SellerProfileBloc sellerProfileBloc = context.read()..add(SellerProfileItemLoadingEvent());
    
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
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
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.34,
                  height: 70,
                  child: CustomButton(onTap: () {}, text: 'subscribe'),
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
            CustomButton(
              onTap: () {},
              text: 'Message',
              icon: true,
            ),
            const Divider(),
            Expanded(
              child: BlocBuilder<SellerProfileBloc, SellerProfileState>(
                builder: (context, state) {
                  if(state is SellerProfileItemsLoadingState)
                  {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  else {
                    if(sellerProfileBloc.items.isEmpty)
                    {
                      return const Center(child:  Text('No items available'),);
                    }
                    return SizedBox(
                      width: double.infinity,
                    
                      child: SingleChildScrollView(
                        child:  Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        children: [
                          ...sellerProfileBloc.items.map((e) => GestureDetector(
                          onTap: () {},
                          child: CustomGrid(
                              clothModel: e),
                        ),)
                        ],
                        // itemCount: sellerProfileBloc.items.length,
                        // gridDelegate:
                        //     const SliverGridDelegateWithFixedCrossAxisCount(
                        //         crossAxisCount: 2),
                        // itemBuilder: (context, index) => GestureDetector(
                        //   onTap: () {},
                        //   child: CustomGrid(
                        //       clothModel: sellerProfileBloc.items[index]),
                        // ),
                      ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
