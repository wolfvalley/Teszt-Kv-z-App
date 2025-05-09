// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      question: json['question'] as String? ?? '',
      answers: (json['answers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      correct_index: (json['correct_index'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'question': instance.question,
      'answers': instance.answers,
      'correct_index': instance.correct_index,
    };

Chapter _$ChapterFromJson(Map<String, dynamic> json) => Chapter(
      name: json['name'] as String? ?? '',
      questions: (json['questions'] as List<dynamic>?)
              ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ChapterToJson(Chapter instance) => <String, dynamic>{
      'name': instance.name,
      'questions': instance.questions,
    };

SubjectAndGrade _$SubjectAndGradeFromJson(Map<String, dynamic> json) =>
    SubjectAndGrade(
      name: json['name'] as String? ?? '',
      chapters: (json['chapters'] as List<dynamic>?)
              ?.map((e) => Chapter.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SubjectAndGradeToJson(SubjectAndGrade instance) =>
    <String, dynamic>{
      'name': instance.name,
      'chapters': instance.chapters,
    };
