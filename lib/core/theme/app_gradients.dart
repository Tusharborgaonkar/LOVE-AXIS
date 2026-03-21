import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppGradients {
  // Primary rose-pink gradient
  static const LinearGradient primary = LinearGradient(
    colors: [Color(0xFFFF6B8A), Color(0xFFFF8FA3)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Pink to lavender
  static const LinearGradient pinkToLavender = LinearGradient(
    colors: [Color(0xFFFF6B8A), Color(0xFFC9B8FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Lavender to peach
  static const LinearGradient lavenderToPeach = LinearGradient(
    colors: [Color(0xFFC9B8FF), Color(0xFFFFB347)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Warm peach
  static const LinearGradient peach = LinearGradient(
    colors: [Color(0xFFFFB347), Color(0xFFFF6B8A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Background gradient – ivory
  static const LinearGradient background = LinearGradient(
    colors: [Color(0xFFFFF4F7), Color(0xFFFEF0FF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Card overlay (bottom of profile card)
  static const LinearGradient cardOverlay = LinearGradient(
    colors: [Colors.transparent, Color(0xCC000000)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Premium gold
  static const LinearGradient gold = LinearGradient(
    colors: [Color(0xFFFFAA00), Color(0xFFFFD700)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Soft pink glass effect
  static const LinearGradient glass = LinearGradient(
    colors: [Color(0x30FFFFFF), Color(0x10FFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Vertical pink for splash / hero
  static const LinearGradient splash = LinearGradient(
    colors: [Color(0xFFFFF0F4), Color(0xFFFFE0EA), Color(0xFFF5D5F5)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Shimmer
  static LinearGradient shimmer = LinearGradient(
    colors: [
      AppColors.shimmerBase,
      AppColors.shimmerHighlight,
      AppColors.shimmerBase,
    ],
    stops: const [0.0, 0.5, 1.0],
    begin: const Alignment(-1, -0.3),
    end: const Alignment(1, 0.3),
  );
}
