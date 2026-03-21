import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../common/widgets/buttons/gradient_button.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  int _planIndex = 1; // yearly selected by default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              children: [
                // Gold gradient header
                Container(
                  height: 300,
                  decoration: const BoxDecoration(gradient: AppGradients.gold),
                ),
                SafeArea(
                  child: Column(
                    children: [
                      // Close button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(color: Colors.white30, shape: BoxShape.circle),
                                child: const Icon(Icons.close_rounded, color: Colors.white, size: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Icon(Icons.bolt_rounded, color: Colors.white, size: 60),
                      const SizedBox(height: 12),
                      Text('LoveAxis Gold', style: AppTextStyles.headlineLarge.copyWith(color: Colors.white)),
                      const SizedBox(height: 6),
                      Text('Unlock unlimited love & connections', style: AppTextStyles.bodyWhite),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Features
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('What you get with Gold', style: AppTextStyles.titleLarge),
                  const SizedBox(height: 16),
                  _feature(Icons.visibility_rounded, 'See Who Liked You', 'View all profiles that already liked you'),
                  _feature(Icons.replay_rounded, 'Unlimited Rewinds', 'Take back that accidental left swipe'),
                  _feature(Icons.location_searching_rounded, 'Change Location', 'Search in any city worldwide'),
                  _feature(Icons.bolt_rounded, 'Monthly Boost', 'Be a top profile for 30 minutes'),
                  _feature(Icons.star_rounded, '5 Super Likes/Day', 'Show you\'re extra interested'),
                  _feature(Icons.favorite_rounded, 'Unlimited Swipes', 'Never run out of likes'),

                  const SizedBox(height: 28),

                  // Plans
                  Row(
                    children: [
                      _plan(0, 'Monthly', '\$14.99', '/month', null),
                      const SizedBox(width: 12),
                      _plan(1, 'Yearly', '\$6.99', '/month', 'SAVE 53%'),
                    ],
                  ),

                  const SizedBox(height: 24),
                  GradientButton(
                    label: 'Start Gold – Free Trial',
                    gradient: AppGradients.gold,
                    onTap: () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Text(
                      '7-day free trial, then \$${_planIndex == 0 ? '14.99/month' : '83.99/year'}.\nCancel anytime.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.caption,
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _feature(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(gradient: AppGradients.gold, shape: BoxShape.circle),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.titleMedium),
                Text(subtitle, style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 22),
        ],
      ),
    );
  }

  Widget _plan(int index, String label, String price, String per, String? badge) {
    final selected = _planIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _planIndex = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: selected ? AppGradients.gold : null,
            color: selected ? null : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected ? Colors.transparent : AppColors.divider,
              width: 1.5,
            ),
            boxShadow: selected ? [BoxShadow(color: AppColors.premiumGold.withOpacity(0.3), blurRadius: 16)] : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (badge != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: selected ? Colors.white : AppColors.premiumGold,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(badge,
                      style: AppTextStyles.caption.copyWith(
                        color: selected ? AppColors.premiumGold : Colors.white,
                        fontWeight: FontWeight.w700,
                      )),
                ),
              if (badge != null) const SizedBox(height: 8),
              Text(label,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: selected ? Colors.white : AppColors.textPrimary,
                  )),
              const SizedBox(height: 4),
              Text(price,
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: selected ? Colors.white : AppColors.textPrimary,
                  )),
              Text(per,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: selected ? Colors.white70 : AppColors.textHint,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
