class Survey {
  String title;
  List<Question> questions;

  Survey({required this.title, required this.questions});

  factory Survey.fromMap(Map<String, dynamic> data) {
    var questionsFromJson = data['questions'] as List;
    List<Question> questionsList =
        questionsFromJson.map((item) => Question.fromMap(item)).toList();

    return Survey(
      title: data['title'],
      questions: questionsList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'questions': questions.map((q) => q.toMap()).toList(),
    };
  }
}

class Question {
  String question;
  List<String> options;

  Question({required this.question, required this.options});

  factory Question.fromMap(Map<String, dynamic> data) {
    return Question(
      question: data['question'],
      options: List<String>.from(data['options']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'options': options,
    };
  }
}
