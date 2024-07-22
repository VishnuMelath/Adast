part of 'image_icon_bloc.dart';

@immutable
abstract class ImageIconEvent {}

class ImageIconPressedEvent extends ImageIconEvent{
  
}

class CameraIconPressedEvent extends ImageIconEvent{
  final String email;

  CameraIconPressedEvent({required this.email});


}

class GalaryIconPressedEvent extends ImageIconEvent{
  final String email;

  GalaryIconPressedEvent({required this.email});
}


