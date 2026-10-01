import 'dart:convert';

import 'package:http/http.dart' as http;

class BibleVerse {
  const BibleVerse({required this.number, required this.text});

  final int number;
  final String text;
}

class BibleChapter {
  const BibleChapter({required this.translationName, required this.verses});

  final String translationName;
  final List<BibleVerse> verses;
}

class BibleService {
  static const _base = 'https://bible.helloao.org/api';

  Future<BibleChapter> getChapter({required String translation, required String bookId, required int chapter}) async {
    final uri = Uri.parse('$_base/$translation/$bookId/$chapter.simple.json');
    final response = await http.get(uri).timeout(const Duration(seconds: 20));
    if (response.statusCode != 200) {
      throw Exception('Bible service returned ${response.statusCode}.');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final translationData = data['translation'] as Map<String, dynamic>?;
    final chapterData = data['chapter'] as Map<String, dynamic>?;
    final content = chapterData?['content'] as List<dynamic>? ?? const [];

    final verses = <BibleVerse>[];
    for (final item in content) {
      if (item is Map<String, dynamic> && item['type'] == 'verse') {
        verses.add(BibleVerse(
          number: (item['number'] as num).toInt(),
          text: (item['text'] ?? '').toString().trim(),
        ));
      }
    }

    return BibleChapter(
      translationName: (translationData?['name'] ?? translation).toString(),
      verses: verses,
    );
  }
}
