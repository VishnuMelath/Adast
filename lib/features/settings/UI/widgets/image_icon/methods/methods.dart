
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../ themes/colors_shemes.dart';

Future<String?> pickImageFromGallery() async {
  var image = await ImagePicker().pickImage(source: ImageSource.gallery);
  String? croppedFilePath;
  if (image != null) {
  croppedFilePath= await cropImage(image.path);
  }
  
  return croppedFilePath;
}

Future<String?> pickImageFromCamera() async {
  var image = await ImagePicker().pickImage(source: ImageSource.camera);
   String? croppedFilePath;
if (image != null) {
  croppedFilePath= await cropImage(image.path);
  }
  return croppedFilePath;
}

Future<String?> cropImage(String imagePath) async {
  var croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      compressQuality: 100,
      compressFormat: ImageCompressFormat.jpg,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          showCropGrid: false,
          toolbarTitle: 'Cropper',
          toolbarColor: green,
          toolbarWidgetColor: white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        )
      ]);

  return croppedFile?.path;
}
