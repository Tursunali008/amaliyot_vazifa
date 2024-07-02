import 'package:amaliyot_vazifa/controllers/quiz_controller.dart';
import 'package:amaliyot_vazifa/model/quiz.dart';
import 'package:amaliyot_vazifa/view/widgets/leaders_widget.dart';
import 'package:amaliyot_vazifa/view/widgets/quiz_widget.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageQuestionScreen extends StatelessWidget {
  const ManageQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final QuizController quizController = context.read<QuizController>();
    return Scaffold(
      backgroundColor: const Color(0xff8582e5),
      appBar: AppBar(
        backgroundColor: const Color(0xff8582e5),
        title: const Text(
          'Manage question',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: const Icon(Icons.login_outlined),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => ManageQuizWidget(
                      isEdit: false,
                      quizController: quizController,
                    ),
                  );
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
      body: StreamBuilder(
        stream: quizController.list,
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData || snapshot.hasError) {
            return Center(
              child: Text('error: snapshot ${snapshot.error}'),
            );
          } else {
            final List<QueryDocumentSnapshot<Object?>> quizzes =
                snapshot.data!.docs;
            return ListView.builder(
              itemCount: quizzes.length,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemBuilder: (context, index) {
                Question quiz = Question.fromJson(quizzes[index]);
                return QuestionTestWidget(
                  quiz: quiz,
                  isSelected: true,
                  quizController: quizController,
                );
              },
            );
          }
        },
      ),
    );
  }
}