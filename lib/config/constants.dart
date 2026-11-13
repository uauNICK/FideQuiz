class AppConstants {
  AppConstants._();

  // ─── Informações do App ────────────────────────────
  static const String appName = 'FideQuiz';
  static const String appTagline = 'O Quiz da Fé Católica';
  static const String appVersion = '1.0.0';

  // ─── Configurações do Quiz ──────────────────────────
  static const int timerDurationSeconds = 15;
  static const int questionsPerGame = 10;
  static const int adFrequencyGames = 3;

  // ─── Níveis de Dificuldade ──────────────────────────
  static const String difficultyEasy = 'Fácil';
  static const String difficultyMedium = 'Médio';
  static const String difficultyHard = 'Difícil';

  static const List<Map<String, dynamic>> difficultyLevels = [
    {
      'id': difficultyEasy,
      'title': 'Iniciante (Fácil)',
      'description': 'Conhecimentos fundamentais para todo fiel',
      'icon': '🌱',
      'points': 10,
    },
    {
      'id': difficultyMedium,
      'title': 'Devoto (Médio)',
      'description': 'Perguntas para aprofundar seu saber teológico',
      'icon': '🕯️',
      'points': 20,
    },
    {
      'id': difficultyHard,
      'title': 'Doutor da Fé (Difícil)',
      'description': 'Desafios bíblicos, patrísticos e dogmáticos',
      'icon': '📜',
      'points': 30,
    },
  ];

  static const Map<String, int> difficultyPoints = {
    difficultyEasy: 10,
    difficultyMedium: 20,
    difficultyHard: 30,
  };

  // ─── Categorias / Temas Escolhidos ──────────────────
  static const List<Map<String, String>> categories = [
    {
      'id': 'catequese',
      'name': 'Catequese Geral',
      'emoji': '📖',
      'description': 'Dogmas, Credo, Sacramentos e Doutrina Católica'
    },
    {
      'id': 'santos',
      'name': 'Santos e Santas',
      'emoji': '😇',
      'description': 'Vidas inspiradoras, milagres e padroeiros'
    },
    {
      'id': 'anjos',
      'name': 'Anjos e Arcanjos',
      'emoji': '👼',
      'description': 'Hierarquias celestes, missões e proteção divina'
    },
    {
      'id': 'figuras',
      'name': 'Vida de Figuras Católicas',
      'emoji': '👑',
      'description': 'Papas santos, Padres da Igreja, Mártires e Beatos'
    },
    {
      'id': 'biblia',
      'name': 'Bíblia Sagrada',
      'emoji': '📜',
      'description': 'Antigo e Novo Testamento, profecias e evangelhos'
    },
    {
      'id': 'liturgia',
      'name': 'Liturgia & Orações',
      'emoji': '⛪',
      'description': 'A Santa Missa, vestes, tempos litúrgicos e preces'
    },
    {
      'id': 'batalha_espiritual',
      'name': 'Batalha Espiritual',
      'emoji': '🛡️',
      'description': 'Doutrina católica sobre anjos caídos e proteção'
    },
    {
      'id': 'curiosidades',
      'name': 'Tradição e Curiosidades',
      'emoji': '✨',
      'description': 'História milenar, arte sacra e relíquias'
    },
  ];

  // ─── Coleções Firestore ─────────────────────────────
  static const String usersCollection = 'users';
  static const String questionsCollection = 'questions';
  static const String leaderboardCollection = 'leaderboards';
  static const String resultsCollection = 'quiz_results';

  // ─── IDs de Teste AdMob ─────────────────────────────
  static const String adMobBannerIdAndroid =
      'ca-app-pub-3940256099942544/6300978111';
  static const String adMobInterstitialIdAndroid =
      'ca-app-pub-3940256099942544/1033173712';
  static const String adMobRewardedIdAndroid =
      'ca-app-pub-3940256099942544/5224354917';

  static const String adMobBannerIdIos =
      'ca-app-pub-3940256099942544/2934735716';
  static const String adMobInterstitialIdIos =
      'ca-app-pub-3940256099942544/4411468910';
  static const String adMobRewardedIdIos =
      'ca-app-pub-3940256099942544/1712485313';

  // ─── Outras Constantes ──────────────────────────────
  static const int maxLeaderboardEntries = 50;
  static const int minPasswordLength = 6;
}
