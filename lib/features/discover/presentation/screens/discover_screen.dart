import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../common/widgets/buttons/gradient_button.dart';
import '../../../../common/widgets/cards/profile_card.dart';
import '../../../../data/dummy/dummy_profiles.dart';
import '../../../../data/dummy/dummy_stories.dart';
import '../../../../data/models/profile_model.dart';
import '../../../../data/dummy/dummy_chats.dart';


class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin {
  final List<ProfileModel> _profiles = List.from(dummyProfiles);
  int _topIndex = 0;

  // Drag state
  double _dragDx = 0;
  double _dragDy = 0;
  bool _isDragging = false;
  bool _showMatch = false;
  ProfileModel? _matchedProfile;

  // Animation control
  late AnimationController _swipeCtrl;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _swipeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _swipeCtrl.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _nextCard();
        _swipeCtrl.reset();
        setState(() => _isAnimating = false);
      }
    });
  }

  @override
  void dispose() {
    _swipeCtrl.dispose();
    super.dispose();
  }

  void _swipeRight() {
    if (_isAnimating) return;
    setState(() {
      _isAnimating = true;
      _isDragging = false;
      _dragDx = 500; // Fly away right
    });
    _swipeCtrl.forward();
    _triggerMatch(_profiles[_topIndex]);
  }

  void _swipeLeft() {
    if (_isAnimating) return;
    setState(() {
      _isAnimating = true;
      _isDragging = false;
      _dragDx = -500; // Fly away left
    });
    _swipeCtrl.forward();
  }

  void _superLike() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Super Liked! 🌟'),
        backgroundColor: AppColors.superLikeBlue,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    _swipeRight();
  }

  void _nextCard() {
    setState(() {
      _dragDx = 0;
      _dragDy = 0;
      _isDragging = false;
      _topIndex = (_topIndex + 1) % _profiles.length;
    });
  }

  void _triggerMatch(ProfileModel profile) {
    setState(() {
      _matchedProfile = profile;
      _showMatch = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _buildHeader(),
                _buildStoriesRow(),
                const SizedBox(height: 12),
                Expanded(child: _buildCardStack(size)),
                _buildActionBar(),
                const SizedBox(height: 12),
              ],
            ),

            // Match celebration overlay
            if (_showMatch && _matchedProfile != null)
              _MatchCelebration(
                profile: _matchedProfile!,
                onDismiss: () => setState(() => _showMatch = false),
              ),
          ],
        ),
      ),
    );
  }
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Discover', style: AppTextStyles.headlineLarge),
          Row(
            children: [
              _headerIconBtn(Icons.tune_rounded, () {}),
              const SizedBox(width: 8),
              _headerIconBtn(Icons.notifications_none_rounded,
                  () => Navigator.pushNamed(context, RouteNames.notifications)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStoriesRow() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: dummyStories.length + 1,
        itemBuilder: (_, i) {
          if (i == 0) {
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.divider, width: 2),
                        ),
                        child: const Icon(Icons.add_rounded, color: AppColors.primary, size: 30),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          child: const Icon(Icons.add_circle_rounded, color: AppColors.primary, size: 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text('My Story', style: AppTextStyles.caption),
                ],
              ),
            );
          }
          final story = dummyStories[i - 1];
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, RouteNames.storyView, arguments: story),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(2.5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: story.isSeen ? null : AppGradients.primary,
                      color: story.isSeen ? AppColors.divider : null,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage(story.userImage),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(story.userName.split(' ')[0], style: AppTextStyles.caption),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _headerIconBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(color: AppColors.shadow.withValues(alpha: 0.12), blurRadius: 12, offset: const Offset(0, 3)),
          ],
        ),
        child: Icon(icon, color: AppColors.textSecondary, size: 22),
      ),
    );
  }


  Widget _buildCardStack(Size size) {
    final cardWidth = size.width - 48;
    final cardHeight = size.height * 0.52;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Third card (Backmost)
          if (_profiles.length > 2)
            Transform.scale(
              scale: 0.88,
              child: Transform.translate(
                offset: const Offset(0, 24),
                child: SizedBox(
                  width: cardWidth,
                  height: cardHeight,
                  child: ProfileCard(
                    key: ValueKey('card_${_profiles[(_topIndex + 2) % _profiles.length].id}'),
                    profile: _profiles[(_topIndex + 2) % _profiles.length],
                  ),
                ),
              ),
            ),

          // Back card (revealed during drag)
          if (_profiles.length > 1)
            _buildBackCard(cardWidth, cardHeight),

          // Top card (draggable)
          if (_profiles.isNotEmpty)
            _buildTopCard(cardWidth, cardHeight),
        ],
      ),
    );
  }

  Widget _buildBackCard(double width, double height) {
    // Proportional scaling based on drag
    double dragProgress = (_dragDx.abs() / 100).clamp(0.0, 1.0);
    double scale = 0.94 + (dragProgress * 0.06);
    double offsetY = 12 - (dragProgress * 12);

    final nextIndex = (_topIndex + 1) % _profiles.length;
    return Transform.scale(
      scale: scale,
      child: Transform.translate(
        offset: Offset(0, offsetY),
        child: SizedBox(
          width: width,
          height: height,
          child: ProfileCard(
            key: ValueKey('card_${_profiles[nextIndex].id}'),
            profile: _profiles[nextIndex],
          ),
        ),
      ),
    );
  }

  Widget _buildTopCard(double width, double height) {
    return GestureDetector(
      onPanUpdate: _isAnimating ? null : (details) {
        setState(() {
          _dragDx += details.delta.dx;
          _dragDy += details.delta.dy;
          _isDragging = true;
        });
      },
      onPanEnd: _isAnimating ? null : (_) {
        if (_dragDx > 100) {
          _swipeRight();
        } else if (_dragDx < -100) {
          _swipeLeft();
        } else {
          setState(() {
            _dragDx = 0;
            _dragDy = 0;
            _isDragging = false;
          });
        }
      },
      child: TweenAnimationBuilder<double>(
        key: ValueKey('top_card_anim_$_topIndex'),
        duration: _isDragging ? Duration.zero : const Duration(milliseconds: 400),
        curve: Curves.easeOutBack,
        tween: Tween(begin: 0, end: _dragDx),
        builder: (context, dx, child) {
          return Transform.translate(
            offset: Offset(dx, _dragDy),
            child: Transform.rotate(
              angle: dx * 0.001,
              child: child,
            ),
          );
        },
        child: Stack(
          children: [
            SizedBox(
              width: width,
              height: height,
              child: ProfileCard(
                key: ValueKey('card_${_profiles[_topIndex].id}'),
                profile: _profiles[_topIndex],
              ),
            ),
            // Like indicator
            if (_dragDx > 40)
              Positioned(
                top: 24,
                left: 20,
                child: _swipeLabel('LIKE 💚', Colors.green, (_dragDx - 40) / 60),
              ),
            // Nope indicator
            if (_dragDx < -40)
              Positioned(
                top: 24,
                right: 20,
                child: _swipeLabel('NOPE 💔', Colors.red, (_dragDx.abs() - 40) / 60),
              ),
          ],
        ),
      ),
    );
  }

  Widget _swipeLabel(String label, Color color, double opacity) {
    return Opacity(
      opacity: opacity.clamp(0.0, 1.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color, width: 2),
        ),
        child: Text(label, style: AppTextStyles.titleLarge.copyWith(color: color)),
      ),
    );
  }


  Widget _buildActionBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _actionBtn(Icons.close_rounded, AppColors.error, 52, () => _swipeLeft()),
          _actionBtn(Icons.star_rounded, AppColors.superLikeBlue, 44, _superLike,
              gradient: AppGradients.lavenderToPeach),
          _actionBtn(Icons.favorite_rounded, AppColors.primary, 56, () => _swipeRight(),
              gradient: AppGradients.primary),
          _actionBtn(Icons.bolt_rounded, AppColors.premiumGold, 44,
              () => Navigator.pushNamed(context, RouteNames.premium),
              gradient: AppGradients.gold),
        ],
      ),
    );
  }

  Widget _actionBtn(IconData icon, Color color, double size, VoidCallback onTap, {Gradient? gradient}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: gradient == null ? Colors.white : null,
          gradient: gradient,
          boxShadow: [
            BoxShadow(
              color: (gradient != null ? AppColors.primary : color).withValues(alpha: 0.2),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: gradient != null ? Colors.white : color, size: size * 0.44),
      ),
    );
  }
}

class _MatchCelebration extends StatefulWidget {
  final ProfileModel profile;
  final VoidCallback onDismiss;

  const _MatchCelebration({required this.profile, required this.onDismiss});

  @override
  State<_MatchCelebration> createState() => _MatchCelebrationState();
}

class _MatchCelebrationState extends State<_MatchCelebration>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _scale = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut),
    );
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: Container(
        color: Colors.black.withValues(alpha: 0.75),
        child: Center(
          child: ScaleTransition(
            scale: _scale,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ShaderMask(
                    shaderCallback: (b) => AppGradients.primary.createShader(b),
                    child: Text('It\'s a Match! 💕',
                        style: AppTextStyles.headlineLarge.copyWith(color: Colors.white)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'You and ${widget.profile.name} liked each other!',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 90,
                    width: 150,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 0,
                          child: _avatar('https://images.unsplash.com/photo-1527980965255-d3b416303d12?w=200'),
                        ),
                        Positioned(
                          right: 0,
                          child: _avatar(widget.profile.primaryImage),
                        ),
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.35),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.favorite_rounded, color: AppColors.primary, size: 22),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  GradientButton(
                    label: 'Send a Message 💬',
                    onTap: () {
                      widget.onDismiss();
                      Navigator.pushNamed(
                        context,
                        RouteNames.chatDetail,
                        arguments: dummyChats.firstWhere(
                          (c) => c.userId == widget.profile.id,
                          orElse: () => dummyChats[0],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: widget.onDismiss,
                    child: Text('Keep Swiping', style: AppTextStyles.bodyPrimary),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _avatar(String url) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.2), blurRadius: 12)],
      ),
      child: CircleAvatar(
        radius: 40,
        backgroundImage: NetworkImage(url),
      ),
    );
  }
}
