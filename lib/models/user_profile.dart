import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String id;
  final String displayName;
  final String email;
  final String photoUrl;
  final String patronSaint; // avatar/patron saint name
  final int totalScore;
  final int totalGames;
  final int totalCorrect;
  final int totalQuestions;
  final int streak;
  final int bestStreak;
  final List<String> badges;
  final DateTime createdAt;
  final DateTime lastPlayedAt;

  const UserProfile({
    required this.id,
    required this.displayName,
    required this.email,
    this.photoUrl = '',
    this.patronSaint = '',
    this.totalScore = 0,
    this.totalGames = 0,
    this.totalCorrect = 0,
    this.totalQuestions = 0,
    this.streak = 0,
    this.bestStreak = 0,
    this.badges = const [],
    required this.createdAt,
    required this.lastPlayedAt,
  });

  /// Computed accuracy percentage (0.0 to 1.0)
  double get accuracy =>
      totalQuestions > 0 ? totalCorrect / totalQuestions : 0.0;

  /// Accuracy as a percentage string (e.g. "85.0%")
  String get accuracyFormatted =>
      '${(accuracy * 100).toStringAsFixed(1)}%';

  factory UserProfile.fromMap(Map<String, dynamic> map, {String? id}) {
    return UserProfile(
      id: id ?? map['id'] as String? ?? '',
      displayName: map['displayName'] as String? ?? '',
      email: map['email'] as String? ?? '',
      photoUrl: map['photoUrl'] as String? ?? '',
      patronSaint: map['patronSaint'] as String? ?? '',
      totalScore: map['totalScore'] as int? ?? 0,
      totalGames: map['totalGames'] as int? ?? 0,
      totalCorrect: map['totalCorrect'] as int? ?? 0,
      totalQuestions: map['totalQuestions'] as int? ?? 0,
      streak: map['streak'] as int? ?? 0,
      bestStreak: map['bestStreak'] as int? ?? 0,
      badges: List<String>.from(map['badges'] as List? ?? []),
      createdAt: map['createdAt'] is Timestamp
          ? (map['createdAt'] as Timestamp).toDate()
          : DateTime.tryParse(map['createdAt']?.toString() ?? '') ??
              DateTime.now(),
      lastPlayedAt: map['lastPlayedAt'] is Timestamp
          ? (map['lastPlayedAt'] as Timestamp).toDate()
          : DateTime.tryParse(map['lastPlayedAt']?.toString() ?? '') ??
              DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
      'patronSaint': patronSaint,
      'totalScore': totalScore,
      'totalGames': totalGames,
      'totalCorrect': totalCorrect,
      'totalQuestions': totalQuestions,
      'streak': streak,
      'bestStreak': bestStreak,
      'badges': badges,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastPlayedAt': Timestamp.fromDate(lastPlayedAt),
    };
  }

  UserProfile copyWith({
    String? id,
    String? displayName,
    String? email,
    String? photoUrl,
    String? patronSaint,
    int? totalScore,
    int? totalGames,
    int? totalCorrect,
    int? totalQuestions,
    int? streak,
    int? bestStreak,
    List<String>? badges,
    DateTime? createdAt,
    DateTime? lastPlayedAt,
  }) {
    return UserProfile(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      patronSaint: patronSaint ?? this.patronSaint,
      totalScore: totalScore ?? this.totalScore,
      totalGames: totalGames ?? this.totalGames,
      totalCorrect: totalCorrect ?? this.totalCorrect,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      streak: streak ?? this.streak,
      bestStreak: bestStreak ?? this.bestStreak,
      badges: badges ?? this.badges,
      createdAt: createdAt ?? this.createdAt,
      lastPlayedAt: lastPlayedAt ?? this.lastPlayedAt,
    );
  }

  @override
  String toString() =>
      'UserProfile(id: $id, displayName: $displayName, score: $totalScore)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is UserProfile && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
