import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../data/dummy/dummy_chats.dart';
import '../../../../common/widgets/effects/animated_fade_slide.dart';
import '../../../../common/widgets/inputs/custom_text_field.dart';
import '../../../../common/widgets/common/app_network_image.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Messages 💬', style: AppTextStyles.headlineLarge),
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [BoxShadow(color: AppColors.shadow.withOpacity(0.1), blurRadius: 12)],
                        ),
                        child: const Icon(Icons.edit_outlined, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const SearchField(hint: 'Search messages...'),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: dummyChats.length,
                itemBuilder: (_, i) {
                  final chat = dummyChats[i];
                  return AnimatedFadeSlide(
                    delay: Duration(milliseconds: i * 60),
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        RouteNames.chatDetail,
                        arguments: chat,
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(color: AppColors.shadow.withOpacity(0.07), blurRadius: 10, offset: const Offset(0, 2))],
                        ),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                ClipOval(child: AppNetworkImage(url: chat.userImage, width: 54, height: 54)),
                                if (chat.isOnline)
                                  Positioned(
                                    bottom: 2,
                                    right: 2,
                                    child: Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(color: AppColors.online, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(chat.userName, style: AppTextStyles.titleMedium),
                                  const SizedBox(height: 3),
                                  Text(
                                    chat.lastMessage,
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: chat.isRead ? AppColors.textHint : AppColors.textPrimary,
                                      fontWeight: chat.isRead ? FontWeight.w400 : FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(chat.timeAgo, style: AppTextStyles.caption),
                                const SizedBox(height: 4),
                                if (chat.unreadCount > 0)
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                                    child: Center(
                                      child: Text('${chat.unreadCount}',
                                          style: AppTextStyles.caption.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
