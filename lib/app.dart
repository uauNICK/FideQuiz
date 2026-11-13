import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fidequiz/config/theme.dart';
import 'package:fidequiz/config/routes.dart';
import 'package:fidequiz/providers/auth_provider.dart';
import 'package:fidequiz/providers/quiz_provider.dart';
import 'package:fidequiz/providers/leaderboard_provider.dart';

class FideQuizApp extends StatelessWidget {
  const FideQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => QuizProvider()),
        ChangeNotifierProvider(create: (_) => LeaderboardProvider()),
      ],
      child: MaterialApp(
        title: 'FideQuiz - Quiz Católico',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light, // Padrão dourado e azul mariano elegante
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
