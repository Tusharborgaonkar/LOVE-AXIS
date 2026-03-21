import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_text_styles.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('About LoveAxis', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHero(),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _section('Our Mission', 'At LoveAxis, we believe that everyone deserves a premium dating experience. Our mission is to connect people through meaningful interactions and data-driven matching.'),
                  const SizedBox(height: 32),
                  _section('Version', '1.0.0 (Build 124)'),
                  const SizedBox(height: 32),
                  _buildLegalLinks(),
                  const SizedBox(height: 48),
                  _buildFooter(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHero() {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: const BoxDecoration(
        gradient: AppGradients.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.favorite_rounded, color: Colors.white, size: 60),
          ),
          const SizedBox(height: 16),
          Text('LoveAxis', style: AppTextStyles.headlineLarge.copyWith(color: Colors.white, letterSpacing: 1.2)),
          Text('Connect with Heart', style: AppTextStyles.bodyWhite.copyWith(color: Colors.white.withOpacity(0.8))),
        ],
      ),
    );
  }

  Widget _section(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.titleLarge),
        const SizedBox(height: 12),
        Text(content, style: AppTextStyles.bodyMedium.copyWith(height: 1.5, color: AppColors.textSecondary)),
      ],
    );
  }

  Widget _buildLegalLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Legal', style: AppTextStyles.titleLarge),
        const SizedBox(height: 8),
        _legalLink('Terms of Service', () {}),
        _legalLink('Privacy Policy', () {}),
        _legalLink('Safety Tips', () {}),
        _legalLink('Cookie Policy', () {}),
      ],
    );
  }

  Widget _legalLink(String label, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,
      title: Text(label, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600)),
      trailing: const Icon(Icons.open_in_new_rounded, size: 16, color: AppColors.primary),
      contentPadding: EdgeInsets.zero,
      dense: true,
    );
  }

  Widget _buildFooter() {
    return Center(
      child: Column(
        children: [
          Text('Made with ❤️ in Mumbai', style: AppTextStyles.caption),
          const SizedBox(height: 8),
          Text('© 2026 LoveAxis Inc.', style: AppTextStyles.caption.copyWith(fontSize: 10)),
        ],
      ),
    );
  }
}
