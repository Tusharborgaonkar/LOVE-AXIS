import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_text_styles.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('About LoveAxis'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary.withOpacity(0.05), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: kToolbarHeight + 60),
              _buildAnimatedLogo(),
              const SizedBox(height: 24),
              Text('LoveAxis', style: AppTextStyles.headlineMedium.copyWith(letterSpacing: 1.2)),
              Text('Version 1.0.0 (Build 124)', style: AppTextStyles.caption.copyWith(letterSpacing: 0.5)),
              const SizedBox(height: 48),
              _buildInfoCard(),
              const SizedBox(height: 32),
              _buildLegalLinks(),
              const SizedBox(height: 64),
              _buildFooter(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedLogo() {
    return ScaleTransition(
      scale: _pulseAnimation,
      child: Container(
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.15),
              blurRadius: 30,
              spreadRadius: 5,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Center(
          child: ShaderMask(
            shaderCallback: (bounds) => AppGradients.primary.createShader(bounds),
            child: const Icon(Icons.favorite_rounded, color: Colors.white, size: 72),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.06),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Column(
          children: [
            _infoRow(
              Icons.rocket_launch_rounded,
              'What\'s New',
              'Explore the latest features and performance improvements in this version.',
              AppColors.primary,
            ),
            _divider(),
            _infoRow(
              Icons.bolt_rounded,
              'System Status',
              'All systems operational. We\'re committed to 99.9% uptime.',
              Colors.orange,
            ),
            _divider(),
            _infoRow(
              Icons.code_rounded,
              'Developer',
              'Designed & Developed with Love by Tushar Borgaonkar.',
              Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() => Divider(height: 1, color: AppColors.divider.withOpacity(0.5), indent: 70);

  Widget _infoRow(IconData icon, String title, String subtitle, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.titleMedium),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegalLinks() {
    return Column(
      children: [
        _legalLink(Icons.privacy_tip_outlined, 'Privacy Policy', () {}),
        _legalLink(Icons.description_outlined, 'Terms of Service', () {}),
        _legalLink(Icons.gavel_rounded, 'Community Guidelines', () {}),
        _legalLink(Icons.assignment_turned_in_outlined, 'Licenses', () {}),
      ],
    );
  }

  Widget _legalLink(IconData icon, String label, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, size: 22, color: AppColors.textPrimary.withOpacity(0.7)),
        title: Text(label, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textHint),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        hoverColor: AppColors.primary.withOpacity(0.05),
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Made with ', style: AppTextStyles.caption),
            const Icon(Icons.favorite_rounded, color: AppColors.primary, size: 14),
            Text(' for meaningful connections', style: AppTextStyles.caption),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          '© 2026 LoveAxis Inc. All rights reserved.',
          style: AppTextStyles.caption.copyWith(fontSize: 10, letterSpacing: 0.5),
        ),
      ],
    );
  }
}
