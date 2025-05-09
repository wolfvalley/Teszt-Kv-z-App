import 'package:flutter/material.dart';
import 'package:tesz_kviz_app/quiz/subjects.dart';
import 'package:tesz_kviz_app/screens/login.dart';
import 'package:tesz_kviz_app/screens/quiz_screen.dart';
import 'package:tesz_kviz_app/services/auth.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error"),
          );
        } else if (snapshot.hasData) {
          return ChapterSelector();
        } else {
          return Login();
        }
      },
    );
  }
}
