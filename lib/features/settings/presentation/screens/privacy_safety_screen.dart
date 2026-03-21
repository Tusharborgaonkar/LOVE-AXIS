import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class PrivacySafetyScreen extends StatefulWidget {
  const PrivacySafetyScreen({super.key});

  @override
  State<PrivacySafetyScreen> createState() => _PrivacySafetyScreenState();
}

class _PrivacySafetyScreenState extends State<PrivacySafetyScreen> {
  bool _privateProfile = false;
  bool _hideAge = false;
  bool _hideDistance = false;
  bool _incognitoMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Privacy & Safety'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _section('Profile Visibility', [
            _toggleTile(Icons.lock_outline_rounded, 'Private Profile', 'Only people you like can see you', _privateProfile, (v) => setState(() => _privateProfile = v)),
            _toggleTile(Icons.person_off_outlined, 'Hide My Age', 'Age will be hidden from your profile', _hideAge, (v) => setState(() => _hideAge = v)),
            _toggleTile(Icons.location_off_outlined, 'Hide My Distance', 'Distance won\'t be shown to matches', _hideDistance, (v) => setState(() => _hideDistance = v)),
          ]),
          const SizedBox(height: 24),
          _section('Safety Features', [
            _toggleTile(Icons.security_rounded, 'Incognito Mode', 'Hide your profile from everyone except people you like', _incognitoMode, (v) => setState(() => _incognitoMode = v)),
            _tile(Icons.verified_user_outlined, 'Face Verification', () {}),
          ]),
          const SizedBox(height: 24),
          _section('Security', [
            _tile(Icons.password_rounded, 'Change Password', () {}),
            _tile(Icons.phonelink_lock_rounded, 'Two-Factor Authentication', () {}),
          ]),
          const SizedBox(height: 40),
          _buildInfoBox(),
        ],
      ),
    );
  }

  Widget _section(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(title.toUpperCase(), style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w700, letterSpacing: 1)),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: AppColors.shadow.withOpacity(0.07), blurRadius: 10)],
          ),
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _tile(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: AppColors.primary),
      title: Text(label, style: AppTextStyles.titleMedium),
      trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textHint),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }

  Widget _toggleTile(IconData icon, String label, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 24),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.titleMedium),
                Text(subtitle, style: AppTextStyles.caption),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Your safety is our priority. Read our Safety Tips for more information.',
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
