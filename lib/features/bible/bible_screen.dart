import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import 'language_selection_screen.dart';

class BibleScreen extends StatelessWidget {
  const BibleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
          children: [
            const Text('Bible', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text('Choose a language, translation, book and chapter to begin your study.', style: TextStyle(color: AppColors.muted, height: 1.5)),
            const SizedBox(height: 24),
            _PrimaryActionCard(
              title: 'Choose Bible language',
              subtitle: 'Search and select your preferred language',
              onTap: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const LanguageSelectionScreen())),
            ),
            const SizedBox(height: 14),
            const _FeatureCard(icon: Icons.search_rounded, title: 'Bible search', subtitle: 'Search verses and topics after a licensed Bible index is connected.'),
            const SizedBox(height: 14),
            const _FeatureCard(icon: Icons.bookmark_rounded, title: 'Bookmarks & highlights', subtitle: 'Save important passages and connect them to your personal notes.'),
            const SizedBox(height: 14),
            const _FeatureCard(icon: Icons.auto_awesome_rounded, title: 'Ask AI about a verse', subtitle: 'Explain, summarize, study, or turn a passage into a note.'),
          ],
        ),
      ),
    );
  }
}

class _PrimaryActionCard extends StatelessWidget {
  const _PrimaryActionCard({required this.title, required this.subtitle, required this.onTap});

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.gold.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(26),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(26),
        child: Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(26), border: Border.all(color: AppColors.gold.withValues(alpha: 0.35))),
          child: const Row(
            children: [
              _GoldIcon(icon: Icons.translate_rounded),
              SizedBox(width: 16),
              Expanded(child: _PrimaryText()),
              Icon(Icons.chevron_right_rounded, color: AppColors.gold),
            ],
          ),
        ),
      ),
    );
  }
}

class _GoldIcon extends StatelessWidget {
  const _GoldIcon({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) => Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(color: AppColors.gold, borderRadius: BorderRadius.circular(18)),
        child: Icon(icon, color: AppColors.black),
      );
}

class _PrimaryText extends StatelessWidget {
  const _PrimaryText();

  @override
  Widget build(BuildContext context) => const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Choose Bible language', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
          SizedBox(height: 5),
          Text('Search and select your preferred language', style: TextStyle(color: AppColors.muted, fontSize: 13, height: 1.35)),
        ],
      );
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.icon, required this.title, required this.subtitle});

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(22), border: Border.all(color: AppColors.divider)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.gold, size: 28),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 5),
                  Text(subtitle, style: const TextStyle(color: AppColors.muted, fontSize: 13, height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      );
}
