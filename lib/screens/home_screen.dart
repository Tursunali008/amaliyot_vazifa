import 'package:amaliyot_vazifa/controllers/quiz_controller.dart';
import 'package:amaliyot_vazifa/model/quiz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late int count = 0;
  int sumCounter = 0;
  bool isTapped = false;
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    final quizController = context.watch<QuizController>();
    return Scaffold(
      backgroundColor: const Color(0xff8582e5),
      body: StreamBuilder(
        stream: quizController.list,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("Mahsulotlar mavjud emas"),
            );
          }
          final quizes = snapshot.data!.docs;

          return Column(
            children: [
              SafeArea(
                child: Image.asset(
                  "assets/images/reflectly.gif",
                  width: 70,
                  height: 70,
                ),
              ),
              Expanded(
                child: PageView.builder(
                    itemCount: quizes.length,
                    scrollDirection: Axis.vertical,
                    controller: controller,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final quizInfo = Question.fromJson(quizes[index]);
                      return Column(
                        children: [
                          const SizedBox(height: 50),
                          const Text(
                            "SAVOL",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 50),
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: Text(
                              quizInfo.questionText,
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 50),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ZoomTapAnimation(
                                onTap: () {
                                  if (quizInfo.correctAnswerIndex == 0) {
                                    count++;
                                  }
                                  isTapped = true;
                                  controller.nextPage(
                                    duration: const Duration(milliseconds: 800),
                                    curve: Curves.linear,
                                  );
                                },
                                child: Text(
                                  "A) ${quizInfo.options[0]}",
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              ZoomTapAnimation(
                                onTap: () {
                                  if (quizInfo.correctAnswerIndex == 1) {
                                    count++;
                                  }
                                  isTapped = true;
                                  controller.nextPage(
                                    duration: const Duration(milliseconds: 800),
                                    curve: Curves.linear,
                                  );
                                },
                                child: Text(
                                  "B) ${quizInfo.options[1]}",
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              ZoomTapAnimation(
                                onTap: () {
                                  if (quizInfo.correctAnswerIndex == 2) {
                                    count++;
                                  }
                                  isTapped = true;
                                  controller.nextPage(
                                    duration: const Duration(milliseconds: 800),
                                    curve: Curves.linear,
                                  );
                                },
                                child: Text(
                                  "C) ${quizInfo.options[2]}",
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ],
                      );
                    }),
              ),
            ],
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 70),
            child: ZoomTapAnimation(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: const Color.fromARGB(172, 15, 23, 64),
                      title: Text(
                        "Siz $count ta savolni javobini topdingiz",
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                width: 220,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(105, 37, 67, 126),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    "Stop",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  if (!isTapped) {
                    controller.previousPage(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.linear,
                    );
                  }
                },
                icon: const Icon(
                  Icons.arrow_upward_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(height: 20),
              IconButton(
                onPressed: () {
                  controller.nextPage(
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.linear,
                  );
                },
                icon: const Icon(
                  Icons.arrow_downward_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}