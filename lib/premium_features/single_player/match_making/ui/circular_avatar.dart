import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/constants.dart';
import 'package:get/get.dart';

class LoadingCircleAvatar extends StatelessWidget {
  final String imageUrl;
  final double radius;

  const LoadingCircleAvatar({
    super.key,
    required this.imageUrl,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final isLoading = true.obs;

    void loadImage() async {
      final image = NetworkImage(imageUrl);
      await precacheImage(image, context);
      isLoading.value = false;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadImage();
    });

    return Obx(() => Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: primaryGreen),
                  borderRadius: BorderRadius.circular(radius)),
              child: CircleAvatar(
                radius: radius,
                backgroundImage: NetworkImage(imageUrl),
              ),
            ),
            if (isLoading.value)
              const CircularProgressIndicator(
                color: primaryGreen,
                strokeWidth: 1,
              ), // Replace with your custom loader widget
          ],
        ));
  }
}
