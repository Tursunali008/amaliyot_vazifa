import 'package:cloud_firestore/cloud_firestore.dart';

class QuizFirebaseServices {
  final _quizCollection = FirebaseFirestore.instance.collection("quizzes");

  Stream<QuerySnapshot> getQuizzes() {
    return _quizCollection.snapshots();
  }

  Future<void> addQuiz(String questionText, List<String> options, int correctAnswerIndex) async {
    try {
      await _quizCollection.add({
        "questionText": questionText,
        "options": options,
        "correctAnswerIndex": correctAnswerIndex,
      });
    } catch (e) {
      print("Failed to add quiz: $e");
    }
  }

  Future<void> editQuiz(String id, String questionText, List<String> options, int correctAnswerIndex) async {
    try {
      await _quizCollection.doc(id).update({
        "questionText": questionText,
        "options": options,
        "correctAnswerIndex": correctAnswerIndex,
      });
    } catch (e) {
      print("Failed to edit quiz: $e");
    }
  }

  Future<void> deleteQuiz(String id) async {
    try {
      await _quizCollection.doc(id).delete();
    } catch (e) {
      print("Failed to delete quiz: $e");
    }
  }
}