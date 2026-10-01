import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _scale = Tween<double>(begin: 0.86, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    Timer(const Duration(milliseconds: 2200), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        PageRouteBuilder<void>(
          pageBuilder: (pageContext, animation, secondaryAnimation) => const HomeScreen(),
          transitionDuration: const Duration(milliseconds: 550),
          transitionsBuilder: (pageContext, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fade,
              child: ScaleTransition(scale: _scale, child: child),
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              _BiblePenMark(),
              SizedBox(height: 28),
              Text(
                'AI Bible Notes',
                style: TextStyle(
                  color: AppColors.warmWhite,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Read • Study • Write • Grow',
                style: TextStyle(
                  color: AppColors.goldLight,
                  fontSize: 14,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BiblePenMark extends StatelessWidget {
  const _BiblePenMark();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 112,
      height: 112,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.gold, width: 1.5),
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.gold.withValues(alpha: 0.14),
            blurRadius: 30,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(Icons.menu_book_rounded, size: 58, color: AppColors.gold),
          Positioned(
            right: 19,
            bottom: 24,
            child: Transform.rotate(
              angle: -0.55,
              child: const Icon(
                Icons.edit_rounded,
                size: 30,
                color: AppColors.warmWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
