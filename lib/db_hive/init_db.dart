import 'package:albohoty_quiz_app/utils/constants..dart';
import 'package:hive_flutter/adapters.dart';

import 'quiz_hive.dart';



Future<void> intiDB() async {
  await Hive.initFlutter();

  Hive.registerAdapter(QuizHiveAdapter());

  await Hive.openBox(quizKey);
}