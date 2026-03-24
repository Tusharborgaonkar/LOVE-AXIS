import 'package:flutter/material.dart';

class OnboardingOptionTile extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final String? subtitle;
  final bool isSelected;
  final VoidCallback onTap;
  final Widget? trailing;
  final Color? selectedColor;

  const OnboardingOptionTile({
    super.key,
    this.title,
    this.titleWidget,
    this.subtitle,
    required this.isSelected,
    required this.onTap,
    this.trailing,
    this.selectedColor,
  }) : assert(title != null || titleWidget != null);

  @override
  Widget build(BuildContext context) {
    final activeColor = selectedColor ?? const Color(0xFFFFD700);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? activeColor : Colors.black.withOpacity(0.04),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   if (titleWidget != null)
                    titleWidget!
                  else
                    Text(
                      title ?? "",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 13,
                        color: isSelected ? Colors.black54 : Colors.black38,
                        height: 1.3,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: 12),
              trailing!,
            ] else ...[
              const SizedBox(width: 12),
              _buildDefaultIndicator(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultIndicator() {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? Colors.black87 : Colors.black12,
          width: 1.5,
        ),
        color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
      ),
      child: isSelected
          ? Center(
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black87,
                ),
              ),
            )
          : null,
    );
  }
}
