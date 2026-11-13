import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:fidequiz/config/theme.dart';
import 'package:fidequiz/config/routes.dart';
import 'package:fidequiz/providers/auth_provider.dart';
import 'package:fidequiz/widgets/ad_banner_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final userName = authProvider.displayName;

    return Scaffold(
      backgroundColor: AppColors.cinzaClaro,
      appBar: AppBar(
        backgroundColor: AppColors.azulMarianoDark,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.church_rounded, color: AppColors.dourado, size: 24),
            const SizedBox(width: 8),
            Text(
              'FideQuiz',
              style: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.bold,
                color: AppColors.dourado,
                fontSize: 22,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.leaderboard_rounded, color: AppColors.dourado),
            tooltip: 'Rankings',
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.leaderboard),
          ),
          IconButton(
            icon: const Icon(Icons.person_rounded, color: AppColors.branco),
            tooltip: 'Meu Perfil',
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.profile),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Saudação
                    Text(
                      'Paz e Bem, $userName! 🙏',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.azulMarianoDark,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Teste seus conhecimentos e aprenda sobre a Igreja, Santos, Anjos e a Bíblia.',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Card Glorioso de Destaque "Jogar Agora"
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.azulMarianoDark,
                            AppColors.azulMariano,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.azulMariano.withOpacity(0.3),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: AppColors.dourado.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: AppColors.dourado),
                                ),
                                child: Text(
                                  'NOVO MODO',
                                  style: GoogleFonts.robotoMono(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.dourado,
                                  ),
                                ),
                              ),
                              const Text('✨😇', style: TextStyle(fontSize: 22)),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'Desbloqueie Figuras Sagradas!',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: AppColors.branco,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'A cada resposta correta, ganhe uma imagem abençoada e descubra uma curiosidade histórica sobre aquele Santo ou Anjo!',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: AppColors.branco.withOpacity(0.85),
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 18),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () => Navigator.of(context)
                                  .pushNamed(AppRoutes.categories),
                              icon: const Icon(Icons.play_arrow_rounded,
                                  color: AppColors.azulMarianoDark, size: 28),
                              label: Text(
                                'JOGAR AGORA',
                                style: GoogleFonts.inter(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.azulMarianoDark,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.dourado,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                elevation: 4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Grid de Acesso Rápido
                    Row(
                      children: [
                        // Rankings Diário, Semanal e Mensal
                        Expanded(
                          child: _buildQuickActionCard(
                            context: context,
                            title: 'Rankings',
                            subtitle: 'Diário, Semanal & Mensal',
                            icon: Icons.emoji_events_rounded,
                            iconColor: AppColors.dourado,
                            onTap: () => Navigator.of(context)
                                .pushNamed(AppRoutes.leaderboard),
                          ),
                        ),
                        const SizedBox(width: 14),
                        // Temas & Níveis
                        Expanded(
                          child: _buildQuickActionCard(
                            context: context,
                            title: 'Temas',
                            subtitle: 'Santos, Anjos, Bíblia',
                            icon: Icons.auto_stories_rounded,
                            iconColor: AppColors.azulMariano,
                            onTap: () => Navigator.of(context)
                                .pushNamed(AppRoutes.categories),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Card de Conta / Login (se anônimo)
                    if (!authProvider.isAuthenticated || authProvider.isAnonymous)
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.branco,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.cloud_sync_rounded,
                                color: AppColors.azulMariano, size: 30),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Salve seus pontos no Ranking',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.5,
                                      color: AppColors.azulMarianoDark,
                                    ),
                                  ),
                                  Text(
                                    'Crie sua conta para participar da disputa diária!',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context)
                                  .pushNamed(AppRoutes.login),
                              child: const Text('Entrar'),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            // Banner de Anúncio
            const AdBannerWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.branco,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.azulMarianoDark,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  fontSize: 11.5,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
