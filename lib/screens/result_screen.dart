import 'package:flutter/material.dart';
import 'package:tesz_kviz_app/screens/quiz_screen.dart';
import '../models/question.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final List<Question> questions;
  final List<int?> answers;

  const ResultScreen({
    super.key,
    required this.score,
    required this.questions,
    required this.answers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Eredmény",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 100, 34, 184),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Pontszám: $score / ${questions.length}",
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, i) {
                  final q = questions[i];
                  return ListTile(
                    title: Text(q.question),
                    subtitle:
                        Text("Helyes válasz: ${q.answers[q.correctIndex]}"),
                    trailing: answers[i] == q.correctIndex
                        ? const Icon(Icons.check, color: Colors.green)
                        : const Icon(Icons.close, color: Colors.red),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const QuizScreen(),
                ),
              ),
              child: const Text("Új játék"),
            )
          ],
        ),
      ),
    );
  }
}
