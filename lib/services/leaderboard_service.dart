import 'package:fidequiz/models/leaderboard_entry.dart';
import 'package:fidequiz/services/firestore_service.dart';

class LeaderboardService {
  final FirestoreService _firestoreService = FirestoreService();

  // Tipos: 'daily', 'weekly', 'monthly', 'alltime'
  Future<List<LeaderboardEntry>> fetchLeaderboard(String type) async {
    return await _firestoreService.getLeaderboard(type: type);
  }

  // Gera dados mock de ranking caso o Firestore ainda esteja vazio ou em teste local
  List<LeaderboardEntry> getMockLeaderboard() {
    return [
      LeaderboardEntry(
        userId: 'mock_1',
        displayName: 'Irmão Bernardo',
        photoUrl: '',
        score: 1450,
        gamesPlayed: 25,
        updatedAt: DateTime.now(),
      ),
      LeaderboardEntry(
        userId: 'mock_2',
        displayName: 'Maria Teresa de Jesus',
        photoUrl: '',
        score: 1280,
        gamesPlayed: 19,
        updatedAt: DateTime.now(),
      ),
      LeaderboardEntry(
        userId: 'mock_3',
        displayName: 'Guilherme da Silva',
        photoUrl: '',
        score: 1120,
        gamesPlayed: 16,
        updatedAt: DateTime.now(),
      ),
      LeaderboardEntry(
        userId: 'mock_4',
        displayName: 'Clara de Assis',
        photoUrl: '',
        score: 950,
        gamesPlayed: 14,
        updatedAt: DateTime.now(),
      ),
      LeaderboardEntry(
        userId: 'mock_5',
        displayName: 'Lucas Evangelista',
        photoUrl: '',
        score: 840,
        gamesPlayed: 11,
        updatedAt: DateTime.now(),
      ),
    ];
  }
}
