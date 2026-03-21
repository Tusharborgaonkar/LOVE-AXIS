import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../common/widgets/buttons/gradient_button.dart';
import '../../../../common/widgets/inputs/custom_text_field.dart';
import '../../../../common/widgets/effects/animated_fade_slide.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              children: [
                // Header gradient
                Container(
                  height: 260,
                  decoration: const BoxDecoration(gradient: AppGradients.pinkToLavender),
                ),
                SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('My Profile', style: AppTextStyles.headlineSmall.copyWith(color: Colors.white)),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(context, RouteNames.settings),
                              child: const Icon(Icons.settings_outlined, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Profile avatar
                      Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                              boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 20)],
                              image: const DecorationImage(
                                image: NetworkImage('https://images.unsplash.com/photo-1527980965255-d3b416303d12?w=200'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                gradient: AppGradients.primary,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 14),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text('Alex Johnson, 25', style: AppTextStyles.headlineSmall.copyWith(color: Colors.white)),
                      const SizedBox(height: 4),
                      Text('Mumbai, India', style: AppTextStyles.bodyWhite),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Stats row
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: AppColors.shadow.withOpacity(0.1), blurRadius: 16)],
              ),
              child: Row(
                children: [
                  _statBadge('28', 'Likes'),
                  _divider(),
                  _statBadge('12', 'Matches'),
                  _divider(),
                  _statBadge('94%', 'Complete'),
                ],
              ),
            ),
          ),

          // Edit profile section
          SliverToBoxAdapter(
            child: AnimatedFadeSlide(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Profile Info', style: AppTextStyles.titleLarge),
                    const SizedBox(height: 16),
                    _fieldRow(Icons.person_outline_rounded, 'Name', 'Alex Johnson'),
                    _fieldRow(Icons.cake_outlined, 'Birthday', 'March 15, 2000'),
                    _fieldRow(Icons.work_outline_rounded, 'Job', 'Product Designer'),
                    _fieldRow(Icons.school_outlined, 'Education', 'IIT Bombay'),
                    _fieldRow(Icons.location_on_outlined, 'Location', 'Mumbai, India'),
                    _fieldRow(Icons.favorite_outline_rounded, 'Looking For', 'Relationship'),
                    const SizedBox(height: 24),
                    Text('About Me', style: AppTextStyles.titleLarge),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'Adventure seeker 🌍 | Coffee lover ☕ | Design enthusiast 🎨. Looking for someone who matches my energy and loves exploring new places.',
                        style: AppTextStyles.bodyMedium.copyWith(height: 1.6),
                      ),
                    ),
                    const SizedBox(height: 24),
                    GradientButton(
                      label: 'Edit Profile ✏️',
                      onTap: () => Navigator.pushNamed(context, RouteNames.editProfile),
                    ),
                    const SizedBox(height: 12),
                    GradientButton(
                      label: '✨ Upgrade to Gold',
                      onTap: () => Navigator.pushNamed(context, RouteNames.premium),
                      gradient: AppGradients.gold,
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statBadge(String value, String label) {
    return Expanded(
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (b) => AppGradients.primary.createShader(b),
            child: Text(value, style: AppTextStyles.headlineMedium.copyWith(color: Colors.white)),
          ),
          const SizedBox(height: 2),
          Text(label, style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(width: 1, height: 40, color: AppColors.divider);
  }

  Widget _fieldRow(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: AppColors.shadow.withOpacity(0.06), blurRadius: 8)],
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Text('$label: ', style: AppTextStyles.labelMedium),
          Expanded(child: Text(value, style: AppTextStyles.titleMedium)),
          const Icon(Icons.chevron_right_rounded, color: AppColors.textHint, size: 20),
        ],
      ),
    );
  }
}
