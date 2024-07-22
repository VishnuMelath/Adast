part of 'image_icon_bloc.dart';

@immutable
sealed class ImageIconState {}

abstract class ImageIconActionState extends ImageIconState{}

class ImageIconShowBottomSheetState extends ImageIconActionState{}

final class ImageIconInitial extends ImageIconState {}

class ImageIconChangedState extends ImageIconState{
  final bool loading;
  final String? imageUrl;

  ImageIconChangedState({required this.imageUrl,required this.loading});

}

class ImagePickCompleteState extends ImageIconActionState{}

class NoImageState extends ImageIconState{}

class ImagePickErrorState extends ImageIconState{}