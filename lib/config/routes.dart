import 'package:flutter/material.dart';

import 'package:fidequiz/screens/splash_screen.dart';
import 'package:fidequiz/screens/home_screen.dart';
import 'package:fidequiz/screens/login_screen.dart';
import 'package:fidequiz/screens/category_screen.dart';
import 'package:fidequiz/screens/quiz_screen.dart';
import 'package:fidequiz/screens/result_screen.dart';
import 'package:fidequiz/screens/leaderboard_screen.dart';
import 'package:fidequiz/screens/profile_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String categories = '/categories';
  static const String quiz = '/quiz';
  static const String result = '/result';
  static const String leaderboard = '/leaderboard';
  static const String profile = '/profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _buildRoute(const SplashScreen(), settings);
      case home:
        return _buildRoute(const HomeScreen(), settings);
      case login:
        return _buildRoute(const LoginScreen(), settings);
      case categories:
        return _buildRoute(const CategoryScreen(), settings);
      case quiz:
        return _buildRoute(const QuizScreen(), settings);
      case result:
        return _buildRoute(const ResultScreen(), settings);
      case leaderboard:
        return _buildRoute(const LeaderboardScreen(), settings);
      case profile:
        return _buildRoute(const ProfileScreen(), settings);
      default:
        return _buildRoute(
          Scaffold(
            body: Center(
              child: Text('Rota não encontrada: ${settings.name}'),
            ),
          ),
          settings,
        );
    }
  }

  static MaterialPageRoute<dynamic> _buildRoute(
    Widget page,
    RouteSettings settings,
  ) {
    return MaterialPageRoute(
      builder: (_) => page,
      settings: settings,
    );
  }
}
