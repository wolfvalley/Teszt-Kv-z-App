import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';

@JsonSerializable()
class Question {
  String question;
  List<String> answers;
  int correct_index;

  Question(
      {this.question = '', this.answers = const [], this.correct_index = 0});

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}

@JsonSerializable()
class Chapter {
  String name;
  List<Question> questions;

  Chapter({this.name = '', this.questions = const []});

  factory Chapter.fromJson(Map<String, dynamic> json) =>
      _$ChapterFromJson(json);
  Map<String, dynamic> toJson() => _$ChapterToJson(this);
}

@JsonSerializable()
class SubjectAndGrade {
  String name;
  List<Chapter> chapters;

  SubjectAndGrade({this.name = '', this.chapters = const []});

  factory SubjectAndGrade.fromJson(Map<String, dynamic> json) =>
      _$SubjectAndGradeFromJson(json);
  Map<String, dynamic> toJson() => _$SubjectAndGradeToJson(this);
}
