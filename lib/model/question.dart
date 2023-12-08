class Question {
  String number;
  String title;
  int answer;
  List<String> choices;

  bool isDifficult;

  Question({
    required this.number,
    required this.title,
    required this.answer,
    required this.choices,

    this.isDifficult = false,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    var choicesList = json['choices'] as List<dynamic>;
    List<String> choices = choicesList.cast<String>();



    return Question(
      number: json['number'],
      title: json['title'],
      answer: json['answer'],
      choices: choices,

      isDifficult: json['isDifficult'] ??
          false, // Default value for isDifficult is false
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'title': title,
      'answer': answer,
      'choices': choices,
    
      'isDifficult': isDifficult,
    };
  }
}
