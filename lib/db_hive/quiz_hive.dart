import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import '../model/question.dart';
part 'quiz_hive.g.dart';

@HiveType(typeId: 0)
@JsonSerializable(createToJson: true)
class QuizHive extends Equatable {
  @HiveField(0)
  final String key;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final int grade;
  @HiveField(3)
  final List<Question> questions;
  @HiveField(4)
  @JsonKey(fromJson: _dateFromString)
  final DateTime lastRevised;
  const QuizHive({
    required this.key,
    required this.title,
    required this.grade,
    required this.questions,
    required this.lastRevised,
  });

  List<Object?> get props => [key, title, grade, questions, lastRevised];

  factory QuizHive.fromJson(Map<String, dynamic> json) =>
      _$QuizHiveFromJson(json);

  Map<String, dynamic> toJson() => _$QuizHiveToJson(this);

  static DateTime _dateFromString(String date) => DateTime.parse(date);
}
