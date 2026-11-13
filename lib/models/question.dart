import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  final String id;
  final String text;
  final List<String> options;
  final int correctIndex;
  final String category;
  final String difficulty;
  final String explanation;
  final String reference;
  final String figureName;
  final String figureImageUrl;
  final String figureCuriosity;
  final DateTime createdAt;

  const Question({
    required this.id,
    required this.text,
    required this.options,
    required this.correctIndex,
    required this.category,
    required this.difficulty,
    required this.explanation,
    required this.reference,
    this.figureName = '',
    this.figureImageUrl = '',
    this.figureCuriosity = '',
    required this.createdAt,
  });

  factory Question.fromMap(Map<String, dynamic> map, {String? id}) {
    return Question(
      id: id ?? map['id'] as String? ?? '',
      text: map['text'] as String? ?? '',
      options: List<String>.from(map['options'] as List? ?? []),
      correctIndex: map['correctIndex'] as int? ?? 0,
      category: map['category'] as String? ?? '',
      difficulty: map['difficulty'] as String? ?? 'Fácil',
      explanation: map['explanation'] as String? ?? '',
      reference: map['reference'] as String? ?? '',
      figureName: map['figureName'] as String? ?? '',
      figureImageUrl: map['figureImageUrl'] as String? ?? '',
      figureCuriosity: map['figureCuriosity'] as String? ?? '',
      createdAt: map['createdAt'] is Timestamp
          ? (map['createdAt'] as Timestamp).toDate()
          : DateTime.tryParse(map['createdAt']?.toString() ?? '') ??
              DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'options': options,
      'correctIndex': correctIndex,
      'category': category,
      'difficulty': difficulty,
      'explanation': explanation,
      'reference': reference,
      'figureName': figureName,
      'figureImageUrl': figureImageUrl,
      'figureCuriosity': figureCuriosity,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  Question copyWith({
    String? id,
    String? text,
    List<String>? options,
    int? correctIndex,
    String? category,
    String? difficulty,
    String? explanation,
    String? reference,
    String? figureName,
    String? figureImageUrl,
    String? figureCuriosity,
    DateTime? createdAt,
  }) {
    return Question(
      id: id ?? this.id,
      text: text ?? this.text,
      options: options ?? this.options,
      correctIndex: correctIndex ?? this.correctIndex,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
      explanation: explanation ?? this.explanation,
      reference: reference ?? this.reference,
      figureName: figureName ?? this.figureName,
      figureImageUrl: figureImageUrl ?? this.figureImageUrl,
      figureCuriosity: figureCuriosity ?? this.figureCuriosity,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() =>
      'Question(id: $id, text: $text, figure: $figureName, category: $category)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Question && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
