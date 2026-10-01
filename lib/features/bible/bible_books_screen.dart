import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import 'bible_chapters_screen.dart';
import 'bible_models.dart';

class BibleBooksScreen extends StatefulWidget {
  const BibleBooksScreen({super.key, required this.language, required this.translation});

  final BibleLanguage language;
  final BibleTranslation translation;

  @override
  State<BibleBooksScreen> createState() => _BibleBooksScreenState();
}

class _BibleBooksScreenState extends State<BibleBooksScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = bibleBooks.where((book) => book.name.toLowerCase().contains(_query.toLowerCase())).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
        actions: [
          IconButton(
            tooltip: 'Search books',
            onPressed: () async {
              final query = await showSearch<String>(
                context: context,
                delegate: _BookSearchDelegate(bibleBooks),
              );
              if (query != null) setState(() => _query = query);
            },
            icon: const Icon(Icons.search_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          _TranslationHeader(language: widget.language, translation: widget.translation),
          const SizedBox(height: 20),
          const _SectionLabel('OLD TESTAMENT'),
          const SizedBox(height: 10),
          ...filtered.where((book) => book.testament == 'Old Testament').map(_bookTile),
          const SizedBox(height: 24),
          const _SectionLabel('NEW TESTAMENT'),
          const SizedBox(height: 10),
          ...filtered.where((book) => book.testament == 'New Testament').map(_bookTile),
        ],
      ),
    );
  }

  Widget _bookTile(BibleBook book) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          title: Text(book.name),
          subtitle: Text('${book.chapters} chapters'),
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => BibleChaptersScreen(
                book: book,
                language: widget.language,
                translation: widget.translation,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TranslationHeader extends StatelessWidget {
  const _TranslationHeader({required this.language, required this.translation});

  final BibleLanguage language;
  final BibleTranslation translation;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.gold.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.22)),
      ),
      child: Row(
        children: [
          const Icon(Icons.menu_book_rounded, color: AppColors.gold, size: 34),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(translation.name, style: const TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(language.nativeName, style: const TextStyle(color: AppColors.muted)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: const TextStyle(color: AppColors.gold, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1.4),
      );
}

class _BookSearchDelegate extends SearchDelegate<String> {
  _BookSearchDelegate(this.books);

  final List<BibleBook> books;

  @override
  List<Widget>? buildActions(BuildContext context) => [
        if (query.isNotEmpty)
          IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear_rounded)),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, ''),
        icon: const Icon(Icons.arrow_back_rounded),
      );

  @override
  Widget buildResults(BuildContext context) => _results();

  @override
  Widget buildSuggestions(BuildContext context) => _results();

  Widget _results() {
    final results = books.where((book) => book.name.toLowerCase().contains(query.toLowerCase())).toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (_, index) => ListTile(
        leading: const Icon(Icons.menu_book_rounded, color: AppColors.gold),
        title: Text(results[index].name),
        subtitle: Text('${results[index].chapters} chapters'),
        onTap: () => close(context, results[index].name),
      ),
    );
  }
}
