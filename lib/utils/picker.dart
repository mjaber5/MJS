import 'package:image_picker/image_picker.dart';

pickImage() async {
  ImagePicker imagePicker = ImagePicker();

  XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

  if (file != null) {
    return await file.readAsBytes();
  }
}

takePhoto() async {
  ImagePicker imagePicker = ImagePicker();

  XFile? file = await imagePicker.pickImage(source: ImageSource.camera);

  if (file != null) {
    return await file.readAsBytes();
  }
}
