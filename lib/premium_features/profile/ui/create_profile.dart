import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/constants.dart';
import 'package:fuzzy_trivia/premium_features/premium_home.dart';
import 'package:get/get.dart';

import '../../../auth/controller/auth_controller.dart';
import '../../single_player/match_making/ui/button.dart';
import '../../single_player/match_making/ui/input_widget.dart';
import '../controller/image_picker_controller.dart';
import '../controller/profie_controller.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({super.key});

  @override
  State<CreateProfilePage> createState() => _CreatProfilePageState();
}

class _CreatProfilePageState extends State<CreateProfilePage> {
  final ImagePickerController imagePickerController =
      Get.put(ImagePickerController());
  final ProfileController profileController = Get.put(ProfileController());
  final _formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  final AuthController authController = Get.put(AuthController());
  List<String> friends = [];
  List<String> requests = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: profileBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: kTextTabBarHeight * 1.5,
            ),
            const Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Text(
                    'Create Profile',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryGreen),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Obx(() => Container(
                    height: 120,
                    width: 120,
                    margin: const EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(120),
                        border: Border.all(color: primaryGreen, width: 2)),
                    child: imagePickerController.pickedImage.value != null
                        ? ClipOval(
                            child: Image.file(
                              File(imagePickerController
                                  .pickedImage.value!.path),
                              fit: BoxFit.cover,
                            ),
                          )
                        : imagePickerController.imageUrl.value.isNotEmpty
                            ? ClipOval(
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      imagePickerController.imageUrl.value,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(
                                    color: primaryGreen,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              )
                            : Container())),
              ],
            ),
            Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                      imagePickerController.pickImageFromGallery();
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
                                imagePickerController.pickImageFromUrl(url),
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color:
                                      imagePickerController.isSelected.value &&
                                              url ==
                                                  imagePickerController
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
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Button(
                title: "Create Profile",
                color: secondaryGreen,
                txtColor: Colors.white,
                onPressed: () async {
                  await profileController
                      .uploadProfilePicture(authController.user.value!.uid);

                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    await profileController.verifyUsername(controller.text);

                    try {
                      if (profileController.usernameBool == false &&
                          profileController.profileUrl != null) {
                        await profileController.uploadProfile(
                            authController.user.value!.uid,
                            controller.text,
                            0,
                            false,
                            profileController.profileUrl,
                            friends,
                            requests
                            );

                        Get.to(() => const PremiumHome());
                      } else {
                        profileController.usernameBool != false
                            ? Get.snackbar('Error', 'Username already exists',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.red)
                            : Get.snackbar(
                                'Error', 'Please select a profile picture',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.red);
                      }
                    } catch (e) {
                      log(e.toString());
                    }
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
