import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tesz_kviz_app/models/models.dart';
import 'package:tesz_kviz_app/screens/quiz_screen.dart';

class ClassSelector extends StatelessWidget {
  const ClassSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class SubjectSelector extends StatelessWidget {
  const SubjectSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ChapterSelector extends StatelessWidget {
  const ChapterSelector({super.key});

  Future<void> printQuizzesCollection() async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;

    try {
      final snapshot = await _db.collection('quizzes').get();

      for (var doc in snapshot.docs) {
        print('--- Dokumentum ID: ${doc.id} ---');
        final data = doc.data();
        print(data);
      }
    } catch (e) {
      print('❌ Hiba történt a Firestore olvasásakor: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 100, 34, 184),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/quiz");
            },
            child: Text("Indítsd a kvízt!")),
      ),
    );
  }
}
