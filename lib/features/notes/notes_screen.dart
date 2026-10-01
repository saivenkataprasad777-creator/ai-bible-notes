import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bible Notes')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.edit_note_rounded, color: AppColors.gold, size: 64),
              const SizedBox(height: 22),
              const Text('Your study notebook', style: TextStyle(color: AppColors.warmWhite, fontSize: 26, fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              const Text('Rich notes, Bible verse blocks, highlights, handwriting, folders and AI tools will be built here.', textAlign: TextAlign.center, style: TextStyle(color: AppColors.muted, height: 1.5)),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add_rounded),
                label: const Text('Create note'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
