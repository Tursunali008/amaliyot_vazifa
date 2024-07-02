

import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';

class Question {
  final String id;
  final String questionText;
  final List<String> options;
  final num correctAnswerIndex;

  Question({
    required this.id,
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
  });

  bool isCorrect(int selectedIndex) {
    return selectedIndex == correctAnswerIndex;
  }

  factory Question.fromJson(QueryDocumentSnapshot query) {
    return Question(
      id: query.id,
      questionText: query["questionText"],
      options: List<String>.from(
          query["options"].map((dynamic item) => item as String)),
      correctAnswerIndex: query["correctAnswerIndex"],
    );
  }
}
