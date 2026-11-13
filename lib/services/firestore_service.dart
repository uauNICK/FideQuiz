import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:fidequiz/models/user_profile.dart';
import 'package:fidequiz/models/quiz_result.dart';
import 'package:fidequiz/models/leaderboard_entry.dart';
import 'package:fidequiz/config/constants.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ─── Usuários ──────────────────────────────────────
  Future<void> saveUserProfile(UserProfile profile) async {
    try {
      await _firestore
          .collection(AppConstants.usersCollection)
          .doc(profile.id)
          .set(profile.toMap(), SetOptions(merge: true));
    } catch (e) {
      debugPrint('Erro saveUserProfile: $e');
    }
  }

  Future<UserProfile?> getUserProfile(String userId) async {
    try {
      final doc = await _firestore
          .collection(AppConstants.usersCollection)
          .doc(userId)
          .get();
      if (doc.exists && doc.data() != null) {
        return UserProfile.fromMap(doc.data()!, id: doc.id);
      }
    } catch (e) {
      debugPrint('Erro getUserProfile: $e');
    }
    return null;
  }

  // ─── Salvar Resultado de Partida & Atualizar Estatísticas ─────────
  Future<void> saveQuizResult(QuizResult result, String? displayName, String? photoUrl) async {
    try {
      // 1. Salva o resultado
      await _firestore
          .collection(AppConstants.resultsCollection)
          .add(result.toMap());

      // 2. Se logado, atualiza o perfil do usuário
      if (result.userId.isNotEmpty && result.userId != 'anonymous') {
        final userRef = _firestore
            .collection(AppConstants.usersCollection)
            .doc(result.userId);

        await _firestore.runTransaction((transaction) async {
          final snapshot = await transaction.get(userRef);
          if (snapshot.exists) {
            final data = snapshot.data()!;
            final currentScore = data['totalScore'] as int? ?? 0;
            final currentGames = data['totalGames'] as int? ?? 0;
            final currentCorrect = data['totalCorrect'] as int? ?? 0;
            final currentQuestions = data['totalQuestions'] as int? ?? 0;

            transaction.update(userRef, {
              'totalScore': currentScore + result.score,
              'totalGames': currentGames + 1,
              'totalCorrect': currentCorrect + result.correctAnswers,
              'totalQuestions': currentQuestions + result.totalQuestions,
              'lastPlayedAt': FieldValue.serverTimestamp(),
            });
          }
        });

        // 3. Atualiza os rankings (Diário, Semanal, Mensal, Geral)
        await _updateLeaderboardScores(
          userId: result.userId,
          displayName: displayName ?? 'Fiel Anônimo',
          photoUrl: photoUrl ?? '',
          scoreToAdd: result.score,
        );
      }
    } catch (e) {
      debugPrint('Erro saveQuizResult: $e');
    }
  }

  // Atualiza entradas em diário, semanal, mensal e geral
  Future<void> _updateLeaderboardScores({
    required String userId,
    required String displayName,
    required String photoUrl,
    required int scoreToAdd,
  }) async {
    final now = DateTime.now();
    final dailyKey = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    final weeklyKey = '${now.year}-W${_getWeekOfYear(now)}';
    final monthlyKey = '${now.year}-${now.month.toString().padLeft(2, '0')}';

    final types = [
      {'path': 'daily_$dailyKey', 'type': 'daily'},
      {'path': 'weekly_$weeklyKey', 'type': 'weekly'},
      {'path': 'monthly_$monthlyKey', 'type': 'monthly'},
      {'path': 'alltime', 'type': 'alltime'},
    ];

    for (final t in types) {
      try {
        final docRef = _firestore
            .collection(AppConstants.leaderboardCollection)
            .doc(t['path'])
            .collection('entries')
            .doc(userId);

        await _firestore.runTransaction((transaction) async {
          final doc = await transaction.get(docRef);
          if (doc.exists) {
            final prevScore = doc.data()?['score'] as int? ?? 0;
            final prevGames = doc.data()?['gamesPlayed'] as int? ?? 0;
            transaction.update(docRef, {
              'score': prevScore + scoreToAdd,
              'gamesPlayed': prevGames + 1,
              'updatedAt': FieldValue.serverTimestamp(),
              'displayName': displayName,
              'photoUrl': photoUrl,
            });
          } else {
            transaction.set(docRef, {
              'userId': userId,
              'displayName': displayName,
              'photoUrl': photoUrl,
              'score': scoreToAdd,
              'gamesPlayed': 1,
              'updatedAt': FieldValue.serverTimestamp(),
            });
          }
        });
      } catch (e) {
        debugPrint('Erro ao atualizar leaderboard ${t['path']}: $e');
      }
    }
  }

  int _getWeekOfYear(DateTime date) {
    final startOfYear = DateTime(date.year, 1, 1);
    final diff = date.difference(startOfYear);
    return (diff.inDays / 7).floor() + 1;
  }

  // ─── Buscar Leaderboard ──────────────────────────────
  Future<List<LeaderboardEntry>> getLeaderboard({
    required String type, // 'daily', 'weekly', 'monthly', 'alltime'
    int limit = 50,
  }) async {
    try {
      final now = DateTime.now();
      String subPath = 'alltime';
      if (type == 'daily') {
        subPath = 'daily_${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
      } else if (type == 'weekly') {
        subPath = 'weekly_${now.year}-W${_getWeekOfYear(now)}';
      } else if (type == 'monthly') {
        subPath = 'monthly_${now.year}-${now.month.toString().padLeft(2, '0')}';
      }

      final snapshot = await _firestore
          .collection(AppConstants.leaderboardCollection)
          .doc(subPath)
          .collection('entries')
          .orderBy('score', descending: true)
          .limit(limit)
          .get();

      return snapshot.docs.map((doc) {
        return LeaderboardEntry.fromMap(doc.data(), userId: doc.id);
      }).toList();
    } catch (e) {
      debugPrint('Erro getLeaderboard: $e');
      return [];
    }
  }
}
