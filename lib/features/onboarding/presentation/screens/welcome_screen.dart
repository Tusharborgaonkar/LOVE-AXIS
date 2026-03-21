import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/routes/route_names.dart';
import 'dart:async';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _timer;

  final List<String> _backgroundImages = [
    'lib/assets/images/backgrounds/1.jpg',
    'lib/assets/images/backgrounds/2.jpg',
    'lib/assets/images/backgrounds/3.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_currentIndex < _backgroundImages.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image Swiper
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _backgroundImages.length,
              physics: const NeverScrollableScrollPhysics(), // Only auto-swiping
              itemBuilder: (context, index) {
                return Image.asset(
                  _backgroundImages[index],
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          
          // Grayscale/Overlay Effect
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.6),
                  ],
                ),
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  // Logo & Tagline
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLogoIcon(),
                      const SizedBox(width: 12),
                      Flexible(
                        child: Text(
                          'LoveAxis',
                          style: AppTextStyles.displayMedium.copyWith(
                            color: const Color(0xFFFFD700),
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Real Love Stories',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: const Color(0xFFFFD700),
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const Spacer(),

                  // Large Headline
                  Text(
                    'For the Love\nof Love',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.displayLarge.copyWith(
                      color: const Color(0xFFFFD700),
                      fontSize: 48,
                      height: 1.1,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Buttons
                  _buildButton(
                    context,
                    label: 'Create an account',
                    onTap: () => Navigator.pushNamed(context, RouteNames.signup),
                    color: Colors.black,
                    textColor: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  _buildButton(
                    context,
                    label: 'I have an account',
                    onTap: () => Navigator.pushNamed(context, RouteNames.login),
                    color: Colors.white,
                    textColor: Colors.black,
                  ),

                  const SizedBox(height: 32),

                  // Footer Legal Text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 12,
                          height: 1.5,
                        ),
                        children: [
                          const TextSpan(text: 'By signing up, you agree to our '),
                          TextSpan(
                            text: 'Terms',
                            style: const TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(text: '. See how we use your data in our '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: const TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoIcon() {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        color: Color(0xFFFFD700),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: const Icon(
        Icons.favorite_rounded,
        color: Colors.black,
        size: 24,
      ),
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required String label,
    required VoidCallback onTap,
    required Color color,
    required Color textColor,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.bodyLarge.copyWith(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
