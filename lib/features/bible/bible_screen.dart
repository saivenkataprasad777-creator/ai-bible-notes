import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class BibleScreen extends StatelessWidget {
  const BibleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ModulePlaceholder(
      icon: Icons.menu_book_rounded,
      title: 'Bible',
      subtitle: 'Languages, translations, books, chapters, verses, search, highlights and bookmarks will be built here.',
    );
  }
}

class _ModulePlaceholder extends StatelessWidget {
  const _ModulePlaceholder({required this.icon, required this.title, required this.subtitle});

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.gold, size: 64),
            const SizedBox(height: 22),
            Text(title, style: const TextStyle(color: AppColors.warmWhite, fontSize: 28, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.muted, height: 1.5)),
          ],
        ),
      ),
    );
  }
}
