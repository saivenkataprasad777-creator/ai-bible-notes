import 'package:flutter/material.dart';

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
  double _fontSize = 18;
  final Set<int> _bookmarkedVerses = <int>{};
  final Set<int> _highlightedVerses = <int>{};

  // Placeholder verses are intentionally not Bible text. Licensed Bible content will be supplied by the data provider.
  final List<String> _placeholderVerses = const [
    'Licensed Bible text will appear here after the Bible data provider is connected.',
    'Verse content is kept outside the application source so translations can be managed legally and independently.',
    'You will be able to select, copy, highlight, bookmark, and add each verse to your notes.',
    'AI Bible Notes will also validate detected Bible references before creating verse links.',
    'The reader is ready for the real Bible content layer.',
  ];

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
          IconButton(
            tooltip: 'Text size',
            onPressed: _showTextSize,
            icon: const Icon(Icons.text_fields_rounded),
          ),
          IconButton(
            tooltip: 'Search Bible',
            onPressed: _showSearch,
            icon: const Icon(Icons.search_rounded),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 40),
        itemCount: _placeholderVerses.length,
        itemBuilder: (context, index) {
          final verse = index + 1;
          final highlighted = _highlightedVerses.contains(verse);
          final bookmarked = _bookmarkedVerses.contains(verse);
          return GestureDetector(
            onLongPress: () => _showVerseActions(verse),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: highlighted ? AppColors.gold.withValues(alpha: 0.10) : Colors.transparent,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: highlighted ? AppColors.gold.withValues(alpha: 0.30) : Colors.transparent,
                ),
              ),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$verse ',
                      style: const TextStyle(color: AppColors.gold, fontWeight: FontWeight.w700, fontSize: 13),
                    ),
                    TextSpan(
                      text: _placeholderVerses[index],
                      style: TextStyle(color: AppColors.warmWhite, fontSize: _fontSize, height: 1.65),
                    ),
                    if (bookmarked)
                      const WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Icon(Icons.bookmark_rounded, color: AppColors.gold, size: 16),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showVerseActions(int verse) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(leading: const Icon(Icons.copy_rounded), title: const Text('Copy verse'), onTap: () => Navigator.pop(context)),
            ListTile(
              leading: const Icon(Icons.highlight_rounded, color: AppColors.gold),
              title: const Text('Highlight'),
              onTap: () {
                setState(() => _highlightedVerses.contains(verse) ? _highlightedVerses.remove(verse) : _highlightedVerses.add(verse));
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.bookmark_add_rounded),
              title: const Text('Bookmark'),
              onTap: () {
                setState(() => _bookmarkedVerses.contains(verse) ? _bookmarkedVerses.remove(verse) : _bookmarkedVerses.add(verse));
                Navigator.pop(context);
              },
            ),
            ListTile(leading: const Icon(Icons.edit_note_rounded), title: const Text('Add to notes'), onTap: () => Navigator.pop(context)),
            ListTile(leading: const Icon(Icons.auto_awesome_rounded), title: const Text('Ask AI'), onTap: () => Navigator.pop(context)),
            ListTile(leading: const Icon(Icons.share_rounded), title: const Text('Share'), onTap: () => Navigator.pop(context)),
          ],
        ),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Reading size', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              Slider(
                min: 14,
                max: 28,
                value: _fontSize,
                activeColor: AppColors.gold,
                onChanged: (value) {
                  setSheetState(() {});
                  setState(() => _fontSize = value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSearch() {
    showSearch<void>(context: context, delegate: _BibleSearchDelegate());
  }
}

class _BibleSearchDelegate extends SearchDelegate<void> {
  @override
  List<Widget>? buildActions(BuildContext context) => [
        if (query.isNotEmpty) IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear_rounded)),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(onPressed: () => close(context, null), icon: const Icon(Icons.arrow_back_rounded));

  @override
  Widget buildResults(BuildContext context) => _message();

  @override
  Widget buildSuggestions(BuildContext context) => _message();

  Widget _message() => const Center(
        child: Padding(
          padding: EdgeInsets.all(28),
          child: Text(
            'Bible search is ready for the licensed Bible index. The index will be connected without bundling copyrighted text in the app source.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.muted, height: 1.5),
          ),
        ),
      );
}
