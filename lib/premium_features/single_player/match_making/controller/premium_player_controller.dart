import 'package:get/get.dart';

class PremiumPlayerController extends GetxController {
  final List<String> categories = [
    'Music',
    'Sports',
    'Film',
    'History',
    'Arts & Literature',
    'Science',
    'Geography',
    'Culture',
    'Food',
    'General Knowledge'
  ];

  final List<String> difficulties = ['Easy', 'Medium', 'Hard'];

  final List<String> originDiff = ['easy', 'medium', 'hard'];

  final List<String> originCategory = [
    'music',
    'sport_and_leisure',
    'film_and_tv',
    'history',
    'arts_and_literature',
    'science',
    'geography',
    'society_and_culture',
    'food_and_drink',
    'general_knowledge'
  ];
}
