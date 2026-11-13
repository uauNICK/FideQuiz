import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:fidequiz/config/theme.dart';
import 'package:fidequiz/config/routes.dart';
import 'package:fidequiz/providers/auth_provider.dart';
import 'package:fidequiz/widgets/badge_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final userProfile = authProvider.userProfile;
    final isAnon = authProvider.isAnonymous || !authProvider.isAuthenticated;

    return Scaffold(
      backgroundColor: AppColors.cinzaClaro,
      appBar: AppBar(
        title: Text(
          'Perfil & Conquistas',
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.bold,
            color: AppColors.branco,
          ),
        ),
        backgroundColor: AppColors.azulMarianoDark,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.branco),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              // Card do Perfil
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.branco,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: AppColors.douradoLight),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: AppColors.dourado.withOpacity(0.2),
                      child: const Icon(
                        Icons.person_rounded,
                        size: 48,
                        color: AppColors.azulMarianoDark,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      authProvider.displayName,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.azulMarianoDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isAnon
                          ? 'Modo Visitante (Pontos locais)'
                          : (authProvider.user?.email ?? 'Fiel Cadastrado'),
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 12),

                    // Estatísticas em Grid
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStat('Pontos', '${userProfile?.totalScore ?? 0}', AppColors.dourado),
                        _buildStat('Partidas', '${userProfile?.totalGames ?? 0}', AppColors.azulMariano),
                        _buildStat('Acertos', '${userProfile?.totalCorrect ?? 0}', AppColors.verdeEsperanca),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Conquistas Católicas
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Conquistas & Medalhas',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.azulMarianoDark,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              BadgeWidget(
                badgeId: 'iniciante',
                title: 'Iniciante na Fé',
                description: 'Completou seu primeiro FideQuiz',
                icon: '🙏',
                isUnlocked: (userProfile?.totalGames ?? 0) >= 1,
              ),
              const SizedBox(height: 8),
              BadgeWidget(
                badgeId: 'devoto',
                title: 'Fiel Conhecedor',
                description: 'Acertou mais de 25 perguntas',
                icon: '🕯️',
                isUnlocked: (userProfile?.totalCorrect ?? 0) >= 25,
              ),
              const SizedBox(height: 8),
              BadgeWidget(
                badgeId: 'sabio',
                title: 'Doutor da Fé',
                description: 'Alcançou mais de 500 pontos nos rankings',
                icon: '📜',
                isUnlocked: (userProfile?.totalScore ?? 0) >= 500,
              ),
              const SizedBox(height: 8),
              BadgeWidget(
                badgeId: 'anjo',
                title: 'Amigo dos Arcanjos',
                description: 'Gabaritou o tema de Anjos e Batalha Espiritual',
                icon: '⚔️',
                isUnlocked: false,
              ),

              const SizedBox(height: 28),

              // Botões de Ação
              if (isAnon)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () =>
                        Navigator.of(context).pushNamed(AppRoutes.login),
                    icon: const Icon(Icons.login_rounded, color: AppColors.branco),
                    label: const Text('Entrar ou Cadastrar Conta'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.dourado,
                      foregroundColor: AppColors.branco,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                )
              else
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      await authProvider.signOut();
                      if (context.mounted) {
                        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
                      }
                    },
                    icon: const Icon(Icons.logout_rounded, color: AppColors.vermelhoLiturgico),
                    label: const Text(
                      'Sair da Conta',
                      style: TextStyle(color: AppColors.vermelhoLiturgico),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.vermelhoLiturgico),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.robotoMono(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
