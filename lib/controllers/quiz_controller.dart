import 'package:amaliyot_vazifa/services/quiz_services.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuizController extends ChangeNotifier {
  final _quizFirebaseServices = QuizFirebaseServices();

  Stream<QuerySnapshot> get list {
    return _quizFirebaseServices.getQuizzes();
  }

  Future<void> addQuiz(String questionText, List<String> options, int correctAnswerIndex) async {
    await _quizFirebaseServices.addQuiz(
      questionText,
      options,
      correctAnswerIndex,
    );
    notifyListeners();
  }

  Future<void> editQuiz(String id, String questionText, List<String> options, int correctAnswerIndex) async {
    await _quizFirebaseServices.editQuiz(
      id,
      questionText,
      options,
      correctAnswerIndex,
    );
    notifyListeners();
  }

  Future<void> deleteQuiz(String id) async {
    await _quizFirebaseServices.deleteQuiz(id);
    notifyListeners();
  }
}