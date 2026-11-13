import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:fidequiz/models/question.dart';
import 'package:fidequiz/models/quiz_result.dart';
import 'package:fidequiz/services/quiz_service.dart';
import 'package:fidequiz/services/firestore_service.dart';
import 'package:fidequiz/services/ad_service.dart';
import 'package:fidequiz/config/constants.dart';

class QuizProvider extends ChangeNotifier {
  final QuizService _quizService = QuizService();
  final FirestoreService _firestoreService = FirestoreService();
  final AdService _adService = AdService();

  List<Question> _questions = [];
  int _currentIndex = 0;
  int _score = 0;
  int _correctAnswers = 0;
  int? _selectedAnswerIndex;
  bool _isAnswered = false;
  bool _isLoading = false;
  bool _isFinished = false;

  // Timer
  Timer? _timer;
  int _secondsRemaining = AppConstants.timerDurationSeconds;

  // Configuração da partida atual
  String _selectedCategory = 'todas';
  String _selectedDifficulty = AppConstants.difficultyEasy;
  DateTime? _gameStartTime;
  int _totalTimeSeconds = 0;

  // Getters
  List<Question> get questions => _questions;
  int get currentIndex => _currentIndex;
  int get score => _score;
  int get correctAnswers => _correctAnswers;
  int? get selectedAnswerIndex => _selectedAnswerIndex;
  bool get isAnswered => _isAnswered;
  bool get isLoading => _isLoading;
  bool get isFinished => _isFinished;
  int get secondsRemaining => _secondsRemaining;
  String get selectedCategory => _selectedCategory;
  String get selectedDifficulty => _selectedDifficulty;
  int get totalTimeSeconds => _totalTimeSeconds;

  Question? get currentQuestion =>
      _questions.isNotEmpty && _currentIndex < _questions.length
          ? _questions[_currentIndex]
          : null;

  bool get isCurrentAnswerCorrect =>
      currentQuestion != null &&
      _selectedAnswerIndex != null &&
      _selectedAnswerIndex == currentQuestion!.correctIndex;

  // Inicia uma nova partida
  Future<void> startQuiz({
    String? categoryId,
    String? difficulty,
  }) async {
    _isLoading = true;
    _isFinished = false;
    _currentIndex = 0;
    _score = 0;
    _correctAnswers = 0;
    _selectedAnswerIndex = null;
    _isAnswered = false;
    _selectedCategory = categoryId ?? 'todas';
    _selectedDifficulty = difficulty ?? AppConstants.difficultyEasy;
    _gameStartTime = DateTime.now();
    notifyListeners();

    try {
      _questions = await _quizService.getQuizQuestions(
        categoryId: _selectedCategory,
        difficulty: _selectedDifficulty,
        count: AppConstants.questionsPerGame,
      );
    } catch (e) {
      debugPrint('Erro ao iniciar quiz: $e');
    }

    _isLoading = false;
    if (_questions.isNotEmpty) {
      _startTimer();
    } else {
      _isFinished = true;
    }
    notifyListeners();
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsRemaining = AppConstants.timerDurationSeconds;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
        notifyListeners();
      } else {
        _timer?.cancel();
        // Tempo esgotado conta como resposta incorreta
        answerQuestion(-1);
      }
    });
  }

  // Responde a pergunta atual
  void answerQuestion(int answerIndex) {
    if (_isAnswered || currentQuestion == null) return;

    _timer?.cancel();
    _isAnswered = true;
    _selectedAnswerIndex = answerIndex;

    final isCorrect = answerIndex == currentQuestion!.correctIndex;
    if (isCorrect) {
      _correctAnswers++;
      final earned = _quizService.calculateQuestionScore(
        isCorrect: true,
        secondsRemaining: _secondsRemaining,
        difficulty: currentQuestion!.difficulty,
      );
      _score += earned;
    }

    notifyListeners();
  }

  // Avança para a próxima pergunta ou finaliza o jogo
  void nextQuestion({
    required String userId,
    String? displayName,
    String? photoUrl,
  }) {
    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
      _isAnswered = false;
      _selectedAnswerIndex = null;
      _startTimer();
      notifyListeners();
    } else {
      _finishGame(
        userId: userId,
        displayName: displayName,
        photoUrl: photoUrl,
      );
    }
  }

  // Finaliza a partida, salva resultados e aciona o anúncio se necessário
  void _finishGame({
    required String userId,
    String? displayName,
    String? photoUrl,
  }) {
    _timer?.cancel();
    _isFinished = true;

    if (_gameStartTime != null) {
      _totalTimeSeconds =
          DateTime.now().difference(_gameStartTime!).inSeconds;
    }

    final result = QuizResult(
      id: const Uuid().v4(),
      userId: userId.isNotEmpty ? userId : 'anonymous',
      score: _score,
      correctAnswers: _correctAnswers,
      totalQuestions: _questions.length,
      category: _selectedCategory,
      difficulty: _selectedDifficulty,
      timeTaken: _totalTimeSeconds,
      completedAt: DateTime.now(),
    );

    // Salva no Firestore
    _firestoreService.saveQuizResult(result, displayName, photoUrl);

    // Notifica sistema de anúncios
    _adService.onGameCompleted();

    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
