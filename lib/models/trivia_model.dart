class Questions {
  String? category;
  String? id;
  String? correctAnswer;
  List<String>? incorrectAnswers;
  String? question;
  List<String>? tags;
  String? type;
  String? difficulty;
  bool? isNiche;

  Questions(
      {this.category,
      this.id,
      this.correctAnswer,
      this.incorrectAnswers,
      this.question,
      this.tags,
      this.type,
      this.difficulty,
      this.isNiche});

  Questions.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    id = json['id'];
    correctAnswer = json['correctAnswer'];
    incorrectAnswers = json['incorrectAnswers'].cast<String>();
    question = json['question'];
    tags = json['tags'].cast<String>();
    type = json['type'];
    difficulty = json['difficulty'];
    isNiche = json['isNiche'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['id'] = this.id;
    data['correctAnswer'] = this.correctAnswer;
    data['incorrectAnswers'] = this.incorrectAnswers;
    data['question'] = this.question;
    data['tags'] = this.tags;
    data['type'] = this.type;
    data['difficulty'] = this.difficulty;
    data['isNiche'] = this.isNiche;
    return data;
  }
}
