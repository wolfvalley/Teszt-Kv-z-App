import 'package:flutter/material.dart';
import 'package:tesz_kviz_app/models/models.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final int? selectedIndex;
  final int? correctIndex;
  final Function(int) onSelect;

  const QuestionCard({
    super.key,
    required this.question,
    required this.selectedIndex,
    required this.correctIndex,
    required this.onSelect,
  });

  Color? getButtonColor(int index) {
    if (selectedIndex == index && correctIndex == null) {
      return Colors.amber;
    }
    if (correctIndex != null) {
      if (index == correctIndex) return Colors.green;
      if (index == selectedIndex && selectedIndex != correctIndex) {
        return Colors.red;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question.question,
            style: const TextStyle(fontSize: 20, color: Colors.white)),
        const SizedBox(height: 20),
        for (int i = 0; i < question.answers.length; i++)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: ElevatedButton(
              onPressed: selectedIndex == null ? () => onSelect(i) : () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: getButtonColor(i) ?? Colors.white,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text(question.answers[i]),
            ),
          ),
      ],
    );
  }
}
