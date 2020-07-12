class Quiz {
  List<Question> questions;

  Quiz({
    this.questions,
  });
}

class Question {
  String id;
  String question;
  String category;
  String answer;
  List<String> options;

  Question({
    this.id,
    this.question,
    this.category,
    this.answer,
    this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        question: json["question"],
        category: json["category"],
        answer: json["answer"],
        options: List<String>.from(json["options"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "category": category,
        "answer": answer,
        "options": List<dynamic>.from(options.map((x) => x)),
      };
}
