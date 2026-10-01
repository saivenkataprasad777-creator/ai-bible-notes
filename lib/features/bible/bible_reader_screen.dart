import 'package:flutter/material.dart';

import '../../core/services/bible_service.dart';
import '../../core/theme/app_theme.dart';
import 'bible_models.dart';

class BibleReaderScreen extends StatefulWidget {
  const BibleReaderScreen({super.key, required this.book, required this.chapter, required this.language, required this.translation});

  final BibleBook book;
  final int chapter;
  final BibleLanguage language;
  final BibleTranslation translation;

  @override
  State<BibleReaderScreen> createState() => _BibleReaderScreenState();
}

class _BibleReaderScreenState extends State<BibleReaderScreen> {
  final _service = BibleService();
  double _fontSize = 18;
  Future<BibleChapter>? _chapterFuture;
  final Set<int> _bookmarkedVerses = <int>{};
  final Set<int> _highlightedVerses = <int>{};

  @override
  void initState() {
    super.initState();
    _loadChapter();
  }

  void _loadChapter() {
    _chapterFuture = _service.getChapter(
      translation: _translationId,
      bookId: _bookId(widget.book.name),
      chapter: widget.chapter,
    );
  }

  String get _translationId {
    // BSB is freely usable through the Free Use Bible API.
    return widget.translation.name.startsWith('English') ? 'BSB' : 'BSB';
  }

  String _bookId(String name) {
    const ids = {
      'Genesis': 'GEN', 'Exodus': 'EXO', 'Leviticus': 'LEV', 'Numbers': 'NUM', 'Deuteronomy': 'DEU',
      'Joshua': 'JOS', 'Judges': 'JDG', 'Ruth': 'RUT', 'Psalms': 'PSA', 'Proverbs': 'PRO',
      'Isaiah': 'ISA', 'Matthew': 'MAT', 'Mark': 'MRK', 'Luke': 'LUK', 'John': 'JHN', 'Acts': 'ACT',
      'Romans': 'ROM', '1 Corinthians': '1CO', '2 Corinthians': '2CO', 'Galatians': 'GAL',
      'Ephesians': 'EPH', 'Philippians': 'PHP', 'Colossians': 'COL', '1 Peter': '1PE',
      '1 John': '1JN', 'Revelation': 'REV',
    };
    return ids[name] ?? 'GEN';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${widget.book.name} ${widget.chapter}'),
            Text(widget.translation.name, style: const TextStyle(fontSize: 11, color: AppColors.muted)),
          ],
        ),
        actions: [
          IconButton(tooltip: 'Text size', onPressed: _showTextSize, icon: const Icon(Icons.text_fields_rounded)),
          IconButton(tooltip: 'Refresh', onPressed: () => setState(_loadChapter), icon: const Icon(Icons.refresh_rounded)),
        ],
      ),
      body: FutureBuilder<BibleChapter>(
        future: _chapterFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.cloud_off_rounded, color: AppColors.gold, size: 52),
                    const SizedBox(height: 16),
                    const Text('Bible text could not be loaded', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    Text('${snapshot.error}', textAlign: TextAlign.center, style: const TextStyle(color: AppColors.muted)),
                    const SizedBox(height: 18),
                    FilledButton.icon(onPressed: () => setState(_loadChapter), icon: const Icon(Icons.refresh_rounded), label: const Text('Try again')),
                  ],
                ),
              ),
            );
          }

          final chapter = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 40),
            itemCount: chapter.verses.length,
            itemBuilder: (context, index) {
              final verse = chapter.verses[index];
              final highlighted = _highlightedVerses.contains(verse.number);
              final bookmarked = _bookmarkedVerses.contains(verse.number);
              return GestureDetector(
                onLongPress: () => _showVerseActions(verse),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: highlighted ? AppColors.gold.withValues(alpha: 0.10) : Colors.transparent,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: highlighted ? AppColors.gold.withValues(alpha: 0.30) : Colors.transparent),
                  ),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(text: '${verse.number}  ', style: const TextStyle(color: AppColors.gold, fontWeight: FontWeight.w700, fontSize: 13)),
                      TextSpan(text: verse.text, style: TextStyle(color: AppColors.warmWhite, fontSize: _fontSize, height: 1.65)),
                      if (bookmarked) const WidgetSpan(alignment: PlaceholderAlignment.middle, child: Padding(padding: EdgeInsets.only(left: 8), child: Icon(Icons.bookmark_rounded, color: AppColors.gold, size: 16))),
                    ]),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showVerseActions(BibleVerse verse) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Wrap(children: [
          ListTile(leading: const Icon(Icons.highlight_rounded, color: AppColors.gold), title: const Text('Highlight'), onTap: () { setState(() => _highlightedVerses.contains(verse.number) ? _highlightedVerses.remove(verse.number) : _highlightedVerses.add(verse.number)); Navigator.pop(context); }),
          ListTile(leading: const Icon(Icons.bookmark_add_rounded), title: const Text('Bookmark'), onTap: () { setState(() => _bookmarkedVerses.contains(verse.number) ? _bookmarkedVerses.remove(verse.number) : _bookmarkedVerses.add(verse.number)); Navigator.pop(context); }),
          ListTile(leading: const Icon(Icons.edit_note_rounded), title: const Text('Add to notes'), onTap: () { Navigator.pop(context); Navigator.of(this.context).pushNamed('/notes'); }),
          ListTile(leading: const Icon(Icons.auto_awesome_rounded), title: const Text('Ask AI'), onTap: () { Navigator.pop(context); Navigator.of(this.context).pushNamed('/ai'); }),
        ]),
      ),
    );
  }

  void _showTextSize() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => Padding(
          padding: const EdgeInsets.fromLTRB(24, 10, 24, 30),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text('Reading size', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            Slider(min: 14, max: 28, value: _fontSize, activeColor: AppColors.gold, onChanged: (value) { setSheetState(() {}); setState(() => _fontSize = value); }),
          ]),
        ),
      ),
    );
  }
}
