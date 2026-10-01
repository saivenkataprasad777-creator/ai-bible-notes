import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import 'bible_models.dart';
import 'bible_reader_screen.dart';

class BibleChaptersScreen extends StatelessWidget {
  const BibleChaptersScreen({super.key, required this.book, required this.language, required this.translation});

  final BibleBook book;
  final BibleLanguage language;
  final BibleTranslation translation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(book.name)),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1,
        ),
        itemCount: book.chapters,
        itemBuilder: (context, index) {
          final chapter = index + 1;
          return Material(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(18),
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => BibleReaderScreen(
                    book: book,
                    chapter: chapter,
                    language: language,
                    translation: translation,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  '$chapter',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.warmWhite),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
