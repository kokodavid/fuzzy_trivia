import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../repository/profile_repository.dart';

class ImagePickerController extends GetxController {
  Rx<XFile?> pickedImage = Rx<XFile?>(null);
  File? file;
  RxString imageUrl = RxString('');
  RxBool isSelected = RxBool(false);
  Rx<UploadOption> selectedUploadOption = Rx<UploadOption>(UploadOption.url);
  final ProfileRepository profileRepository = ProfileRepository();

  void pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      this.pickedImage.value = pickedImage;
      imageUrl.value = '';
      isSelected.value = false;
      selectedUploadOption.value = UploadOption.gallery;
    }
  }

  void pickImageFromUrl(String url) {
    pickedImage.value = null;
    imageUrl.value = url;
    isSelected.value = true;
    selectedUploadOption.value = UploadOption.url;
  }

  Future<String?> uploadProfilePicture(String userId) async {
    if (selectedUploadOption.value == UploadOption.gallery) {
      try {
        if (pickedImage.value != null) {
          Reference storageRef = FirebaseStorage.instance
              .ref()
              .child('profile_pictures/$userId.jpg');

          UploadTask uploadTask =
              storageRef.putFile(File(pickedImage.value!.path));
          TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);

          String downloadUrl = await snapshot.ref.getDownloadURL();
          return downloadUrl;
        } 
      } catch (error) {
        log('Failed to upload profile picture: $error');
      }
      return null;
    } else if (selectedUploadOption.value == UploadOption.url) {
      try {
        // ignore: unnecessary_null_comparison
        if (imageUrl.value != null) {
          Reference storageRef = FirebaseStorage.instance
              .ref()
              .child('profile_pictures/$userId.jpg');

          final http.Response response =
              await http.get(Uri.parse(imageUrl.value));
          final imageData = response.bodyBytes;

          UploadTask uploadTask = storageRef.putData(imageData);
          TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);

          String downloadUrl = await snapshot.ref.getDownloadURL();
          return downloadUrl;
        } 
      } catch (error) {
        log('Failed to upload profile picture: $error');
      }
    }
    return null;
  }
}

enum UploadOption {
  gallery,
  url,
}
