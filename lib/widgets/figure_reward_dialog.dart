import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fidequiz/config/theme.dart';
import 'package:fidequiz/models/question.dart';

class FigureRewardDialog extends StatelessWidget {
  final Question question;
  final VoidCallback onContinue;

  const FigureRewardDialog({
    super.key,
    required this.question,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final hasFigure = question.figureName.isNotEmpty;
    final hasCuriosity = question.figureCuriosity.isNotEmpty;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 420),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: AppColors.branco,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.dourado, width: 2),
          boxShadow: [
            BoxShadow(
              color: AppColors.dourado.withOpacity(0.35),
              blurRadius: 30,
              spreadRadius: 2,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header de Vitória
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.verified_rounded, color: AppColors.verdeEsperanca, size: 26),
                  const SizedBox(width: 8),
                  Text(
                    'Correto! Deo Gratias!',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.verdeEsperanca,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Imagem da Figura (Santo, Anjo, Figura Católica)
              if (hasFigure) ...[
                Container(
                  width: double.infinity,
                  height: 190,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.douradoLight, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: question.figureImageUrl.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: question.figureImageUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: AppColors.azulMariano.withOpacity(0.08),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.dourado),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => _buildPlaceholder(),
                          )
                        : _buildPlaceholder(),
                  ),
                ),
                const SizedBox(height: 12),
                // Nome da Figura
                Text(
                  question.figureName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.azulMarianoDark,
                  ),
                ),
                const SizedBox(height: 10),
              ],

              // Card com Curiosidade sobre a figura
              if (hasCuriosity) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.dourado.withOpacity(0.09),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.dourado.withOpacity(0.4)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text('✨', style: TextStyle(fontSize: 16)),
                          const SizedBox(width: 6),
                          Text(
                            'Você Sabia? (Curiosidade)',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.douradoDark,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        question.figureCuriosity,
                        style: GoogleFonts.inter(
                          fontSize: 13.5,
                          height: 1.4,
                          color: AppColors.azulMarianoDark,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
              ],

              // Explicação & Referência
              if (question.explanation.isNotEmpty) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.cinzaClaro,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Explicação:',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        question.explanation,
                        style: GoogleFonts.inter(
                          fontSize: 12.5,
                          color: Colors.grey.shade800,
                          height: 1.3,
                        ),
                      ),
                      if (question.reference.isNotEmpty) ...[
                        const SizedBox(height: 6),
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
                const SizedBox(height: 18),
              ],

              // Botão Prosseguir
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onContinue();
                  },
                  icon: const Icon(Icons.arrow_forward_rounded, color: AppColors.branco),
                  label: Text(
                    'Continuar Partida',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.branco,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.dourado,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppColors.azulMarianoDark,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.church_rounded, size: 48, color: AppColors.dourado),
            const SizedBox(height: 8),
            Text(
              question.figureName,
              style: GoogleFonts.playfairDisplay(
                color: AppColors.branco,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
