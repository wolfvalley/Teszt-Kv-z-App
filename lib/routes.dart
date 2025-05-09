import 'package:flutter/material.dart';
import 'package:tesz_kviz_app/screens/home.dart';
import 'package:tesz_kviz_app/screens/login.dart';
import 'package:tesz_kviz_app/screens/quiz_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const Home(),
  '/login': (context) => Login(),
  '/quiz': (context) => const QuizScreen(),
};
