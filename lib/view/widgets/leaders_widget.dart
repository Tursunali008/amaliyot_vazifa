import 'package:amaliyot_vazifa/controllers/quiz_controller.dart';
import 'package:amaliyot_vazifa/model/quiz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageQuizWidget extends StatefulWidget {
  final bool isEdit;
  final Question? question;
  final QuizController quizController;

  const ManageQuizWidget({
    super.key,
    required this.isEdit,
    this.question,
    required this.quizController,
  });

  @override
  State<ManageQuizWidget> createState() => _ManageQuizWidgetState();
}

class _ManageQuizWidgetState extends State<ManageQuizWidget> {
  final formKey = GlobalKey<FormState>();
  final questionController = TextEditingController();
  final answerAController = TextEditingController();
  final answerBController = TextEditingController();
  final answerCController = TextEditingController();
  final correctAnswerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.question != null) {
      questionController.text = widget.question!.questionText;
      answerAController.text = widget.question!.options[0];
      answerBController.text = widget.question!.options[1];
      answerCController.text = widget.question!.options[2];
      correctAnswerController.text =
          widget.question!.correctAnswerIndex.toString();
    }
  }

  @override
  void dispose() {
    questionController.dispose();
    answerAController.dispose();
    answerBController.dispose();
    answerCController.dispose();
    correctAnswerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    QuizController quizController = Provider.of<QuizController>(context);
    return SingleChildScrollView(
      child: AlertDialog(
        title: Text(widget.isEdit ? "Edit Question" : "Add Question"),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: questionController,
                decoration: const InputDecoration(
                  hintText: 'Enter question',
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Please, enter question";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: answerAController,
                decoration: const InputDecoration(
                  hintText: 'Enter answer A',
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Please, enter answer A";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: answerBController,
                decoration: const InputDecoration(
                  hintText: 'Enter answer B',
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Please, enter answer B";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: answerCController,
                decoration: const InputDecoration(
                  hintText: 'Enter answer C',
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Please, enter answer C";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: correctAnswerController,
                decoration: const InputDecoration(
                  hintText: 'Enter correct answer variant',
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Please, enter correct answer variant";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
          TextButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                if (widget.isEdit) {
                  await widget.quizController.editQuiz(
                    widget.question!.id,
                    questionController.text,
                    [
                      answerAController.text,
                      answerBController.text,
                      answerCController.text
                    ],
                    int.parse(correctAnswerController.text),
                  );
                } else {
                  await quizController.addQuiz(
                    questionController.text,
                    [
                      answerAController.text,
                      answerBController.text,
                      answerCController.text
                    ],
                    int.parse(correctAnswerController.text),
                  );
                }
                questionController.clear();
                answerAController.clear();
                answerBController.clear();
                answerCController.clear();
                correctAnswerController.clear();
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              }
            },
            child: Text(
              widget.isEdit ? "Edit" : "Add",
              style: const TextStyle(color: Colors.teal),
            ),
          ),
        ],
      ),
    );
  }
}