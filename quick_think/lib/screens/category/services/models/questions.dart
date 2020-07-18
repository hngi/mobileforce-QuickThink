class Questions {
  String category;
  String question;
  String answer;
  List<String> options;

  Questions({this.answer, this.category, this.options, this.question});


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
      category: json['category'],
      question: json['question'],
      answer: json['answer'],
      options: json['options']
    );
  }
}