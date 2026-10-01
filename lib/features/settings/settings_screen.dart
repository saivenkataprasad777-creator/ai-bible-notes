import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const _SectionTitle('Preferences'),
          _SettingTile(icon: Icons.dark_mode_outlined, title: 'Appearance', subtitle: 'Dark premium theme'),
          _SettingTile(icon: Icons.translate_rounded, title: 'Language', subtitle: 'App and Bible language settings'),
          _SettingTile(icon: Icons.menu_book_outlined, title: 'Bible translation', subtitle: 'Choose your preferred translation'),
          const SizedBox(height: 18),
          const _SectionTitle('AI Bible Notes'),
          _SettingTile(icon: Icons.auto_awesome_outlined, title: 'AI settings', subtitle: 'AI study and sermon preferences'),
          _SettingTile(icon: Icons.notifications_none_rounded, title: 'Notifications', subtitle: 'Daily verse and study reminders'),
          _SettingTile(icon: Icons.lock_outline_rounded, title: 'Privacy & security', subtitle: 'Your account and note security'),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(text.toUpperCase(), style: const TextStyle(color: AppColors.gold, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1.4)),
      );
}

class _SettingTile extends StatelessWidget {
  const _SettingTile({required this.icon, required this.title, required this.subtitle});
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.only(bottom: 10),
        child: ListTile(
          leading: Icon(icon, color: AppColors.gold),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.chevron_right_rounded),
        ),
      );
}
