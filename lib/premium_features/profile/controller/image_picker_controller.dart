import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
  Rx<XFile?> pickedImage = Rx<XFile?>(null);
  RxString imageUrl = RxString('');
  RxBool isSelected = RxBool(false);


  void pickImageFromGallery() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      this.pickedImage.value = pickedImage;
      imageUrl.value = '';
      isSelected.value = false;
    }
  }

  void pickImageFromUrl(String url) {
    pickedImage.value = null;
    imageUrl.value = url;
    isSelected.value = true;
  }
}