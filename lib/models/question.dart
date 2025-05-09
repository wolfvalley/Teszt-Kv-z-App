class Question1 {
  final String question;
  final List<String> answers;
  final int correctIndex;

  Question1({
    required this.question,
    required this.answers,
    required this.correctIndex,
  });

  factory Question1.fromJson(Map<String, dynamic> json) {
    return Question1(
      question: json['question'],
      answers: List<String>.from(json['answers']),
      correctIndex: json['correct_index'],
    );
  }
}
