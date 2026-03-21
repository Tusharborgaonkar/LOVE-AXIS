import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../common/widgets/buttons/gradient_button.dart';
import '../../../../common/widgets/inputs/custom_text_field.dart';
import '../../../../common/widgets/effects/animated_fade_slide.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendResetLink() {
    // Show a success snackbar for demonstration
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Reset link sent to your email! ✨'),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // Background blobs
          Positioned(
            top: -50,
            right: -30,
            child: _blob(180, AppColors.primaryLight.withOpacity(0.2)),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  AnimatedFadeSlide(
                    child: Text('Reset\nPassword 🔐', style: AppTextStyles.displayMedium),
                  ),
                  const SizedBox(height: 12),
                  AnimatedFadeSlide(
                    delay: const Duration(milliseconds: 100),
                    child: Text(
                      'Enter your email address and we\'ll send you a link to reset your password.',
                      style: AppTextStyles.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: 48),
                  AnimatedFadeSlide(
                    delay: const Duration(milliseconds: 200),
                    child: CustomTextField(
                      controller: _emailController,
                      hint: 'Email address',
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.mail_outline_rounded, color: AppColors.textHint),
                    ),
                  ),
                  const SizedBox(height: 32),
                  AnimatedFadeSlide(
                    delay: const Duration(milliseconds: 300),
                    child: GradientButton(
                      label: 'Send Reset Link 📧',
                      onTap: () {
                        if (_emailController.text.isNotEmpty) {
                          _sendResetLink();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
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
