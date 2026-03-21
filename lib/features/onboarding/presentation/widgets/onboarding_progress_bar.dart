import 'package:flutter/material.dart';

class OnboardingProgressBar extends StatelessWidget {
  final double value;

  const OnboardingProgressBar({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(2),
      child: LinearProgressIndicator(
        value: value,
        backgroundColor: Colors.black.withOpacity(0.05),
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.black54),
        minHeight: 4,
      ),
    );
  }
}
