import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class AIAssistantScreen extends StatefulWidget {
  const AIAssistantScreen({super.key, this.initialQuestion});

  final String? initialQuestion;

  @override
  State<AIAssistantScreen> createState() => _AIAssistantScreenState();
}

class _AIAssistantScreenState extends State<AIAssistantScreen> {
  late final TextEditingController _controller;
  final List<_ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialQuestion ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(_ChatMessage(text: text, fromUser: true));
      _messages.add(const _ChatMessage(text: 'Your AI study screen is working. The secure AI backend still needs to be connected before I can generate live answers. Once the backend/API key is configured, this same chat will send your Bible questions to the AI service.', fromUser: false));
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ask AI')),
      body: Column(children: [
        Expanded(child: _messages.isEmpty
            ? ListView(padding: const EdgeInsets.all(20), children: [
                Container(padding: const EdgeInsets.all(22), decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.divider)), child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Icon(Icons.auto_awesome_rounded, color: AppColors.gold, size: 30),
                  SizedBox(height: 16),
                  Text('Study with AI', style: TextStyle(color: AppColors.warmWhite, fontSize: 24, fontWeight: FontWeight.w700)),
                  SizedBox(height: 8),
                  Text('Ask questions, explain passages, create study guides, prayers and sermon outlines.', style: TextStyle(color: AppColors.muted, height: 1.5)),
                ])),
                const SizedBox(height: 20),
                const Text('Try asking', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 10),
                Wrap(spacing: 8, runSpacing: 8, children: [
                  _PromptChip('Explain John 3:16'),
                  _PromptChip('Give me a study plan'),
                  _PromptChip('Summarize this chapter'),
                ].map((chip) => ActionChip(label: Text(chip.text), onPressed: () { _controller.text = chip.text; })).toList()),
              ])
            : ListView.builder(padding: const EdgeInsets.all(20), itemCount: _messages.length, itemBuilder: (_, index) => Align(alignment: _messages[index].fromUser ? Alignment.centerRight : Alignment.centerLeft, child: Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(15), constraints: const BoxConstraints(maxWidth: 700), decoration: BoxDecoration(color: _messages[index].fromUser ? AppColors.gold.withValues(alpha: 0.15) : AppColors.surface, borderRadius: BorderRadius.circular(18)), child: Text(_messages[index].text))))),
        SafeArea(child: Padding(padding: const EdgeInsets.fromLTRB(14, 8, 14, 14), child: Row(children: [
          Expanded(child: TextField(controller: _controller, onSubmitted: (_) => _send(), minLines: 1, maxLines: 5, decoration: const InputDecoration(hintText: 'Ask a Bible study question...', prefixIcon: Icon(Icons.auto_awesome_rounded)))),
          const SizedBox(width: 8),
          IconButton.filled(onPressed: _send, icon: const Icon(Icons.send_rounded)),
        ]))),
      ]),
    );
  }
}

class _ChatMessage {
  const _ChatMessage({required this.text, required this.fromUser});
  final String text;
  final bool fromUser;
}

class _PromptChip {
  const _PromptChip(this.text);
  final String text;
}
