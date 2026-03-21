import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/routes/route_names.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;
  bool _locationServices = true;
  bool _showOnline = true;
  bool _readReceipts = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          _section('Account', [
            _tile(Icons.person_outline_rounded, 'Edit Profile', () => Navigator.pushNamed(context, RouteNames.editProfile)),
            _tile(Icons.notifications_none_rounded, 'Notifications', () => Navigator.pushNamed(context, RouteNames.notifications)),
            _tile(Icons.shield_outlined, 'Privacy & Safety', () {}),
            _tile(Icons.block_rounded, 'Blocked Users', () {}),
          ]),
          _section('Discovery', [
            _toggleTile(Icons.location_on_outlined, 'Location Services', _locationServices, (v) => setState(() => _locationServices = v)),
            _toggleTile(Icons.visibility_outlined, 'Show Me Online', _showOnline, (v) => setState(() => _showOnline = v)),
          ]),
          _section('Notifications', [
            _toggleTile(Icons.notifications_active_outlined, 'Push Notifications', _notifications, (v) => setState(() => _notifications = v)),
            _toggleTile(Icons.done_all_rounded, 'Read Receipts', _readReceipts, (v) => setState(() => _readReceipts = v)),
          ]),
          _section('Premium', [
            _tile(Icons.bolt_rounded, 'Upgrade to Gold', () => Navigator.pushNamed(context, RouteNames.premium), gradient: AppGradients.gold),
            _tile(Icons.restore_rounded, 'Restore Purchases', () {}),
          ]),
          _section('Support', [
            _tile(Icons.help_outline_rounded, 'Help & Support', () {}),
            _tile(Icons.feedback_outlined, 'Send Feedback', () {}),
            _tile(Icons.info_outline_rounded, 'About LoveAxis', () {}),
          ]),
          const SizedBox(height: 20),
          // Logout
          GestureDetector(
            onTap: () => Navigator.pushNamedAndRemoveUntil(context, RouteNames.login, (_) => false),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.error.withOpacity(0.3)),
              ),
              child: Center(
                child: Text('Log Out', style: AppTextStyles.titleMedium.copyWith(color: AppColors.error)),
              ),
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _section(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, top: 20, bottom: 8),
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

  Widget _tile(IconData icon, String label, VoidCallback onTap, {Gradient? gradient}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            gradient != null
                ? Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(gradient: gradient, shape: BoxShape.circle),
                    child: Icon(icon, color: Colors.white, size: 16),
                  )
                : Icon(icon, color: AppColors.primary, size: 22),
            const SizedBox(width: 14),
            Expanded(child: Text(label, style: AppTextStyles.titleMedium)),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textHint, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _toggleTile(IconData icon, String label, bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 22),
          const SizedBox(width: 14),
          Expanded(child: Text(label, style: AppTextStyles.titleMedium)),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
