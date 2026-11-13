import 'package:flutter/foundation.dart';
import 'package:fidequiz/models/leaderboard_entry.dart';
import 'package:fidequiz/services/leaderboard_service.dart';

class LeaderboardProvider extends ChangeNotifier {
  final LeaderboardService _leaderboardService = LeaderboardService();

  List<LeaderboardEntry> _entries = [];
  String _currentType = 'daily'; // 'daily', 'weekly', 'monthly', 'alltime'
  bool _isLoading = false;

  List<LeaderboardEntry> get entries => _entries;
  String get currentType => _currentType;
  bool get isLoading => _isLoading;

  LeaderboardProvider() {
    loadLeaderboard('daily');
  }

  Future<void> loadLeaderboard(String type) async {
    _currentType = type;
    _isLoading = true;
    notifyListeners();

    try {
      final results = await _leaderboardService.fetchLeaderboard(type);
      if (results.isNotEmpty) {
        _entries = results;
      } else {
        // Usa mock amigável enquanto não há jogadores suficientes no banco
        _entries = _leaderboardService.getMockLeaderboard();
      }
    } catch (e) {
      debugPrint('Erro ao carregar leaderboard: $e');
      _entries = _leaderboardService.getMockLeaderboard();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> refresh() async {
    await loadLeaderboard(_currentType);
  }
}
