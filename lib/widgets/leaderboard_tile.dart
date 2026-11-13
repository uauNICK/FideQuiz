import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fidequiz/config/theme.dart';
import 'package:fidequiz/models/leaderboard_entry.dart';

class LeaderboardTile extends StatelessWidget {
  final int rank;
  final LeaderboardEntry entry;
  final bool isCurrentUser;

  const LeaderboardTile({
    super.key,
    required this.rank,
    required this.entry,
    this.isCurrentUser = false,
  });

  @override
  Widget build(BuildContext context) {
    Color rankBadgeColor = Colors.grey.shade400;
    Widget rankIcon = Text(
      '$rankº',
      style: GoogleFonts.robotoMono(
        fontWeight: FontWeight.bold,
        color: Colors.grey.shade700,
        fontSize: 14,
      ),
    );

    if (rank == 1) {
      rankBadgeColor = const Color(0xFFFFD700); // Ouro
      rankIcon = const Text('🥇', style: TextStyle(fontSize: 22));
    } else if (rank == 2) {
      rankBadgeColor = const Color(0xFFC0C0C0); // Prata
      rankIcon = const Text('🥈', style: TextStyle(fontSize: 22));
    } else if (rank == 3) {
      rankBadgeColor = const Color(0xFFCD7F32); // Bronze
      rankIcon = const Text('🥉', style: TextStyle(fontSize: 22));
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? AppColors.dourado.withOpacity(0.12)
            : AppColors.branco,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCurrentUser ? AppColors.dourado : Colors.grey.shade200,
          width: isCurrentUser ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Posição no Ranking
          SizedBox(
            width: 36,
            child: Center(child: rankIcon),
          ),
          const SizedBox(width: 12),
          // Avatar
          CircleAvatar(
            radius: 20,
            backgroundColor: rankBadgeColor.withOpacity(0.2),
            child: Text(
              entry.displayName.isNotEmpty
                  ? entry.displayName.substring(0, 1).toUpperCase()
                  : 'F',
              style: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.bold,
                color: AppColors.azulMarianoDark,
              ),
            ),
          ),
          const SizedBox(width: 14),
          // Nome do Jogador e Jogos
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.displayName,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: isCurrentUser ? FontWeight.bold : FontWeight.w600,
                    color: AppColors.azulMarianoDark,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${entry.gamesPlayed} partidas jogadas',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          // Pontuação
          Text(
            '${entry.score} pts',
            style: GoogleFonts.robotoMono(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.douradoDark,
            ),
          ),
        ],
      ),
    );
  }
}
