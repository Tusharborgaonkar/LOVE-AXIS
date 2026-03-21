import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Help & Support'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSearchBox(),
          const SizedBox(height: 24),
          _sectionTitle('Frequently Asked Questions'),
          _buildFAQ('How do I change my location?', 'You can change your location in the Discovery settings by toggling location services or manually setting a new city if you have a premium subscription.'),
          _buildFAQ('Is my data safe?', 'Yes, we use industry-standard encryption to protect your data. Check our Privacy Policy for more details.'),
          _buildFAQ('How to reset my matches?', 'Matches cannot be reset manually, but you can always unmatch someone by going to their profile in your match list.'),
          _buildFAQ('Can I hide my profile?', 'Yes, go to Privacy & Safety settings and enable "Incognito Mode" or "Hide My Profile".'),
          const SizedBox(height: 32),
          _buildContactCard(),
        ],
      ),
    );
  }

  Widget _buildSearchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: AppColors.shadow.withOpacity(0.05), blurRadius: 10)],
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Search for help...',
          border: InputBorder.none,
          icon: Icon(Icons.search_rounded, color: AppColors.textHint),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(title, style: AppTextStyles.titleLarge),
    );
  }

  Widget _buildFAQ(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: AppColors.shadow.withOpacity(0.05), blurRadius: 10)],
      ),
      child: ExpansionTile(
        title: Text(question, style: AppTextStyles.titleMedium),
        shape: const RoundedRectangleBorder(side: BorderSide.none),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(answer, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          const Icon(Icons.support_agent_rounded, color: Colors.white, size: 48),
          const SizedBox(height: 16),
          Text('Still need help?', style: AppTextStyles.headlineSmall.copyWith(color: Colors.white)),
          const SizedBox(height: 8),
          Text(
            'Our support team is available 24/7 to assist you with any issues.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(color: Colors.white.withOpacity(0.9)),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: const Text('Contact Us', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
