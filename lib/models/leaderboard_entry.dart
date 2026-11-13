import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardEntry {
  final String userId;
  final String displayName;
  final String photoUrl;
  final int score;
  final int gamesPlayed;
  final DateTime updatedAt;

  const LeaderboardEntry({
    required this.userId,
    required this.displayName,
    this.photoUrl = '',
    required this.score,
    required this.gamesPlayed,
    required this.updatedAt,
  });

  factory LeaderboardEntry.fromMap(Map<String, dynamic> map, {String? id}) {
    return LeaderboardEntry(
      userId: id ?? map['userId'] as String? ?? '',
      displayName: map['displayName'] as String? ?? '',
      photoUrl: map['photoUrl'] as String? ?? '',
      score: map['score'] as int? ?? 0,
      gamesPlayed: map['gamesPlayed'] as int? ?? 0,
      updatedAt: map['updatedAt'] is Timestamp
          ? (map['updatedAt'] as Timestamp).toDate()
          : DateTime.tryParse(map['updatedAt']?.toString() ?? '') ??
              DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'score': score,
      'gamesPlayed': gamesPlayed,
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  @override
  String toString() =>
      'LeaderboardEntry(userId: $userId, displayName: $displayName, score: $score)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeaderboardEntry && userId == other.userId;

  @override
  int get hashCode => userId.hashCode;
}
