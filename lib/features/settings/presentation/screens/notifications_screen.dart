import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  static const _notifications = [
    _NotifData('💕 Sophia liked your photo!', 'Tap to see her profile', '2m ago', AppColors.primary),
    _NotifData('🔥 You have a new match!', 'Luna matched with you', '15m ago', AppColors.secondary),
    _NotifData('💬 New message from Aria', '"Hey! I saw you love hiking..."', '1h ago', AppColors.primary),
    _NotifData('⭐ Zara Super Liked you!', 'She thinks you\'re special', '3h ago', Color(0xFF00B4D8)),
    _NotifData('🎉 Your profile got 5 new likes!', 'People are noticing you', '5h ago', AppColors.accent),
    _NotifData('💕 Maya liked your profile!', 'Tap to see her profile', '1d ago', AppColors.primary),
    _NotifData('🔓 Your Boost ended', 'You got 12 extra views!', '2d ago', Color(0xFFFFAA00)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Notifications'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Clear all', style: AppTextStyles.bodyPrimary),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: _notifications.length,
        itemBuilder: (_, i) {
          final notif = _notifications[i];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: AppColors.shadow.withOpacity(0.07), blurRadius: 10)],
            ),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: notif.color.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(notif.title.substring(0, 2), style: const TextStyle(fontSize: 22)),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notif.title.substring(3), style: AppTextStyles.titleMedium),
                      const SizedBox(height: 2),
                      Text(notif.subtitle, style: AppTextStyles.bodySmall),
                    ],
                  ),
                ),
                Text(notif.time, style: AppTextStyles.caption),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _NotifData {
  final String title;
  final String subtitle;
  final String time;
  final Color color;

  const _NotifData(this.title, this.subtitle, this.time, this.color);
}
