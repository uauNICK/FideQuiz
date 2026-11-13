import 'package:cloud_firestore/cloud_firestore.dart';

class QuizResult {
  final String id;
  final String userId;
  final int score;
  final int correctAnswers;
  final int totalQuestions;
  final String category;
  final String difficulty;
  final int timeTaken; // in seconds
  final DateTime completedAt;

  const QuizResult({
    required this.id,
    required this.userId,
    required this.score,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.category,
    required this.difficulty,
    required this.timeTaken,
    required this.completedAt,
  });

  factory QuizResult.fromMap(Map<String, dynamic> map, {String? id}) {
    return QuizResult(
      id: id ?? map['id'] as String? ?? '',
      userId: map['userId'] as String? ?? '',
      score: map['score'] as int? ?? 0,
      correctAnswers: map['correctAnswers'] as int? ?? 0,
      totalQuestions: map['totalQuestions'] as int? ?? 0,
      category: map['category'] as String? ?? '',
      difficulty: map['difficulty'] as String? ?? 'easy',
      timeTaken: map['timeTaken'] as int? ?? 0,
      completedAt: map['completedAt'] is Timestamp
          ? (map['completedAt'] as Timestamp).toDate()
          : DateTime.tryParse(map['completedAt']?.toString() ?? '') ??
              DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'score': score,
      'correctAnswers': correctAnswers,
      'totalQuestions': totalQuestions,
      'category': category,
      'difficulty': difficulty,
      'timeTaken': timeTaken,
      'completedAt': Timestamp.fromDate(completedAt),
    };
  }

  double get accuracy =>
      totalQuestions > 0 ? correctAnswers / totalQuestions : 0.0;

  @override
  String toString() =>
      'QuizResult(id: $id, score: $score, correct: $correctAnswers/$totalQuestions)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is QuizResult && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
