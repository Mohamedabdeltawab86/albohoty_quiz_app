import 'package:albohoty_quiz_app/utils/constants..dart';
import 'package:hive/hive.dart';

import 'quiz_hive.dart';

Box<QuizHive> quizBox = Hive.box<QuizHive>(quizKey);
Future<void> saveQuiz(QuizHive quiz) async {
  final box = await Hive.openBox<QuizHive>('quizzes');
  await box.put(quiz.key, quiz);
}

Future<QuizHive?> getQuiz(String key) async {
  final box = await Hive.openBox<QuizHive>('quizzes');
  return box.get(key);
}
 