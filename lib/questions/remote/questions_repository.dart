// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fuzzy_trivia/questions/data/model/qustions_model.dart';

// import '../../core/network/dio_provider.dart';
// import '../../core/network/endpoints.dart';

// final questionsRepository = Provider<QuestionsRepository>((ref) {
//   final dio = ref.read(dioProvider);
//   return QuestionsRepository(dio);
// });

// class QuestionsRepository {
//   Dio dio;

//   QuestionsRepository(this.dio);

//   getBasicQuestions() async {
//     try {
//       Response response = await dio.get(Endpoints.basic.path);

//       if (response.statusCode == 200) {
//         List<dynamic> questionsList = response.data;
//         List<Questions> questions = [];
//         for (var b in questionsList) {
//           questions.add(Questions.fromJson(b));
//         }

//         return questions;
//       }
//     } catch (_) {
//       rethrow;
//     }
//   }
// }
