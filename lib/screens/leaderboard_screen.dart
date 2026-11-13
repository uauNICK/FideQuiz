import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:fidequiz/config/theme.dart';
import 'package:fidequiz/providers/leaderboard_provider.dart';
import 'package:fidequiz/providers/auth_provider.dart';
import 'package:fidequiz/widgets/leaderboard_tile.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, String>> _tabs = [
    {'type': 'daily', 'label': 'Diário', 'subtitle': 'Hoje'},
    {'type': 'weekly', 'label': 'Semanal', 'subtitle': 'Esta Semana'},
    {'type': 'monthly', 'label': 'Mensal', 'subtitle': 'Este Mês'},
    {'type': 'alltime', 'label': 'Geral', 'subtitle': 'Histórico'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        final type = _tabs[_tabController.index]['type']!;
        context.read<LeaderboardProvider>().loadLeaderboard(type);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final leaderboardProvider = context.watch<LeaderboardProvider>();
    final currentUserId = context.watch<AuthProvider>().user?.uid ?? '';

    return Scaffold(
      backgroundColor: AppColors.cinzaClaro,
      appBar: AppBar(
        title: Text(
          'Rankings da Disputa 🏆',
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.bold,
            color: AppColors.dourado,
          ),
        ),
        backgroundColor: AppColors.azulMarianoDark,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.branco),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.dourado,
          indicatorWeight: 3,
          labelColor: AppColors.dourado,
          unselectedLabelColor: AppColors.branco.withOpacity(0.7),
          labelStyle: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 13.5),
          tabs: _tabs.map((t) => Tab(text: t['label'])).toList(),
        ),
      ),
      body: leaderboardProvider.isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.dourado),
              ),
            )
          : RefreshIndicator(
              onRefresh: () => leaderboardProvider.refresh(),
              color: AppColors.dourado,
              child: leaderboardProvider.entries.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.emoji_events_outlined,
                              size: 64, color: Colors.grey),
                          const SizedBox(height: 12),
                          Text(
                            'Nenhuma partida registrada ainda.',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text('Seja o primeiro a pontuar neste ranking!'),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      itemCount: leaderboardProvider.entries.length,
                      itemBuilder: (context, index) {
                        final entry = leaderboardProvider.entries[index];
                        final isCurrentUser =
                            entry.userId.isNotEmpty && entry.userId == currentUserId;

                        return LeaderboardTile(
                          rank: index + 1,
                          entry: entry,
                          isCurrentUser: isCurrentUser,
                        );
                      },
                    ),
            ),
    );
  }
}
