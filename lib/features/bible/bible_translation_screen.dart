import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import 'bible_books_screen.dart';
import 'bible_models.dart';

class BibleTranslationScreen extends StatelessWidget {
  const BibleTranslationScreen({super.key, required this.language});

  final BibleLanguage language;

  @override
  Widget build(BuildContext context) {
    final translations = bibleTranslations
        .where((translation) => translation.languageCode == language.code)
        .toList();

    final available = translations.isEmpty
        ? [
            BibleTranslation(
              name: '${language.name} — Provider ready',
              languageCode: language.code,
              description: 'Connect a licensed Bible provider to load this translation.',
            ),
          ]
        : translations;

    return Scaffold(
      appBar: AppBar(title: Text(language.name)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Choose a translation',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Select a Bible version for ${language.nativeName}. The provider layer is intentionally kept separate so licensed translations can be connected safely.',
            style: const TextStyle(color: AppColors.muted, height: 1.5),
          ),
          const SizedBox(height: 20),
          ...available.map(
            (translation) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Material(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  leading: const Icon(Icons.auto_stories_rounded, color: AppColors.gold),
                  title: Text(translation.name),
                  subtitle: Text(translation.description),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => BibleBooksScreen(
                        language: language,
                        translation: translation,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
