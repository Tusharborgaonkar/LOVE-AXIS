import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../data/dummy/dummy_matches.dart';
import '../../../../data/dummy/dummy_chats.dart';
import '../../../../common/widgets/cards/profile_card.dart';
import '../../../../common/widgets/common/app_network_image.dart';
import '../../../../common/widgets/effects/animated_fade_slide.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Text('Matches 🔥', style: AppTextStyles.headlineLarge),
              ),
            ),

            // New matches horizontal row
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('New Matches', style: AppTextStyles.titleLarge),
                        Text('See all', style: AppTextStyles.bodyPrimary),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: dummyMatches.length,
                      itemBuilder: (_, i) {
                        final match = dummyMatches[i];
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: AnimatedFadeSlide(
                            delay: Duration(milliseconds: i * 80),
                            child: MatchCard(
                              name: match.profile.name,
                              imageUrl: match.profile.primaryImage,
                              hasUnread: match.hasUnreadMessage,
                              onTap: () => Navigator.pushNamed(
                                context,
                                RouteNames.chatDetail,
                                arguments: dummyChats.firstWhere(
                                  (c) => c.userId == match.profile.id,
                                  orElse: () => dummyChats[0],
                                ),
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

            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // Recent conversations
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('Recent Chats', style: AppTextStyles.titleLarge),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),

            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, i) {
                  final chat = dummyChats[i];
                  return AnimatedFadeSlide(
                    delay: Duration(milliseconds: i * 60),
                    child: _ChatTile(
                      chat: chat,
                      onTap: () => Navigator.pushNamed(
                        context,
                        RouteNames.chatDetail,
                        arguments: chat,
                      ),
                    ),
                  );
                },
                childCount: dummyChats.length,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }
}

class _ChatTile extends StatelessWidget {
  final dynamic chat;
  final VoidCallback onTap;
  const _ChatTile({required this.chat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Stack(
              children: [
                ClipOval(
                  child: AppNetworkImage(url: chat.userImage, width: 54, height: 54),
                ),
                if (chat.isOnline)
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: AppColors.online,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
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
                  const SizedBox(height: 2),
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
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${chat.unreadCount}',
                        style: AppTextStyles.caption.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
