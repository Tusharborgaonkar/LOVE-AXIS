import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../data/models/profile_model.dart';
import '../../../../common/widgets/buttons/gradient_button.dart';
import '../../../../common/widgets/common/app_network_image.dart';
import '../../../../common/widgets/effects/animated_fade_slide.dart';

class ProfileDetailScreen extends StatefulWidget {
  final ProfileModel profile;
  const ProfileDetailScreen({super.key, required this.profile});

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  int _imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final profile = widget.profile;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Image header
          SliverToBoxAdapter(
            child: SizedBox(
              height: 480,
              child: Stack(
                children: [
                  // Images
                  GestureDetector(
                    onTapUp: (d) {
                      final x = d.localPosition.dx;
                      final w = MediaQuery.of(context).size.width;
                      setState(() {
                        if (x > w / 2 && _imageIndex < profile.imageUrls.length - 1) _imageIndex++;
                        else if (x < w / 2 && _imageIndex > 0) _imageIndex--;
                      });
                    },
                    child: AppNetworkImage(
                      url: profile.imageUrls[_imageIndex],
                      width: double.infinity,
                      height: 480,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Image indicators
                  Positioned(
                    top: 52,
                    left: 16,
                    right: 16,
                    child: Row(
                      children: List.generate(profile.imageUrls.length, (i) => Expanded(
                        child: Container(
                          height: 3,
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            color: i == _imageIndex ? Colors.white : Colors.white38,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      )),
                    ),
                  ),

                  // Gradient overlay
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: const BoxDecoration(gradient: AppGradients.cardOverlay),
                    ),
                  ),

                  // Back button
                  Positioned(
                    top: 16,
                    left: 16,
                    child: SafeArea(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
                        ),
                      ),
                    ),
                  ),

                  // Profile name at bottom
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(profile.displayName, style: AppTextStyles.headlineLarge.copyWith(color: Colors.white)),
                            const SizedBox(width: 8),
                            if (profile.isVerified)
                              const Icon(Icons.verified_rounded, color: Colors.white, size: 22),
                            const Spacer(),
                            if (profile.isOnline)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.online.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text('Online', style: AppTextStyles.caption.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
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
                            Text('·', style: AppTextStyles.bodyWhite),
                            const SizedBox(width: 8),
                            Text(profile.distanceText, style: AppTextStyles.bodyWhite.copyWith(fontSize: 13)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Body content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [                  // Quick stats
                  AnimatedFadeSlide(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: _stat(Icons.work_outline_rounded, profile.job)),
                        Expanded(child: _stat(Icons.school_outlined, profile.education)),
                        Expanded(child: _stat(Icons.height_rounded, profile.height)),
                        Expanded(child: _stat(Icons.auto_awesome, profile.zodiac)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Divider(color: AppColors.divider.withOpacity(0.5)),
                  const SizedBox(height: 16),

                  // Bio
                  AnimatedFadeSlide(
                    delay: const Duration(milliseconds: 80),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('About Me', style: AppTextStyles.titleLarge),
                        const SizedBox(height: 12),
                        Text(
                          profile.bio,
                          style: AppTextStyles.bodyMedium.copyWith(
                            height: 1.6,
                            color: AppColors.textPrimary.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Interests
                  AnimatedFadeSlide(
                    delay: const Duration(milliseconds: 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Interests', style: AppTextStyles.titleLarge),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: profile.interests.map((i) => _InterestChip(label: i)).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Remaining Photos (Show all photos vertically)
                  ...profile.imageUrls.skip(1).map((url) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: AppNetworkImage(
                        url: url,
                        width: double.infinity,
                        height: 400,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )).toList(),
                  
                  const SizedBox(height: 24),

                  // CTA buttons
                  AnimatedFadeSlide(
                    delay: const Duration(milliseconds: 160),
                    child: Row(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: AppColors.error.withOpacity(0.2)),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.error.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              )
                            ],
                          ),
                          child: const Icon(Icons.close_rounded, color: AppColors.error, size: 28),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GradientButton(
                            label: 'Send Like 💕',
                            onTap: () => Navigator.pushNamed(context, RouteNames.chatDetail, arguments: null),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: AppGradients.primary,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              )
                            ],
                          ),
                          child: const Icon(Icons.star_rounded, color: Colors.white, size: 28),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat(IconData icon, String label) {
    if (label.isEmpty) return const SizedBox();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.primary.withOpacity(0.7), size: 22),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textHint,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _InterestChip extends StatelessWidget {
  final String label;
  const _InterestChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.divider),
      ),
      child: Text(label, style: AppTextStyles.labelMedium),
    );
  }
}
