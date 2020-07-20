class Questions {
  String id;
  String category;
  String question;
  String answer;
  List<dynamic> options;

  Questions({this.answer, this.category, this.options, this.question, this.id});


   Map<String, dynamic> toMap() {
    return {
      'category': category,
      'questions': question,
      'answer': answer,
      'options': options
    };
  }

  factory Questions.fromMap(Map<String, dynamic> json) {
    return Questions(
      id: json['id'],
      category: json['category'],
      question: json['question'],
      answer: json['answer'],
      options: json['options']
    );
  }
}