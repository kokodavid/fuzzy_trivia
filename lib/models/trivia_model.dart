// To parse this JSON data, do
//
//     final triviaModel = triviaModelFromJson(jsonString);

import 'dart:convert';

List<TriviaModel> triviaModelFromJson(String str) => List<TriviaModel>.from(json.decode(str).map((x) => TriviaModel.fromJson(x)));

String triviaModelToJson(List<TriviaModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TriviaModel {
    TriviaModel({
        required this.category,
        required this.id,
        required this.correctAnswer,
        required this.incorrectAnswers,
        required this.question,
        required this.tags,
        required this.type,
        required this.difficulty,
        required this.regions,
        required this.isNiche,
    });

    String category;
    String id;
    String correctAnswer;
    List<String> incorrectAnswers;
    String question;
    List<String> tags;
    String type;
    String difficulty;
    List<dynamic> regions;
    bool isNiche;

    factory TriviaModel.fromJson(Map<String, dynamic> json) => TriviaModel(
        category: json["category"],
        id: json["id"],
        correctAnswer: json["correctAnswer"],
        incorrectAnswers: List<String>.from(json["incorrectAnswers"].map((x) => x)),
        question: json["question"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        type: json["type"],
        difficulty: json["difficulty"],
        regions: List<dynamic>.from(json["regions"].map((x) => x)),
        isNiche: json["isNiche"],
    );

    Map<String, dynamic> toJson() => {
        "category": category,
        "id": id,
        "correctAnswer": correctAnswer,
        "incorrectAnswers": List<dynamic>.from(incorrectAnswers.map((x) => x)),
        "question": question,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "type": type,
        "difficulty": difficulty,
        "regions": List<dynamic>.from(regions.map((x) => x)),
        "isNiche": isNiche,
    };
}
