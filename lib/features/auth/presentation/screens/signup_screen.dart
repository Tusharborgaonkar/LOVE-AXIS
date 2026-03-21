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
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  String? _selectedGender;
  final _genders = ['Woman', 'Man', 'Non-binary', 'Prefer not to say'];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
          onPressed: () {
            if (_step > 0) setState(() => _step--);
            else Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Step progress
              Row(
                children: List.generate(3, (i) => Expanded(
                  child: Container(
                    height: 4,
                    margin: EdgeInsets.only(right: i < 2 ? 6 : 0),
                    decoration: BoxDecoration(
                      gradient: i <= _step ? AppGradients.primary : null,
                      color: i <= _step ? null : AppColors.shimmerBase,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                )),
              ),
              const SizedBox(height: 32),

              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  transitionBuilder: (child, anim) => SlideTransition(
                    position: Tween<Offset>(begin: const Offset(0.3, 0), end: Offset.zero)
                        .animate(anim),
                    child: FadeTransition(opacity: anim, child: child),
                  ),
                  child: _buildStep(key: ValueKey(_step)),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 28),
                child: GradientButton(
                  label: _step < 2 ? 'Continue' : 'Find My Match 💕',
                  onTap: () {
                    if (_step < 2) setState(() => _step++);
                    else Navigator.pushReplacementNamed(context, RouteNames.main);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep({Key? key}) {
    switch (_step) {
      case 0:
        return Column(
          key: key,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('What\'s your\nname? 💭', style: AppTextStyles.displayMedium),
            const SizedBox(height: 8),
            Text('This is how you\'ll appear on your profile.', style: AppTextStyles.bodyMedium),
            const SizedBox(height: 32),
            CustomTextField(
              hint: 'First name',
              controller: _nameController,
              prefixIcon: const Icon(Icons.person_outline_rounded, color: AppColors.textHint),
            ),
          ],
        );
      case 1:
        return Column(
          key: key,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Create your\naccount ✉️', style: AppTextStyles.displayMedium),
            const SizedBox(height: 8),
            Text('We\'ll never share your info with anyone.', style: AppTextStyles.bodyMedium),
            const SizedBox(height: 32),
            CustomTextField(
              hint: 'Email address',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(Icons.mail_outline_rounded, color: AppColors.textHint),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              hint: 'Password',
              obscureText: true,
              prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.textHint),
            ),
          ],
        );
      default:
        return Column(
          key: key,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('I identify\nas... 🌸', style: AppTextStyles.displayMedium),
            const SizedBox(height: 8),
            Text('Help us find your perfect match.', style: AppTextStyles.bodyMedium),
            const SizedBox(height: 32),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _genders.map((g) {
                final selected = _selectedGender == g;
                return GestureDetector(
                  onTap: () => setState(() => _selectedGender = g),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      gradient: selected ? AppGradients.primary : null,
                      color: selected ? null : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: selected ? AppColors.primary : AppColors.divider,
                        width: 1.5,
                      ),
                      boxShadow: selected ? [BoxShadow(color: AppColors.primary.withOpacity(0.25), blurRadius: 12, offset: const Offset(0, 4))] : [],
                    ),
                    child: Text(
                      g,
                      style: AppTextStyles.titleMedium.copyWith(
                        color: selected ? Colors.white : AppColors.textPrimary,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        );
    }
  }
}
