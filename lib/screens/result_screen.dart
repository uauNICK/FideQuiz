import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:fidequiz/config/theme.dart';
import 'package:fidequiz/config/routes.dart';
import 'package:fidequiz/providers/quiz_provider.dart';
import 'package:fidequiz/widgets/ad_banner_widget.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = context.watch<QuizProvider>();
    final score = quizProvider.score;
    final correct = quizProvider.correctAnswers;
    final total = quizProvider.questions.length;
    final percentage = total > 0 ? (correct / total) * 100 : 0.0;

    String praiseTitle;
    String praiseMessage;
    int stars = 1;

    if (percentage >= 80) {
      stars = 3;
      praiseTitle = 'Servo Bom e Fiel! 🌟';
      praiseMessage = 'Conhecimento admirável da fé católica e da doutrina!';
    } else if (percentage >= 50) {
      stars = 2;
      praiseTitle = 'Muito Bem! 🕊️';
      praiseMessage = 'Você demonstrou boa devoção e estudo das coisas de Deus!';
    } else {
      stars = 1;
      praiseTitle = 'Continue Firme! 🙏';
      praiseMessage = 'A fé se aprofunda a cada oração e leitura. Tente de novo!';
    }

    return Scaffold(
      backgroundColor: AppColors.cinzaClaro,
      appBar: AppBar(
        title: Text(
          'Resultado do FideQuiz',
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.bold,
            color: AppColors.dourado,
          ),
        ),
        backgroundColor: AppColors.azulMarianoDark,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
                child: Column(
                  children: [
                    // Card Principal de Vitória
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.branco,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppColors.dourado, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.dourado.withOpacity(0.25),
                            blurRadius: 20,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Estrelas
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(3, (idx) {
                              return Icon(
                                idx < stars
                                    ? Icons.star_rounded
                                    : Icons.star_outline_rounded,
                                size: 44,
                                color: AppColors.dourado,
                              );
                            }),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            praiseTitle,
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.azulMarianoDark,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            praiseMessage,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 13.5,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Divider(),
                          const SizedBox(height: 14),

                          // Estatísticas da Partida
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildStatItem('PONTOS', '$score', Icons.stars_rounded, AppColors.dourado),
                              _buildStatItem('ACERTOS', '$correct/$total', Icons.check_circle_rounded, AppColors.verdeEsperanca),
                              _buildStatItem('PRECISÃO', '${percentage.toStringAsFixed(0)}%', Icons.pie_chart_rounded, AppColors.azulMariano),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Ações
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed(AppRoutes.categories);
                        },
                        icon: const Icon(Icons.replay_rounded, color: AppColors.azulMarianoDark),
                        label: Text(
                          'JOGAR OUTRO TEMA / NÍVEL',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.azulMarianoDark,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.dourado,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 3,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pushNamed(AppRoutes.leaderboard);
                        },
                        icon: const Icon(Icons.leaderboard_rounded, color: AppColors.azulMariano),
                        label: Text(
                          'VER RANKING COMPLETO',
                          style: GoogleFonts.inter(
                            fontSize: 14.5,
                            fontWeight: FontWeight.bold,
                            color: AppColors.azulMariano,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.azulMariano, width: 1.5),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
                      },
                      child: Text(
                        'Voltar ao Menu Principal',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const AdBannerWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 26),
        const SizedBox(height: 6),
        Text(
          value,
          style: GoogleFonts.robotoMono(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.azulMarianoDark,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
