import 'package:amaliyot_vazifa/controllers/quiz_controller.dart';
import 'package:amaliyot_vazifa/firebase_options.dart';
import 'package:amaliyot_vazifa/view/screens/home_screen.dart';
import 'package:amaliyot_vazifa/view/screens/leaders_screen.dart';
import 'package:amaliyot_vazifa/view/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return QuizController();
      },
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final data = snapshot.data;
              return data == null
                  ? const LoginScreen()
                  : PageView(
                      children: const [
                        QuizScreen(),
                        ManageQuestionScreen(),
                      ],
                    );
            },
          ),
        );
      },
    );
  }
}
