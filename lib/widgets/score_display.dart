import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fidequiz/config/theme.dart';

class ScoreDisplay extends StatelessWidget {
  final int score;
  final double fontSize;

  const ScoreDisplay({
    super.key,
    required this.score,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.dourado.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.dourado, width: 1.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.stars_rounded,
            color: AppColors.douradoDark,
            size: 20,
          ),
          const SizedBox(width: 6),
          Text(
            '$score pts',
            style: GoogleFonts.robotoMono(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.azulMarianoDark,
            ),
          ),
        ],
      ),
    );
  }
}
