

import 'package:adast/features/splash_screen/bloc/splashscreen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../ themes/colors_shemes.dart';
import '../../../../../../ themes/themes.dart';
import '../../../../../../custom_widgets/custom_icon_button.dart';
import '../bloc/image_icon_bloc.dart';

class ImageIconWidget extends StatelessWidget {
  const ImageIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ImageIconBloc imageIconBloc = context.read<ImageIconBloc>();
    String imageAddress = context.read<SplashscreenBloc>().userModel!.image!;
    imageIconBloc.imageUrl=imageAddress;
    return BlocListener<ImageIconBloc, ImageIconState>(
      listener: (context, state) {
        if (state is ImageIconShowBottomSheetState) {
          showModalBottomSheet(
            backgroundColor: green,
            context: context,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                   Text(
                    'Profile Picture',
                    style: whiteHeadTextStyle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomIconButton(
                          onTap: () {
                            imageIconBloc.add(CameraIconPressedEvent(email:context.read<SplashscreenBloc>().userModel!.email ));
                          },
                          icon: 'Camera'),
                      CustomIconButton(
                          onTap: () async {
                            imageIconBloc.add(GalaryIconPressedEvent(email:context.read<SplashscreenBloc>().userModel!.email ));
                          },
                          icon: 'Gallery')
                    ],
                  ),
                ],
              ),
            ),
          );
        } else if (state is ImagePickCompleteState) {
          Navigator.pop(context);
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.03,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            BlocBuilder<ImageIconBloc, ImageIconState>(
              bloc: imageIconBloc,
              builder: (context, state) {
               
                var loading = false;
                if (state is ImageIconChangedState) {
                  loading = state.loading;
                  if (state.imageUrl != null) {
                    imageAddress = state.imageUrl!;
                  }
                }
                return CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(imageAddress),
                  child: loading
                      ? const CircularProgressIndicator()
                      : const SizedBox(),
                );
              },
            ),
            Container(
              decoration: BoxDecoration(
                  color: green, borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () async {
                  imageIconBloc.add(ImageIconPressedEvent());
                },
                child: Image.asset(
                  'assets/images/image.png',
                  width: 10,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
