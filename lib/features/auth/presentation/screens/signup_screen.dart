import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../common/widgets/buttons/gradient_button.dart';
import '../../../../common/widgets/inputs/custom_text_field.dart';
import '../../../../common/widgets/effects/animated_fade_slide.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  int _step = 0;
  final int _totalSteps = 3;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedGender = '';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_step < _totalSteps - 1) {
      setState(() => _step++);
    } else {
      Navigator.pushReplacementNamed(context, RouteNames.main);
    }
  }

  void _previousStep() {
    if (_step > 0) {
      setState(() => _step--);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          _buildBackgroundBlobs(),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                _buildProgressBar(),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    transitionBuilder: (child, anim) {
                      return FadeTransition(
                        opacity: anim,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.1, 0),
                            end: Offset.zero,
                          ).animate(anim),
                          child: child,
                        ),
                      );
                    },
                    child: SingleChildScrollView(
                      key: ValueKey('step_$_step'),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: _buildCurrentStep(),
                    ),
                  ),
                ),
                _buildBottomButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundBlobs() {
    return Stack(
      children: [
        Positioned(
          top: -100,
          right: -50,
          child: _blob(350, AppColors.primary.withOpacity(0.08)),
        ),
        Positioned(
          bottom: -150,
          left: -100,
          child: _blob(400, AppColors.secondary.withOpacity(0.06)),
        ),
      ],
    );
  }

  Widget _blob(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: _previousStep,
      ),
    );
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
      child: Stack(
        children: [
          Container(
            height: 6,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.divider,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 6,
            width: (MediaQuery.of(context).size.width - 48) * ((_step + 1) / _totalSteps),
            decoration: BoxDecoration(
              gradient: AppGradients.primary,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_step) {
      case 0:
        return _stepContainer(
          key: const ValueKey('step_0'),
          title: 'What\'s your\nname?',
          subtitle: 'This will be shown on your profile and help people know who you are.',
          content: CustomTextField(
            controller: _nameController,
            hint: 'Your Name',
            prefixIcon: const Icon(Icons.person_outline_rounded),
            keyboardType: TextInputType.name,
            onChanged: (_) => setState(() {}),
          ),
        );
      case 1:
        return _stepContainer(
          key: const ValueKey('step_1'),
          title: 'Account\ndetails',
          subtitle: 'Secure your account with an email and a strong password.',
          content: Column(
            children: [
              CustomTextField(
                controller: _emailController,
                hint: 'Email Address',
                prefixIcon: const Icon(Icons.email_outlined),
                keyboardType: TextInputType.emailAddress,
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _passwordController,
                hint: 'Password',
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                obscureText: true,
                onChanged: (_) => setState(() {}),
              ),
            ],
          ),
        );
      case 2:
        return _stepContainer(
          key: const ValueKey('step_2'),
          title: 'Which gender\nbest describes you?',
          subtitle: 'Be true to yourself to find the most meaningful connections.',
          content: Column(
            children: [
              _genderOption('Male', Icons.male_rounded),
              const SizedBox(height: 12),
              _genderOption('Female', Icons.female_rounded),
              const SizedBox(height: 12),
              _genderOption('Non-binary', Icons.transgender_rounded),
            ],
          ),
        );
      default:
        return const SizedBox();
    }
  }

  Widget _stepContainer({required Key? key, required String title, required String subtitle, required Widget content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        AnimatedFadeSlide(
          child: Text(title, style: AppTextStyles.displayMedium.copyWith(height: 1.1)),
        ),
        const SizedBox(height: 12),
        AnimatedFadeSlide(
          delay: const Duration(milliseconds: 100),
          child: Text(subtitle, style: AppTextStyles.bodyMedium),
        ),
        const SizedBox(height: 48),
        AnimatedFadeSlide(
          delay: const Duration(milliseconds: 200),
          child: content,
        ),
      ],
    );
  }

  Widget _genderOption(String label, IconData icon) {
    bool isSelected = _selectedGender == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedGender = label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.divider,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? AppColors.primary : AppColors.textSecondary),
            const SizedBox(width: 16),
            Text(label, style: AppTextStyles.titleMedium.copyWith(
              color: isSelected ? AppColors.primary : AppColors.textPrimary,
            )),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check_circle_rounded, color: AppColors.primary),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    bool canContinue = false;
    if (_step == 0) canContinue = _nameController.text.isNotEmpty;
    if (_step == 1) canContinue = _emailController.text.isNotEmpty && _passwordController.text.length >= 6;
    if (_step == 2) canContinue = _selectedGender.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GradientButton(
            label: _step == _totalSteps - 1 ? 'Get Started 🚀' : 'Continue',
            onTap: canContinue ? _nextStep : null,
          ),
          if (_step == 0) ...[
            const SizedBox(height: 24),
            Row(
              children: [
                const Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text('OR', style: AppTextStyles.caption),
                ),
                const Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _socialBtn('assets/images/google.png'),
                _socialBtn('assets/images/apple.png'),
                _socialBtn('assets/images/facebook.png'),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _socialBtn(String iconPath) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
      ),
      child: Center(
        child: Icon(Icons.language_rounded, color: AppColors.textSecondary, size: 28),
      ),
    );
  }
}
