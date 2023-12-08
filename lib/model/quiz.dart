import 'question.dart';

class Quiz {
  String key;
  String title;
  String grade;
  List<Question> questions;
  DateTime lastRevised;

  Quiz({
    required this.key,
    required this.title,
    required this.grade,
    required this.questions,
    required this.lastRevised,
  });

factory Quiz.fromJson(Map<String, dynamic> json) {
  String key = json['title'] as String;

  var questionList = json['questions'] as List<dynamic>;
  List<Question> questions =
      questionList.map((question) => Question.fromJson(question)).toList();

  DateTime? lastRevisedDate; // استخدم DateTime? لتحديد أنه يمكن أن يكون القيمة null
  final lastRevisedString = json['lastRevised'] as String?;
  if (lastRevisedString != null) {
    lastRevisedDate = DateTime.parse(lastRevisedString);
  }

  return Quiz(
    key: key,
    title: json['title'] as String,
    grade: json['grade'] as String,
    questions: questions, 
    lastRevised: lastRevisedDate ?? DateTime.now(), );
  }

  // Add a toJson method to convert the Quiz object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'grade': grade,
      'questions': questions.map((question) => question.toJson()).toList(),
      'lastRevised': lastRevised.toIso8601String(), // Convert DateTime to string

    };
  }
}
