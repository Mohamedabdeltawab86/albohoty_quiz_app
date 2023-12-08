import 'package:flutter/material.dart';
import '../model/quiz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizDetailsPage extends StatefulWidget {
  final Quiz quiz;

  const QuizDetailsPage({required this.quiz, Key? key}) : super(key: key);

  @override
  _QuizDetailsPageState createState() => _QuizDetailsPageState();
}

class _QuizDetailsPageState extends State<QuizDetailsPage> {
  late List<bool> _isDifficultList;
  late List<int> _selectedAnswers;
  bool _showAnswers = false;
  late Map<int, int?> _userAnswers; // Map to store user answers

  @override
  void initState() {
    super.initState();
    _isDifficultList = List.filled(widget.quiz.questions.length, false);
    _selectedAnswers = List<int>.filled(
        widget.quiz.questions.length, 0); // Initialize with the correct length
    _userAnswers = {}; // Map to store user answers

    _loadDifficultQuestions();
  }

  void _loadDifficultQuestions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String key = 'difficult_questions_${widget.quiz.title}';
    List<String>? difficultQuestions = prefs.getStringList(key);
    setState(() {
      _isDifficultList = List.generate(
        widget.quiz.questions.length,
        (index) => difficultQuestions?.contains(index.toString()) ?? false,
      );
    });
  }

  void _toggleDifficultQuestion(int index) async {
    setState(() {
      _isDifficultList[index] = !_isDifficultList[index];
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> difficultQuestions = [];
    for (int i = 0; i < _isDifficultList.length; i++) {
      if (_isDifficultList[i]) {
        difficultQuestions.add(i.toString());
      }
    }
    String key = 'difficult_questions_${widget.quiz.title}';
    prefs.setStringList(key, difficultQuestions);
  }

  void _submitQuiz() {
    List<int> correctAnswers =
        widget.quiz.questions.map((question) => question.answer).toList();

    setState(() {
      _selectedAnswers = List.from(correctAnswers);
      _userAnswers = Map.fromIterables(
        List.generate(widget.quiz.questions.length, (index) => index),
        _selectedAnswers,
      );
      _showAnswers = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.quiz.title,
            style: const TextStyle(fontFamily: 'Cairo'),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _submitQuiz,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.quiz.questions.length,
                  itemBuilder: (context, index) {
                    final question = widget.quiz.questions[index];
                    bool isDifficult = _isDifficultList[index];
                    bool isSelected = _selectedAnswers.length > index &&
                        _selectedAnswers[index] == question.answer;
                    bool isCorrectAnswer = _showAnswers && isSelected;

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            IconButton(
                              icon: Icon(
                                isDifficult ? Icons.flag : Icons.outlined_flag,
                                color: isDifficult ? Colors.red : Colors.grey,
                              ),
                              onPressed: () {
                                _toggleDifficultQuestion(index);
                              },
                            ),
                            SizedBox(
                              child: Text(
                               "${index + 1} - ${question.title}",
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Column(
                              children: [
                                for (int i = 0;
                                    i < question.choices.length;
                                    i++)
                                  RadioListTile<int>(
                                    value: i,
                                    groupValue: _showAnswers
                                        ? question.answer
                                        : _userAnswers[index],
                                    onChanged: _showAnswers
                                        ? null
                                        : (value) {
                                            setState(() {
                                              // Update the user answers map
                                              _userAnswers[index] = value;
                                            });
                                          },
                                    title: Text(
                                      question.choices[i],
                                      style: TextStyle(
                                        fontFamily: 'Cairo',
                                        color: isCorrectAnswer
                                            ? Colors.green
                                            : _showAnswers
                                                ? Colors.red
                                                : null,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              // ElevatedButton(
              //   onPressed: _submitQuiz,
              //   child: const Padding(
              //     padding: EdgeInsets.symmetric(vertical: 10.0),
              //     child: Text(
              //       'Submit Quiz',
              //       style: TextStyle(
              //         fontFamily: 'Cairo',
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
