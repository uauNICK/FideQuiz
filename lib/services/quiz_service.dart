import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:fidequiz/models/question.dart';
import 'package:fidequiz/config/constants.dart';

class QuizService {
  List<Question> _allQuestionsCache = [];

  // Carrega todas as perguntas do arquivo JSON local ou cache
  Future<List<Question>> loadAllQuestions() async {
    if (_allQuestionsCache.isNotEmpty) {
      return _allQuestionsCache;
    }

    try {
      final jsonString =
          await rootBundle.loadString('assets/data/questions.json');
      final List<dynamic> jsonList = json.decode(jsonString);

      _allQuestionsCache = jsonList.map((item) {
        return Question.fromMap(Map<String, dynamic>.from(item));
      }).toList();

      return _allQuestionsCache;
    } catch (e) {
      debugPrint('Aviso ao carregar questions.json: $e. Usando perguntas padrão.');
      _allQuestionsCache = _getFallbackQuestions();
      return _allQuestionsCache;
    }
  }

  // Gera uma partida com perguntas filtradas por tema e dificuldade
  Future<List<Question>> getQuizQuestions({
    String? categoryId,
    String? difficulty,
    int count = AppConstants.questionsPerGame,
  }) async {
    final all = await loadAllQuestions();

    List<Question> filtered = List.from(all);

    // Filtra por categoria caso especificado (e não seja 'todos')
    if (categoryId != null &&
        categoryId.isNotEmpty &&
        categoryId != 'todas' &&
        categoryId != 'all') {
      filtered = filtered
          .where((q) =>
              q.category.toLowerCase() == categoryId.toLowerCase())
          .toList();
    }

    // Filtra por dificuldade caso especificado (e não seja 'todos')
    if (difficulty != null &&
        difficulty.isNotEmpty &&
        difficulty != 'Todas' &&
        difficulty != 'all') {
      final diffFiltered = filtered
          .where((q) =>
              q.difficulty.toLowerCase() == difficulty.toLowerCase())
          .toList();
      if (diffFiltered.isNotEmpty) {
        filtered = diffFiltered;
      }
    }

    // Embaralha as perguntas
    filtered.shuffle();

    // Se houver menos que o pedido, usa o que tem ou complementa com outras
    if (filtered.length > count) {
      filtered = filtered.sublist(0, count);
    }

    return filtered;
  }

  // Calcula pontuação considerando acertos, tempo restante e dificuldade
  int calculateQuestionScore({
    required bool isCorrect,
    required int secondsRemaining,
    required String difficulty,
  }) {
    if (!isCorrect) return 0;

    int basePoints = AppConstants.difficultyPoints[difficulty] ?? 10;
    // Bônus de agilidade: 1 ponto por cada 2 segundos restantes
    int timeBonus = (secondsRemaining / 2).ceil();

    return basePoints + timeBonus;
  }

  // Perguntas de contingência de altíssima qualidade caso o arquivo JSON ainda não esteja montado
  List<Question> _getFallbackQuestions() {
    return [
      Question(
        id: 'q_santos_01',
        text: 'Qual santo é conhecido mundialmente como o "Padroeiro dos Animais e da Natureza" e autor do Cântico das Criaturas?',
        options: [
          'São Bento de Núrsia',
          'São Francisco de Assis',
          'Santo Agostinho',
          'São João da Cruz'
        ],
        correctIndex: 1,
        category: 'santos',
        difficulty: 'Fácil',
        explanation: 'São Francisco de Assis despojou-se de todas as riquezas para viver o Evangelho e via em toda a criação de Deus a fraternidade universal.',
        reference: 'Tradição Franciscana / Biografia de Celano',
        figureName: 'São Francisco de Assis',
        figureImageUrl: 'https://images.unsplash.com/photo-1544717305-2782549b5136?w=600',
        figureCuriosity: 'São Francisco criou o primeiro Presépio da história no Natal de 1223, na cidade de Greccio, Itália, usando animais vivos para meditar sobre a humildade do nascimento de Jesus.',
        createdAt: DateTime.now(),
      ),
      Question(
        id: 'q_anjos_01',
        text: 'Qual Arcanjo bradou nos céus: "Quem como Deus?" ao derrotar o dragão e os anjos rebeldes?',
        options: [
          'Arcanjo Gabriel',
          'Arcanjo Rafael',
          'Arcanjo Miguel',
          'Arcanjo Uriel'
        ],
        correctIndex: 2,
        category: 'anjos',
        difficulty: 'Fácil',
        explanation: 'O nome Miguel vem do hebraico "Mikha\'el", que significa literalmente "Quem como Deus?".',
        reference: 'Apocalipse 12, 7-9',
        figureName: 'São Miguel Arcanjo',
        figureImageUrl: 'https://images.unsplash.com/photo-1579783900882-c0d3dad7b119?w=600',
        figureCuriosity: 'São Miguel Arcanjo apareceu no Monte Gargano, Itália, no século V, consagrando pessoalmente a gruta. É o único santuário católico que não foi consagrado por mãos humanas.',
        createdAt: DateTime.now(),
      ),
      Question(
        id: 'q_figuras_01',
        text: 'Qual Papa canonizado governou a Igreja de 1978 a 2005 e sobreviveu a um atentado em 13 de maio de 1981, atribuindo sua salvação a Nossa Senhora de Fátima?',
        options: [
          'São Paulo VI',
          'São João Paulo II',
          'São João XXIII',
          'Pio XII'
        ],
        correctIndex: 1,
        category: 'figuras',
        difficulty: 'Fácil',
        explanation: 'Karol Wojtyła, São João Paulo II, foi um dos pontífices mais influentes da história moderna, viajando por 129 países.',
        reference: 'Magistério Pontifício / Vida de João Paulo II',
        figureName: 'São João Paulo II',
        figureImageUrl: 'https://images.unsplash.com/photo-1548625361-195982846430?w=600',
        figureCuriosity: 'A bala que atingiu São João Paulo II na Praça de São Pedro foi colocada na coroa da imagem original de Nossa Senhora de Fátima, em Portugal, onde permanece até hoje!',
        createdAt: DateTime.now(),
      ),
      Question(
        id: 'q_catequese_01',
        text: 'Quantos e quais são os Sacramentos instituídos por Nosso Senhor Jesus Cristo na Igreja Católica?',
        options: [
          '3 sacramentos (Batismo, Eucaristia e Crisma)',
          '7 sacramentos (Batismo, Crisma, Eucaristia, Reconciliação, Unção dos Enfermos, Ordem e Matrimônio)',
          '10 sacramentos baseados nos Mandamentos',
          '5 sacramentos da Nova Aliança'
        ],
        correctIndex: 1,
        category: 'catequese',
        difficulty: 'Fácil',
        explanation: 'O Catecismo da Igreja Católica ensina que há sete sacramentos, divididos em: Iniciação Cristã, Cura e Serviço da Comunhão.',
        reference: 'CIC §1210-1211',
        figureName: 'Os Sete Sacramentos da Igreja',
        figureImageUrl: 'https://images.unsplash.com/photo-1543807535-eceef0bc6599?w=600',
        figureCuriosity: 'A Eucaristia é chamada pelo Concílio Vaticano II de "fonte e ápice de toda a vida cristã", pois nela está contida a totalidade do próprio Cristo.',
        createdAt: DateTime.now(),
      ),
      Question(
        id: 'q_biblia_01',
        text: 'No Evangelho de São Lucas, qual Arcanjo foi enviado por Deus à cidade de Nazaré para anunciar a Maria que ela seria a Mãe do Salvador?',
        options: [
          'São Rafael',
          'São Gabriel',
          'São Miguel',
          'São Melquisedec'
        ],
        correctIndex: 1,
        category: 'biblia',
        difficulty: 'Fácil',
        explanation: 'O Arcanjo Gabriel saudou Nossa Senhora com as palavras sagradas: "Alegra-te, cheia de graça, o Senhor está contigo!".',
        reference: 'Lucas 1, 26-28',
        figureName: 'São Gabriel Arcanjo & A Anunciação',
        figureImageUrl: 'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=600',
        figureCuriosity: 'Gabriel é o embaixador divino das grandes mensagens. Além de Maria, ele apareceu ao profeta Daniel e a Zacarias no Templo para anunciar o nascimento de João Batista.',
        createdAt: DateTime.now(),
      ),
    ];
  }
}
