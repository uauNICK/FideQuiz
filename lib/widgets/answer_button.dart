import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fidequiz/config/theme.dart';

class AnswerButton extends StatelessWidget {
  final String text;
  final int index;
  final bool isSelected;
  final bool isCorrect;
  final bool isAnswered;
  final VoidCallback onTap;

  const AnswerButton({
    super.key,
    required this.text,
    required this.index,
    required this.isSelected,
    required this.isCorrect,
    required this.isAnswered,
    required this.onTap,
  });

  String get _letter {
    switch (index) {
      case 0:
        return 'A';
      case 1:
        return 'B';
      case 2:
        return 'C';
      case 3:
        return 'D';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = AppColors.branco;
    Color borderColor = AppColors.azulMariano.withOpacity(0.2);
    Color textColor = AppColors.azulMarianoDark;
    Color letterBg = AppColors.azulMariano.withOpacity(0.08);
    Color letterColor = AppColors.azulMariano;
    IconData? icon;

    if (isAnswered) {
      if (isCorrect) {
        backgroundColor = AppColors.verdeEsperanca.withOpacity(0.12);
        borderColor = AppColors.verdeEsperanca;
        textColor = AppColors.verdeEsperanca;
        letterBg = AppColors.verdeEsperanca;
        letterColor = AppColors.branco;
        icon = Icons.check_circle_rounded;
      } else if (isSelected && !isCorrect) {
        backgroundColor = AppColors.vermelhoLiturgico.withOpacity(0.1);
        borderColor = AppColors.vermelhoLiturgico;
        textColor = AppColors.vermelhoLiturgico;
        letterBg = AppColors.vermelhoLiturgico;
        letterColor = AppColors.branco;
        icon = Icons.cancel_rounded;
      } else {
        textColor = Colors.grey.shade500;
        borderColor = Colors.grey.shade300;
      }
    } else if (isSelected) {
      backgroundColor = AppColors.douradoLight.withOpacity(0.3);
      borderColor = AppColors.dourado;
      letterBg = AppColors.dourado;
      letterColor = AppColors.branco;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isAnswered ? null : onTap,
          borderRadius: BorderRadius.circular(14),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: borderColor, width: 1.5),
            ),
            child: Row(
              children: [
                // Letra A, B, C, D
                Container(
                  width: 34,
                  height: 34,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: letterBg,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    _letter,
                    style: GoogleFonts.robotoMono(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: letterColor,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                // Texto da Alternativa
                Expanded(
                  child: Text(
                    text,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: textColor,
                      height: 1.25,
                    ),
                  ),
                ),
                if (icon != null) ...[
                  const SizedBox(width: 8),
                  Icon(icon, color: borderColor, size: 22),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
