import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import '../model/quiz.dart';
import 'quiz_detail_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  Future<String> loadAsset(String path, BuildContext context) async {
    return await DefaultAssetBundle.of(context).loadString(path);
  }

  Future<List<Quiz>> loadQuizzes(BuildContext context) async {
    List<Quiz> quizzes = [];

    List<String> jsonFiles = [
      'النكاح 01.json',
      'النكاح 02.json',
      'النكاح 03.json',
      'النكاح 04.json',
      'النكاح 05.json',
      'النكاح 06.json',
      'النكاح 07.json',
      'النكاح 08.json',
      'النكاح 09.json',
      'النكاح 10.json',
      'النكاح 11.json',
      'النكاح 12.json',
      'النكاح 13.json',
      'النكاح 14.json',
      'النكاح 15.json',
      'النكاح 16.json',
      'النكاح 17.json',
      'النكاح 18.json',
      'النكاح 19.json',
      'النكاح 20.json',
      'النكاح 21.json',
      'logic-01.json',
      'logic-02.json',
      'logic-03.json',
      'logic-04.json',
      'logic-05.json',
      'logic-06.json',
      'logic-07.json',
      'logic-08.json',
      'logic-09.json',
      'logic-10.json',
      'logic-11.json',
      'logic-12.json',
      'logic-13.json',
      'logic-14.json',
      'logic-15.json',
      'logic-16.json',
      'logic-17.json',
      'logic-18.json',
    ];

    for (String jsonFile in jsonFiles) {
      String jsonString = await loadAsset('assets/$jsonFile', context);
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      Quiz quiz = Quiz.fromJson(jsonMap);
      quizzes.add(quiz);
      // print(quizzes.first);
    }

    return quizzes;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "معهد البهوتي",
            style: TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: FutureBuilder<List<Quiz>>(
          future: loadQuizzes(context),
          builder: (context, snapshot) {
            print(snapshot.error);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // print('aaa');
              return const Center(child: Text("Error loading quizzes."));
            } else if (snapshot.hasData) {
              List<Quiz> quizzes = snapshot.data!;
              return ListView.builder(
                itemCount: quizzes.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${index+1} . ${quizzes[index].title}",
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "آخر تحديث: ${DateFormat('yyyy-MM-dd hh:mm').format(quizzes[index].lastRevised)}",
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      trailing: InkWell(
                        onTap: () {
                          // عند النقر على العلم
                          Fluttertoast.showToast(
                            msg:
                                "تم فتح الاختبار في: ${DateFormat('yyyy-MM-dd').format(quizzes[index].lastRevised)}",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        },
                        child: const Icon(
                          Icons.flag,
                          color: Colors
                              .green, // لون العلم عندما يكون الاختبار مفتوحًا
                        ),
                      ),
                      onTap: () {
                        // Navigate to quiz details page with the selected quiz data
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                QuizDetailsPage(quiz: quizzes[index]),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text("No quizzes found."));
            }
          },
        ),
      ),
    );
  }
}
