import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../common/widgets/buttons/gradient_button.dart';
import '../../../../common/widgets/inputs/custom_text_field.dart';
import '../../../../common/widgets/effects/animated_fade_slide.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background blobs
          Positioned(
            top: -80,
            right: -60,
            child: _blob(200, AppColors.primaryLight.withOpacity(0.35)),
          ),
          Positioned(
            top: 120,
            left: -80,
            child: _blob(160, AppColors.secondaryLight.withOpacity(0.3)),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 48),
                  AnimatedFadeSlide(
                    child: Center(
                      child: Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          gradient: AppGradients.primary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.favorite_rounded, color: Colors.white, size: 36),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  AnimatedFadeSlide(
                    delay: const Duration(milliseconds: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Welcome\nBack 👋', style: AppTextStyles.displayMedium),
                        const SizedBox(height: 8),
                        Text('Sign in to continue your journey', style: AppTextStyles.bodyMedium),
                      ],
                    ),
                  ),
                  const SizedBox(height: 36),
                  AnimatedFadeSlide(
                    delay: const Duration(milliseconds: 200),
                    child: Column(
                      children: [
                        CustomTextField(
                          hint: 'Email address',
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: const Icon(Icons.mail_outline_rounded, color: AppColors.textHint),
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          hint: 'Password',
                          obscureText: true,
                          prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.textHint),
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text('Forgot Password?', style: AppTextStyles.bodyPrimary),
                        ),
                        const SizedBox(height: 28),
                        GradientButton(
                          label: 'Sign In ✨',
                          onTap: () => Navigator.pushReplacementNamed(context, RouteNames.main),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            const Expanded(child: Divider()),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text('or continue with', style: AppTextStyles.bodyMedium),
                            ),
                            const Expanded(child: Divider()),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(child: _socialButton('Google', Icons.g_mobiledata_rounded, Colors.red)),
                            const SizedBox(width: 16),
                            Expanded(child: _socialButton('Apple', Icons.apple_rounded, Colors.black87)),
                          ],
                        ),
                        const SizedBox(height: 32),
                        Center(
                          child: GestureDetector(
                            onTap: () => Navigator.pushNamed(context, RouteNames.signup),
                            child: RichText(
                              text: TextSpan(
                                text: "Don't have an account? ",
                                style: AppTextStyles.bodyMedium,
                                children: [
                                  TextSpan(
                                    text: 'Sign Up',
                                    style: AppTextStyles.bodyPrimary.copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialButton(String label, IconData icon, Color color) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 8),
          Text(label, style: AppTextStyles.labelLarge),
        ],
      ),
    );
  }

  Widget _blob(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
