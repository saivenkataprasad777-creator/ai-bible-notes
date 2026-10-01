import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../ai/ai_assistant_screen.dart';
import '../bible/bible_screen.dart';
import '../notes/notes_screen.dart';
import '../settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  void _openTab(int index) => setState(() => _index = index);

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      _HomeDashboard(onOpenBible: () => _openTab(1), onOpenNotes: () => _openTab(2), onOpenAI: () => _openTab(3)),
      const BibleScreen(),
      const NotesScreen(),
      const AIAssistantScreen(),
    ];

    return Scaffold(
      body: SafeArea(child: IndexedStack(index: _index, children: pages)),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: _openTab,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book_rounded), label: 'Bible'),
          NavigationDestination(icon: Icon(Icons.edit_note_outlined), selectedIcon: Icon(Icons.edit_note_rounded), label: 'Notes'),
          NavigationDestination(icon: Icon(Icons.auto_awesome_outlined), selectedIcon: Icon(Icons.auto_awesome_rounded), label: 'AI'),
        ],
      ),
    );
  }
}

class _HomeDashboard extends StatelessWidget {
  const _HomeDashboard({required this.onOpenBible, required this.onOpenNotes, required this.onOpenAI});

  final VoidCallback onOpenBible;
  final VoidCallback onOpenNotes;
  final VoidCallback onOpenAI;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Row(children: [
                const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Welcome', style: TextStyle(color: AppColors.muted, fontSize: 14)),
                  SizedBox(height: 5),
                  Text('AI Bible Notes', style: TextStyle(color: AppColors.warmWhite, fontSize: 28, fontWeight: FontWeight.w700)),
                ])),
                IconButton(tooltip: 'Settings', onPressed: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const SettingsScreen())), icon: const Icon(Icons.settings_outlined)),
              ]),
              const SizedBox(height: 28),
              const _DailyVerseCard(),
              const SizedBox(height: 28),
              const Text('Start here', style: TextStyle(color: AppColors.warmWhite, fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(height: 14),
              _PrimaryCard(icon: Icons.menu_book_rounded, title: 'Bible', subtitle: 'Read Scripture in your language', onTap: onOpenBible),
              const SizedBox(height: 14),
              _PrimaryCard(icon: Icons.edit_note_rounded, title: 'Bible Notes', subtitle: 'Write, highlight, organize and study', onTap: onOpenNotes),
              const SizedBox(height: 28),
              const Text('Quick tools', style: TextStyle(color: AppColors.warmWhite, fontSize: 18, fontWeight: FontWeight.w700)),
              const SizedBox(height: 14),
              Row(children: [
                Expanded(child: _QuickCard(icon: Icons.mic_none_rounded, title: 'Sermon', subtitle: 'AI transcription', onTap: () {})),
                const SizedBox(width: 12),
                Expanded(child: _QuickCard(icon: Icons.auto_awesome_rounded, title: 'Ask AI', subtitle: 'Study smarter', onTap: onOpenAI)),
              ]),
            ]),
          ),
        ),
      ],
    );
  }
}

class _DailyVerseCard extends StatelessWidget {
  const _DailyVerseCard();
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(28), gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF201C0D), Color(0xFF121212)]), border: Border.all(color: AppColors.gold.withValues(alpha: 0.35))),
    child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [Icon(Icons.wb_sunny_outlined, color: AppColors.gold, size: 20), SizedBox(width: 8), Text('DAILY VERSE', style: TextStyle(color: AppColors.gold, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1.5))]),
      SizedBox(height: 18),
      Text('Open the Bible to read real Scripture and start your study.', style: TextStyle(color: AppColors.warmWhite, fontSize: 18, height: 1.45, fontWeight: FontWeight.w500)),
      SizedBox(height: 14),
      Text('Bible text is loaded from the connected free-use Bible data service.', style: TextStyle(color: AppColors.muted, fontSize: 12)),
    ]),
  );
}

class _PrimaryCard extends StatelessWidget {
  const _PrimaryCard({required this.icon, required this.title, required this.subtitle, required this.onTap});
  final IconData icon; final String title; final String subtitle; final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Material(color: Colors.transparent, child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(26), child: Ink(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(26), border: Border.all(color: AppColors.gold.withValues(alpha: 0.28))), child: Row(children: [
    Container(width: 58, height: 58, decoration: BoxDecoration(color: AppColors.gold.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(18)), child: Icon(icon, color: AppColors.gold, size: 30)),
    const SizedBox(width: 16),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: AppColors.warmWhite, fontSize: 18, fontWeight: FontWeight.w700)), const SizedBox(height: 5), Text(subtitle, style: const TextStyle(color: AppColors.muted, fontSize: 13))])),
    const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.gold, size: 17),
  ]))));
}

class _QuickCard extends StatelessWidget {
  const _QuickCard({required this.icon, required this.title, required this.subtitle, required this.onTap});
  final IconData icon; final String title; final String subtitle; final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Material(color: Colors.transparent, child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(22), child: Ink(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(22), border: Border.all(color: AppColors.divider)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Container(width: 44, height: 44, decoration: BoxDecoration(color: AppColors.gold.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(14)), child: Icon(icon, color: AppColors.gold)),
    const SizedBox(height: 18),
    Text(title, style: const TextStyle(color: AppColors.warmWhite, fontWeight: FontWeight.w700)),
    const SizedBox(height: 4),
    Text(subtitle, style: const TextStyle(color: AppColors.muted, fontSize: 12)),
  ]))));
}
