import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../data/dummy/dummy_matches.dart';
import '../../../../common/widgets/common/app_network_image.dart';

class LikesScreen extends StatelessWidget {
  const LikesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  Expanded(child: Text('Who Liked You 💖', style: AppTextStyles.headlineLarge)),
                  // Premium upsell
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, RouteNames.premium),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: AppGradients.gold,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.bolt_rounded, color: Colors.white, size: 14),
                          const SizedBox(width: 4),
                          Text('Gold', style: AppTextStyles.caption.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '${dummyLikes.length} people liked your profile',
                style: AppTextStyles.bodyMedium,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemCount: dummyLikes.length,
                itemBuilder: (_, i) {
                  final profile = dummyLikes[i];
                  final isBlurred = i >= 2; // Only first 2 visible for free users
                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      RouteNames.profileDetail,
                      arguments: profile,
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: AppNetworkImage(url: profile.primaryImage, fit: BoxFit.cover),
                        ),
                        // Gradient overlay
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                colors: [Colors.transparent, Colors.black.withOpacity(0.55)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ),
                        // Blur for premium
                        if (isBlurred)
                          Positioned.fill(
                            child: GestureDetector(
                              onTap: () => Navigator.pushNamed(context, RouteNames.premium),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  color: Colors.white.withOpacity(0.65),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          gradient: AppGradients.gold,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.lock_rounded, color: Colors.white, size: 24),
                                      ),
                                      const SizedBox(height: 8),
                                      Text('Upgrade to see', style: AppTextStyles.labelMedium, textAlign: TextAlign.center),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        // Name
                        Positioned(
                          bottom: 12,
                          left: 12,
                          right: 12,
                          child: Text(
                            profile.displayName,
                            style: AppTextStyles.titleMedium.copyWith(color: Colors.white),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
