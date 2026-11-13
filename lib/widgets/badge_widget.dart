import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fidequiz/config/theme.dart';

class BadgeWidget extends StatelessWidget {
  final String badgeId;
  final String title;
  final String description;
  final String icon;
  final bool isUnlocked;

  const BadgeWidget({
    super.key,
    required this.badgeId,
    required this.title,
    required this.description,
    required this.icon,
    required this.isUnlocked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isUnlocked
            ? AppColors.dourado.withOpacity(0.08)
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isUnlocked ? AppColors.dourado : Colors.grey.shade300,
          width: isUnlocked ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isUnlocked
                  ? AppColors.dourado.withOpacity(0.2)
                  : Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: Text(
              icon,
              style: TextStyle(
                fontSize: 22,
                color: isUnlocked ? null : Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isUnlocked
                        ? AppColors.azulMarianoDark
                        : Colors.grey.shade600,
                  ),
                ),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          if (isUnlocked)
            const Icon(
              Icons.check_circle_rounded,
              color: AppColors.dourado,
              size: 20,
            )
          else
            Icon(
              Icons.lock_outline_rounded,
              color: Colors.grey.shade400,
              size: 20,
            ),
        ],
      ),
    );
  }
}
