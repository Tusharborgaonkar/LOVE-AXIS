import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_gradients.dart';
import '../../../core/theme/app_text_styles.dart';
import '../common/app_network_image.dart';
import '../../../data/models/profile_model.dart';

class ProfileCard extends StatelessWidget {
  final ProfileModel profile;

  const ProfileCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.2),
            blurRadius: 32,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Profile image
            AppNetworkImage(url: profile.primaryImage, fit: BoxFit.cover),

            // Gradient overlay
            Positioned.fill(
              child: DecoratedBox(
                decoration: const BoxDecoration(gradient: AppGradients.cardOverlay),
              ),
            ),

            // Compatibility badge
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  gradient: AppGradients.pinkToLavender,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.favorite, color: Colors.white, size: 12),
                    const SizedBox(width: 4),
                    Text(
                      '${profile.compatibilityScore}% Match',
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Verified badge
            if (profile.isVerified)
              const Positioned(
                top: 16,
                left: 16,
                child: Icon(Icons.verified_rounded, color: Colors.white, size: 26),
              ),

            // Profile info
            Positioned(
              left: 20,
              right: 20,
              bottom: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(profile.displayName, style: AppTextStyles.headlineLarge.copyWith(color: Colors.white)),
                      const SizedBox(width: 8),
                      if (profile.isOnline)
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: AppColors.online,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.place_outlined, color: Colors.white70, size: 14),
                      const SizedBox(width: 4),
                      Text(profile.location, style: AppTextStyles.bodyWhite.copyWith(fontSize: 13)),
                      const SizedBox(width: 8),
                      const Icon(Icons.circle, color: Colors.white38, size: 4),
                      const SizedBox(width: 8),
                      Text(profile.distanceText, style: AppTextStyles.bodyWhite.copyWith(fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (profile.job.isNotEmpty)
                    Row(
                      children: [
                        const Icon(Icons.work_outline_rounded, color: Colors.white70, size: 14),
                        const SizedBox(width: 4),
                        Text(profile.job, style: AppTextStyles.bodyWhite.copyWith(fontSize: 13)),
                      ],
                    ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: profile.interests.take(4).map((interest) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: Colors.white38),
                        ),
                        child: Text(interest,
                            style: AppTextStyles.caption.copyWith(color: Colors.white)),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MatchCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final bool hasUnread;
  final VoidCallback? onTap;

  const MatchCard({
    super.key,
    required this.name,
    required this.imageUrl,
    this.hasUnread = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppGradients.pinkToLavender,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.5),
                  child: CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: AppNetworkImage(url: imageUrl, width: 60, height: 60),
                    ),
                  ),
                ),
              ),
              if (hasUnread)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(name,
              style: AppTextStyles.labelMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
