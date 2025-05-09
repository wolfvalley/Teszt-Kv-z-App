import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tesz_kviz_app/models/models.dart';
import 'package:tesz_kviz_app/services/firestore.dart';
import '../models/question.dart';
import '../widgets/question_card.dart';
import 'result_screen.dart';
import 'package:flutter/services.dart' show rootBundle;

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  List<Question> _questions = [];
  int _current = 0;
  int _score = 0;
  int? _selectedIndex;
  int? _correctIndex;
  Timer? _timer;
  int _timeLeft = 30;
  final List<int?> _selectedAnswers = [];
  late AnimationController _controller;
  List<SubjectAndGrade> _subjects = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _handleTimeout();
        }
      });
    _controller.forward();
  }

  void _loadQuestions() async {
    final data = await rootBundle.loadString('lib/data/questions.json');
    final subjects = await FirestoreService().getSubjectAndGrade();
    final List<dynamic> jsonList = json.decode(data);
    setState(() {
      _subjects = subjects;
      _questions = _subjects[0].chapters[0].questions;
      _startTimer();
      _isLoading = false;
    });
  }

  void _startTimer() {
    _timer?.cancel();
    _timeLeft = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft <= 0) {
        _handleTimeout();
      } else {
        setState(() {
          _timeLeft--;
        });
      }
    });
  }

  void _handleTimeout() {
    _timer?.cancel();
    _showCorrect(null);
  }

  void _onAnswerSelected(int index) {
    _timer?.cancel();
    _controller.stop();
    setState(() {
      _selectedIndex = index;
    });
    Future.delayed(const Duration(seconds: 2), () {
      _showCorrect(index);
    });
  }

  void _showCorrect(int? selected) {
    setState(() {
      _correctIndex = _questions[_current].correct_index;
      if (selected == _correctIndex) _score++;
      _selectedAnswers.add(selected);
    });
    Future.delayed(const Duration(seconds: 3), _nextQuestion);
  }

  void _nextQuestion() {
    setState(() {
      _current++;
      _selectedIndex = null;
      _correctIndex = null;
    });
    if (_current < _questions.length) {
      _startTimer();
      _controller.reset();
      _controller.forward();
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(
              score: _score, questions: _questions, answers: _selectedAnswers),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_current >= _questions.length) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 100, 34, 184),
      ),
      backgroundColor: const Color.fromARGB(255, 100, 34, 184),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  double progress = 1.0 - _controller.value;
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()..scale(-1.0, 1.0),
                          child: CircularProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.grey,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.white),
                          ),
                        ),
                      ),
                      Text("$_timeLeft",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  );
                }),
            const SizedBox(height: 10),
            QuestionCard(
              question: _questions[_current],
              selectedIndex: _selectedIndex,
              correctIndex: _correctIndex,
              onSelect: _onAnswerSelected,
            ),
          ],
        ),
      ),
    );
  }
}
