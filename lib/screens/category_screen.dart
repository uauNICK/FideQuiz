import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:fidequiz/config/theme.dart';
import 'package:fidequiz/config/constants.dart';
import 'package:fidequiz/config/routes.dart';
import 'package:fidequiz/providers/quiz_provider.dart';
import 'package:fidequiz/widgets/category_card.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String _selectedCategory = 'todas';
  String _selectedDifficulty = AppConstants.difficultyEasy;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cinzaClaro,
      appBar: AppBar(
        title: Text(
          'Configurar Partida',
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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Seletor de Nível de Dificuldade
                    Text(
                      '1. Escolha o Nível de Dificuldade:',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.azulMarianoDark,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: AppConstants.difficultyLevels.map((level) {
                        final id = level['id'] as String;
                        final isSelected = _selectedDifficulty == id;
                        final icon = level['icon'] as String;
                        final title = level['title'] as String;

                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedDifficulty = id;
                                  });
                                },
                                borderRadius: BorderRadius.circular(14),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.dourado
                                        : AppColors.branco,
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.dourado
                                          : Colors.grey.shade300,
                                      width: isSelected ? 2 : 1,
                                    ),
                                    boxShadow: [
                                      if (isSelected)
                                        BoxShadow(
                                          color: AppColors.dourado.withOpacity(0.3),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Text(icon, style: const TextStyle(fontSize: 22)),
                                      const SizedBox(height: 6),
                                      Text(
                                        id,
                                        style: GoogleFonts.inter(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: isSelected
                                              ? AppColors.branco
                                              : AppColors.azulMarianoDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),

                    // Seletor de Temas
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '2. Escolha o Tema:',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.azulMarianoDark,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _selectedCategory = 'todas';
                            });
                          },
                          child: Text(
                            'Todos os Temas',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              color: _selectedCategory == 'todas'
                                  ? AppColors.douradoDark
                                  : Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Grid de Categorias
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1.1,
                      ),
                      itemCount: AppConstants.categories.length,
                      itemBuilder: (context, index) {
                        final cat = AppConstants.categories[index];
                        final id = cat['id']!;
                        final isSelected = _selectedCategory == id;

                        return CategoryCard(
                          id: id,
                          name: cat['name']!,
                          emoji: cat['emoji']!,
                          description: cat['description']!,
                          isSelected: isSelected,
                          onTap: () {
                            setState(() {
                              _selectedCategory = id;
                            });
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Botão Iniciar Partida
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.branco,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final quizProvider = context.read<QuizProvider>();
                    await quizProvider.startQuiz(
                      categoryId: _selectedCategory,
                      difficulty: _selectedDifficulty,
                    );
                    if (context.mounted) {
                      Navigator.of(context).pushReplacementNamed(AppRoutes.quiz);
                    }
                  },
                  icon: const Icon(Icons.flash_on_rounded, color: AppColors.branco),
                  label: Text(
                    'INICIAR QUIZ (10 PERGUNTAS)',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.branco,
                      letterSpacing: 0.5,
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
            ),
          ],
        ),
      ),
    );
  }
}
