import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import 'bible_models.dart';
import 'bible_translation_screen.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  List<BibleLanguage> get _filtered => bibleLanguages
      .where((language) => '${language.name} ${language.nativeName}'
          .toLowerCase()
          .contains(_query.toLowerCase()))
      .toList();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bible language')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _query = value),
              decoration: InputDecoration(
                hintText: 'Search languages...',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _query.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _query = '');
                        },
                        icon: const Icon(Icons.clear_rounded),
                      ),
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: ListView.separated(
                itemCount: _filtered.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final language = _filtered[index];
                  return Material(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(18),
                    child: ListTile(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      leading: CircleAvatar(
                        backgroundColor: AppColors.gold.withValues(alpha: 0.12),
                        child: Text(
                          language.code.toUpperCase(),
                          style: const TextStyle(color: AppColors.gold, fontSize: 11, fontWeight: FontWeight.w700),
                        ),
                      ),
                      title: Text(language.name),
                      subtitle: Text(language.nativeName),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => BibleTranslationScreen(language: language),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
