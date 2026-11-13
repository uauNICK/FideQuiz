import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fidequiz/config/theme.dart';

class TimerWidget extends StatelessWidget {
  final int secondsRemaining;
  final int totalSeconds;
  final double size;

  const TimerWidget({
    super.key,
    required this.secondsRemaining,
    this.totalSeconds = 15,
    this.size = 64,
  });

  Color get _timerColor {
    if (secondsRemaining > 8) {
      return AppColors.verdeEsperanca;
    } else if (secondsRemaining > 4) {
      return AppColors.dourado;
    } else {
      return AppColors.vermelhoLiturgico;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double progress =
        (secondsRemaining / totalSeconds).clamp(0.0, 1.0);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background track
          CircularProgressIndicator(
            value: 1.0,
            strokeWidth: 4.5,
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.grey.shade200,
            ),
          ),
          // Active progress
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 4.5,
            valueColor: AlwaysStoppedAnimation<Color>(_timerColor),
            strokeCap: StrokeCap.round,
          ),
          // Segundos numéricos
          Text(
            '$secondsRemaining',
            style: GoogleFonts.robotoMono(
              fontSize: size * 0.36,
              fontWeight: FontWeight.bold,
              color: _timerColor,
            ),
          ),
        ],
      ),
    );
  }
}
