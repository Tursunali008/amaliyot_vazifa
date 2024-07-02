import 'package:amaliyot_vazifa/controllers/quiz_controller.dart';
import 'package:amaliyot_vazifa/model/quiz.dart';
import 'package:amaliyot_vazifa/utils/app_const.dart';
import 'package:amaliyot_vazifa/widgets/leaders_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuestionTestWidget extends StatefulWidget {
  final Question quiz;
  final bool isSelected;
  final QuizController? quizController;

  const QuestionTestWidget({
    super.key,
    required this.quiz,
    required this.isSelected,
    this.quizController,
  });

  @override
  State<QuestionTestWidget> createState() => _QuestionTestWidgetState();
}

class _QuestionTestWidgetState extends State<QuestionTestWidget> {
  int _chosenAnswer = -1;
  bool _isTapped = false;

  void _changeAnswer(int index) {
    _chosenAnswer = index;
    setState(() {});
  }

  void onEditPressed() {
    showDialog(
      context: context,
      builder: (context) => ManageQuizWidget(
        isEdit: true,
        quizController: widget.quizController!,
        question: widget.quiz,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    QuizController quizController = Provider.of<QuizController>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isSelected)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 220,
                child: Text(
                  widget.quiz.questionText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: onEditPressed,
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      quizController.deleteQuiz(widget.quiz.id);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              )
            ],
          )
        else
          Text(
            widget.quiz.questionText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.w600,
            ),
          ),
        for (int i = 0; i < widget.quiz.options.length; i++)
          GestureDetector(
            onTap: widget.isSelected
                ? null
                : () {
                    if (!_isTapped) {
                      _isTapped = true;
                      _changeAnswer(i);
                      AppConstants.correctAnswer++;
                    }
                  },
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: Row(
                children: [
                  Icon(
                    _chosenAnswer == i ? Icons.check_circle : Icons.circle,
                    color: _chosenAnswer == i
                        ? Theme.of(context).colorScheme.primary
                        : Colors.white,
                  ),
                  const SizedBox(width: 15),
                  Text(
                    widget.quiz.options[i],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          )
      ],
    );
  }
}