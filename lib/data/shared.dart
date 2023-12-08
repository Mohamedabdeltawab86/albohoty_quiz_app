import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/quiz.dart';


// Function to save the list of quizzes to shared preferences
Future<void> saveQuizzesToPrefs(List<Quiz> quizzes) async {
  final prefs = await SharedPreferences.getInstance();
  List<Map<String, dynamic>> jsonList =
      quizzes.map((quiz) => quiz.toJson()).toList();
  await prefs.setString('quizzes', jsonEncode(jsonList));
}

// Function to load the list of quizzes from shared preferences
Future<List<Quiz>> loadQuizzesFromPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = prefs.getString('quizzes');
  if (jsonString != null) {
    List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => Quiz.fromJson(json)).toList();
  } else {
    return [];
  }
}
