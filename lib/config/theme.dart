import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Primary palette
  static const Color dourado = Color(0xFFC9A84C);
  static const Color azulMariano = Color(0xFF1B3A5C);
  static const Color branco = Color(0xFFFFFFFF);
  static const Color vermelhoLiturgico = Color(0xFF8B0000);
  static const Color verdeEsperanca = Color(0xFF2E7D32);
  static const Color cinzaClaro = Color(0xFFF5F5F5);

  // Extended palette
  static const Color douradoLight = Color(0xFFE8D9A0);
  static const Color douradoDark = Color(0xFFA18A3E);
  static const Color azulMarianoLight = Color(0xFF2C5A8C);
  static const Color azulMarianoDark = Color(0xFF0F2440);

  AppColors._();
}

class AppTheme {
  AppTheme._();

  // ─── Light Theme ───────────────────────────────────────────────

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColors.dourado,
        onPrimary: AppColors.branco,
        primaryContainer: AppColors.douradoLight,
        onPrimaryContainer: AppColors.azulMarianoDark,
        secondary: AppColors.azulMariano,
        onSecondary: AppColors.branco,
        secondaryContainer: AppColors.azulMarianoLight,
        onSecondaryContainer: AppColors.branco,
        surface: AppColors.branco,
        onSurface: AppColors.azulMariano,
        surfaceContainerHighest: AppColors.cinzaClaro,
        error: AppColors.vermelhoLiturgico,
        onError: AppColors.branco,
      ),
      scaffoldBackgroundColor: AppColors.cinzaClaro,
      textTheme: _buildTextTheme(Brightness.light),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.azulMariano,
        foregroundColor: AppColors.branco,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.playfairDisplay(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppColors.branco,
        ),
      ),
      cardTheme: CardTheme(
        color: AppColors.branco,
        elevation: 2,
        shadowColor: AppColors.azulMariano.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.dourado,
          foregroundColor: AppColors.branco,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.azulMariano,
          side: const BorderSide(color: AppColors.dourado, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.dourado,
        foregroundColor: AppColors.branco,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.branco,
        selectedItemColor: AppColors.dourado,
        unselectedItemColor: AppColors.azulMariano,
        type: BottomNavigationBarType.fixed,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.dourado,
        linearTrackColor: AppColors.cinzaClaro,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.cinzaClaro,
        selectedColor: AppColors.dourado,
        labelStyle: GoogleFonts.inter(fontSize: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.azulMariano.withValues(alpha: 0.1),
        thickness: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.branco,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.cinzaClaro),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.cinzaClaro),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.dourado, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.vermelhoLiturgico),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  // ─── Dark Theme ────────────────────────────────────────────────

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.dourado,
        onPrimary: AppColors.azulMarianoDark,
        primaryContainer: AppColors.douradoDark,
        onPrimaryContainer: AppColors.douradoLight,
        secondary: AppColors.azulMarianoLight,
        onSecondary: AppColors.branco,
        secondaryContainer: AppColors.azulMariano,
        onSecondaryContainer: AppColors.branco,
        surface: AppColors.azulMarianoDark,
        onSurface: AppColors.branco,
        surfaceContainerHighest: AppColors.azulMariano,
        error: Color(0xFFCF6679),
        onError: AppColors.azulMarianoDark,
      ),
      scaffoldBackgroundColor: const Color(0xFF0A1929),
      textTheme: _buildTextTheme(Brightness.dark),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.azulMarianoDark,
        foregroundColor: AppColors.branco,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.playfairDisplay(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppColors.branco,
        ),
      ),
      cardTheme: CardTheme(
        color: AppColors.azulMariano,
        elevation: 4,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.dourado,
          foregroundColor: AppColors.azulMarianoDark,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.dourado,
          side: const BorderSide(color: AppColors.dourado, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.dourado,
        foregroundColor: AppColors.azulMarianoDark,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.azulMarianoDark,
        selectedItemColor: AppColors.dourado,
        unselectedItemColor: AppColors.branco,
        type: BottomNavigationBarType.fixed,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.dourado,
        linearTrackColor: AppColors.azulMariano,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.azulMariano,
        selectedColor: AppColors.dourado,
        labelStyle: GoogleFonts.inter(fontSize: 14, color: AppColors.branco),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.branco.withValues(alpha: 0.1),
        thickness: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.azulMariano,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.branco.withValues(alpha: 0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.branco.withValues(alpha: 0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.dourado, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFCF6679)),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  // ─── Typography ────────────────────────────────────────────────

  static TextTheme _buildTextTheme(Brightness brightness) {
    final Color textColor =
        brightness == Brightness.light ? AppColors.azulMariano : AppColors.branco;

    return TextTheme(
      // Display styles — Playfair Display
      displayLarge: GoogleFonts.playfairDisplay(
        fontSize: 57,
        fontWeight: FontWeight.w700,
        color: textColor,
      ),
      displayMedium: GoogleFonts.playfairDisplay(
        fontSize: 45,
        fontWeight: FontWeight.w700,
        color: textColor,
      ),
      displaySmall: GoogleFonts.playfairDisplay(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),

      // Headline styles — Playfair Display
      headlineLarge: GoogleFonts.playfairDisplay(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: textColor,
      ),
      headlineMedium: GoogleFonts.playfairDisplay(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      headlineSmall: GoogleFonts.playfairDisplay(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),

      // Title styles — Playfair Display
      titleLarge: GoogleFonts.playfairDisplay(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),

      // Body styles — Inter
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),

      // Label styles — Roboto Mono (numbers/timer)
      labelLarge: GoogleFonts.robotoMono(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      labelMedium: GoogleFonts.robotoMono(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      labelSmall: GoogleFonts.robotoMono(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
    );
  }
}
