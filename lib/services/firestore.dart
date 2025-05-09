import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tesz_kviz_app/services/auth.dart';
import 'package:tesz_kviz_app/models/models.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<SubjectAndGrade>> getSubjectAndGrade() async {
    var ref = _db.collection("quizzes");
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var subjects = data.map((d) => SubjectAndGrade.fromJson(d));
    return subjects.toList();
  }
}
