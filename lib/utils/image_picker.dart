import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static final _picker = ImagePicker();

   static Future<String?> pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    return pickedFile?.path;
  }

   static Future<String?> pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    return pickedFile?.path;
  }


}
