import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/theme/app_theme.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  static const _storageKey = 'bible_notes';
  List<Map<String, String>> _notes = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw != null) {
      final decoded = jsonDecode(raw) as List<dynamic>;
      _notes = decoded.map((e) => Map<String, String>.from(e as Map)).toList();
    }
    if (mounted) setState(() => _loading = false);
  }

  Future<void> _saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonEncode(_notes));
  }

  Future<void> _createNote() async {
    final titleController = TextEditingController(text: 'New Bible Note');
    final bodyController = TextEditingController();
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Create note'),
        content: SizedBox(width: 520, child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Title')),
          const SizedBox(height: 14),
          TextField(controller: bodyController, minLines: 5, maxLines: 10, decoration: const InputDecoration(labelText: 'Write your note...', alignLabelWithHint: true)),
        ])),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(dialogContext, true), child: const Text('Save')),
        ],
      ),
    );
    if (result == true) {
      setState(() => _notes.insert(0, {'title': titleController.text.trim().isEmpty ? 'Untitled note' : titleController.text.trim(), 'body': bodyController.text.trim()}));
      await _saveNotes();
    }
    titleController.dispose();
    bodyController.dispose();
  }

  Future<void> _deleteNote(int index) async {
    setState(() => _notes.removeAt(index));
    await _saveNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bible Notes')),
      floatingActionButton: FloatingActionButton.extended(onPressed: _createNote, icon: const Icon(Icons.add_rounded), label: const Text('Create note')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _notes.isEmpty
              ? Center(child: Padding(padding: const EdgeInsets.all(28), child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.edit_note_rounded, color: AppColors.gold, size: 64),
                  const SizedBox(height: 18),
                  const Text('Your study notebook', style: TextStyle(color: AppColors.warmWhite, fontSize: 26, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 10),
                  const Text('Create notes while reading the Bible. Notes are saved on this device/browser.', textAlign: TextAlign.center, style: TextStyle(color: AppColors.muted, height: 1.5)),
                  const SizedBox(height: 22),
                  FilledButton.icon(onPressed: _createNote, icon: const Icon(Icons.add_rounded), label: const Text('Create note')),
                ]))
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                  itemCount: _notes.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final note = _notes[index];
                    return Dismissible(
                      key: ValueKey('${note['title']}_$index'),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) => _deleteNote(index),
                      background: Container(alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 24), decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(20)), child: const Icon(Icons.delete_outline_rounded, color: Colors.white)),
                      child: Card(
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(18),
                          leading: const Icon(Icons.description_outlined, color: AppColors.gold),
                          title: Text(note['title'] ?? 'Untitled note', style: const TextStyle(fontWeight: FontWeight.w700)),
                          subtitle: Padding(padding: const EdgeInsets.only(top: 8), child: Text((note['body'] ?? '').isEmpty ? 'No text yet' : note['body']!, maxLines: 4, overflow: TextOverflow.ellipsis)),
                          onTap: () => _editNote(index),
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  Future<void> _editNote(int index) async {
    final titleController = TextEditingController(text: _notes[index]['title']);
    final bodyController = TextEditingController(text: _notes[index]['body']);
    final result = await showDialog<bool>(context: context, builder: (dialogContext) => AlertDialog(
      title: const Text('Edit note'),
      content: SizedBox(width: 520, child: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Title')),
        const SizedBox(height: 14),
        TextField(controller: bodyController, minLines: 6, maxLines: 12, decoration: const InputDecoration(labelText: 'Note', alignLabelWithHint: true)),
      ])),
      actions: [TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: const Text('Cancel')), FilledButton(onPressed: () => Navigator.pop(dialogContext, true), child: const Text('Save'))],
    ));
    if (result == true) {
      setState(() { _notes[index] = {'title': titleController.text.trim().isEmpty ? 'Untitled note' : titleController.text.trim(), 'body': bodyController.text.trim()}; });
      await _saveNotes();
    }
    titleController.dispose();
    bodyController.dispose();
  }
}
