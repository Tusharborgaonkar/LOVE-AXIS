import 'package:flutter/material.dart';

class OnboardingNextButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool enabled;

  const OnboardingNextButton({
    super.key,
    required this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: enabled ? const Color(0xFF333333) : Colors.black.withOpacity(0.05),
        ),
        child: Icon(
          Icons.arrow_forward_ios_rounded,
          color: enabled ? Colors.white : Colors.black26,
          size: 20,
        ),
      ),
    );
  }
}
