import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:fidequiz/config/theme.dart';
import 'package:fidequiz/config/routes.dart';
import 'package:fidequiz/providers/quiz_provider.dart';
import 'package:fidequiz/providers/auth_provider.dart';
import 'package:fidequiz/widgets/question_card.dart';
import 'package:fidequiz/widgets/answer_button.dart';
import 'package:fidequiz/widgets/timer_widget.dart';
import 'package:fidequiz/widgets/score_display.dart';
import 'package:fidequiz/widgets/figure_reward_dialog.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  bool _dialogShownForCurrentQuestion = false;

  @override
  Widget build(BuildContext context) {
    final quizProvider = context.watch<QuizProvider>();
    final authProvider = context.watch<AuthProvider>();

    // Redireciona para resultado quando finalizado
    if (quizProvider.isFinished) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.result);
      });
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final question = quizProvider.currentQuestion;
    if (question == null || quizProvider.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.dourado),
          ),
        ),
      );
    }

    // Se acertou e o dialog ainda não foi exibido, abre o FigureRewardDialog!
    if (quizProvider.isAnswered &&
        quizProvider.isCurrentAnswerCorrect &&
        !_dialogShownForCurrentQuestion) {
      _dialogShownForCurrentQuestion = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => FigureRewardDialog(
            question: question,
            onContinue: () {
              // Dialog fechado, usuário pode clicar em próxima ou avançamos
            },
          ),
        );
      });
    }

    return Scaffold(
      backgroundColor: AppColors.cinzaClaro,
      appBar: AppBar(
        backgroundColor: AppColors.azulMarianoDark,
        elevation: 0,
        title: Text(
          'FideQuiz',
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.bold,
            color: AppColors.dourado,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: AppColors.branco),
          onPressed: () => _showExitConfirmation(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Center(
              child: ScoreDisplay(score: quizProvider.score),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                child: Column(
                  children: [
                    // Top Bar de Progresso e Timer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Categoria / Dificuldade Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.branco,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Text(
                            'Pergunta ${quizProvider.currentIndex + 1} de ${quizProvider.questions.length}',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.azulMarianoDark,
                            ),
                          ),
                        ),
                        // Timer Circular
                        TimerWidget(
                          secondsRemaining: quizProvider.secondsRemaining,
                          totalSeconds: 15,
                          size: 54,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Card da Pergunta
                    QuestionCard(
                      questionText: question.text,
                      category: question.category,
                      difficulty: question.difficulty,
                      questionNumber: quizProvider.currentIndex + 1,
                      totalQuestions: quizProvider.questions.length,
                    ),
                    const SizedBox(height: 16),

                    // 4 Alternativas
                    ...List.generate(question.options.length, (idx) {
                      final isSelected =
                          quizProvider.selectedAnswerIndex == idx;
                      final isCorrect = idx == question.correctIndex;

                      return AnswerButton(
                        text: question.options[idx],
                        index: idx,
                        isSelected: isSelected,
                        isCorrect: isCorrect,
                        isAnswered: quizProvider.isAnswered,
                        onTap: () {
                          quizProvider.answerQuestion(idx);
                        },
                      );
                    }),

                    // Se errou, mostra feedback com explicação e referência
                    if (quizProvider.isAnswered &&
                        !quizProvider.isCurrentAnswerCorrect) ...[
                      const SizedBox(height: 14),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.vermelhoLiturgico.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                              color: AppColors.vermelhoLiturgico.withOpacity(0.3)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.info_outline_rounded,
                                    color: AppColors.vermelhoLiturgico, size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  'A resposta correta era: ${question.options[question.correctIndex]}',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: AppColors.vermelhoLiturgico,
                                  ),
                                ),
                              ],
                            ),
                            if (question.explanation.isNotEmpty) ...[
                              const SizedBox(height: 6),
                              Text(
                                question.explanation,
                                style: GoogleFonts.inter(
                                  fontSize: 12.5,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ],
                            if (question.reference.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(
                                'Fonte: ${question.reference}',
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  fontStyle: FontStyle.italic,
                                  color: AppColors.azulMariano,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // Barra inferior com botão de Próxima Pergunta
            if (quizProvider.isAnswered)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.branco,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 8,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _dialogShownForCurrentQuestion = false;
                      quizProvider.nextQuestion(
                        userId: authProvider.user?.uid ?? '',
                        displayName: authProvider.displayName,
                        photoUrl: authProvider.user?.photoURL,
                      );
                    },
                    icon: const Icon(Icons.arrow_forward_rounded,
                        color: AppColors.branco),
                    label: Text(
                      quizProvider.currentIndex <
                              quizProvider.questions.length - 1
                          ? 'PRÓXIMA PERGUNTA'
                          : 'VER RESULTADO FINAL',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.branco,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.azulMariano,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showExitConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Deseja sair do quiz?',
          style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Se sair agora, o progresso da partida não será salvo no ranking.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Continuar Jogando'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pushReplacementNamed(AppRoutes.home);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.vermelhoLiturgico,
            ),
            child: const Text('Sair', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
