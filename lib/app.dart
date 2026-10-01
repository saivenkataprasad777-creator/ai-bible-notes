import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/home/home_screen.dart';
import 'features/splash/splash_screen.dart';

class AIBibleNotesApp extends StatelessWidget {
  const AIBibleNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Bible Notes',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      home: const SplashScreen(),
    );
  }
}
