import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/constants.dart';
import 'package:fuzzy_trivia/premium_features/profile/controller/profie_controller.dart';
import 'package:get/get.dart';

import '../../../auth/controller/auth_controller.dart';
import '../../single_player/match_making/ui/button.dart';
import '../../single_player/match_making/ui/input_widget.dart';
import '../controller/image_picker_controller.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({super.key});

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  final ImagePickerController _imagePickerController =
      Get.put(ImagePickerController());
  final _formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();

  final ProfileController profileController = Get.put(ProfileController());
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(() => Container(
              height: 120,
              width: 120,
              margin: const EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(120),
                  border: Border.all(color: primaryGreen, width: 2)),
              child: _imagePickerController.pickedImage.value != null
                  ? ClipOval(
                      child: Image.file(
                        File(_imagePickerController.pickedImage.value!.path),
                        fit: BoxFit.cover,
                      ),
                    )
                  : _imagePickerController.imageUrl.value.isNotEmpty
                      ? ClipOval(
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: _imagePickerController.imageUrl.value,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(
                              color: primaryGreen,
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(
                              profileController.profilePicture.value),
                        ))),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  InputWidget(
                    formKey: _formKey,
                    color: inputBackground,
                    hint: "Username",
                    controller: controller,
                  ),
                ],
              )),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    _imagePickerController.pickImageFromGallery();
                  },
                  child: Container(
                      width: 180,
                      height: 32,
                      decoration: BoxDecoration(
                          color: buttonGrey,
                          borderRadius: BorderRadius.circular(15)),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.photo_library_outlined,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Pick from gallery",
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Or the avatars below',
                  style: TextStyle(color: primaryGreen),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Obx(
              () => Wrap(
                children: profileController.imageUrls
                    .map(
                      (url) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () =>
                              _imagePickerController.pickImageFromUrl(url),
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color:
                                    _imagePickerController.isSelected.value &&
                                            url ==
                                                _imagePickerController
                                                    .imageUrl.value
                                        ? secondaryGreen
                                        : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: url,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(
                                color: primaryGreen,
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            width: 230,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Button(
              title: "Update Profile",
              color: secondaryGreen,
              txtColor: Colors.white,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  await profileController.verifyUsername(controller.text);

                  await _imagePickerController
                      .uploadProfilePicture(authController.user.value!.uid);

                  if (profileController.usernameBool == false) {
                    await profileController.updateProfile(
                        authController.user.value!.uid, controller.text);
                  } else {
                    Get.snackbar('Error', 'Username already exists',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red);
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
