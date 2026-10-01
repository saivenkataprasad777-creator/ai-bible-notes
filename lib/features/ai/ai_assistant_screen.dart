import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class AIAssistantScreen extends StatelessWidget {
  const AIAssistantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Assistant')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.divider),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.auto_awesome_rounded, color: AppColors.gold, size: 30),
                SizedBox(height: 16),
                Text('Study with AI', style: TextStyle(color: AppColors.warmWhite, fontSize: 24, fontWeight: FontWeight.w700)),
                SizedBox(height: 8),
                Text('Ask questions, explain passages, create study guides, prayers and sermon outlines. The secure AI service will be connected after the foundation is tested.', style: TextStyle(color: AppColors.muted, height: 1.5)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            decoration: InputDecoration(
              hintText: 'Ask a Bible study question...',
              prefixIcon: const Icon(Icons.search_rounded),
              suffixIcon: IconButton(onPressed: () {}, icon: const Icon(Icons.mic_none_rounded)),
            ),
          ),
        ],
      ),
    );
  }
}
