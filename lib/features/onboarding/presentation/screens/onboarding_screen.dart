import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../common/widgets/buttons/gradient_button.dart';
import '../../../../common/widgets/effects/animated_fade_slide.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  static const _pages = [
    _OnboardingData(
      icon: Icons.explore_rounded,
      gradient: [Color(0xFFFF6B8A), Color(0xFFFF8FA3)],
      title: 'Discover People\nNear You',
      subtitle: 'Swipe through thousands of profiles and find someone who makes your heart flutter.',
      blobColor1: Color(0xFFFFB3C4),
      blobColor2: Color(0xFFFFC4D6),
    ),
    _OnboardingData(
      icon: Icons.favorite_rounded,
      gradient: [Color(0xFFC9B8FF), Color(0xFF9B87F5)],
      title: 'Match & Connect\nInstantly',
      subtitle: 'When you both like each other, it\'s a match! Start chatting and let the magic begin.',
      blobColor1: Color(0xFFE8E1FF),
      blobColor2: Color(0xFFD4C9FF),
    ),
    _OnboardingData(
      icon: Icons.chat_bubble_rounded,
      gradient: [Color(0xFFFFB347), Color(0xFFFF6B8A)],
      title: 'Chat & Plan\nYour Date',
      subtitle: 'Have real conversations, share memories, and plan your first perfect date together.',
      blobColor1: Color(0xFFFFD9A8),
      blobColor2: Color(0xFFFFB3C4),
    ),
  ];

  void _next() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    } else {
      Navigator.pushReplacementNamed(context, RouteNames.login);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemCount: _pages.length,
            itemBuilder: (_, i) => _OnboardingPage(data: _pages[i]),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Dots indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_pages.length, (i) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentPage == i ? 28 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            gradient: _currentPage == i ? AppGradients.primary : null,
                            color: _currentPage == i ? null : AppColors.shimmerBase,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 28),
                    GradientButton(
                      label: _currentPage == _pages.length - 1 ? 'Get Started 💫' : 'Continue',
                      onTap: _next,
                      gradient: LinearGradient(
                        colors: [
                          _pages[_currentPage].gradient[0],
                          _pages[_currentPage].gradient[1],
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, RouteNames.login),
                      child: Text('Skip', style: AppTextStyles.bodyPrimary),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final _OnboardingData data;
  const _OnboardingPage({required this.data});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        // Top illustration area
        SizedBox(
          height: size.height * 0.55,
          child: Stack(
            children: [
              Positioned(
                top: -60,
                right: -60,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    color: data.blobColor1.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: 80,
                left: -40,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: data.blobColor2.withOpacity(0.4),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: data.gradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: data.gradient[0].withOpacity(0.4),
                        blurRadius: 40,
                        offset: const Offset(0, 16),
                      ),
                    ],
                  ),
                  child: Icon(data.icon, color: Colors.white, size: 72),
                ),
              ),
            ],
          ),
        ),
        // Text content
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              AnimatedFadeSlide(
                child: Text(
                  data.title,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.displayMedium,
                ),
              ),
              const SizedBox(height: 16),
              AnimatedFadeSlide(
                delay: const Duration(milliseconds: 100),
                child: Text(
                  data.subtitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium.copyWith(height: 1.6),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OnboardingData {
  final IconData icon;
  final List<Color> gradient;
  final String title;
  final String subtitle;
  final Color blobColor1;
  final Color blobColor2;

  const _OnboardingData({
    required this.icon,
    required this.gradient,
    required this.title,
    required this.subtitle,
    required this.blobColor1,
    required this.blobColor2,
  });
}
