import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../common/widgets/inputs/custom_text_field.dart';
import '../widgets/onboarding_progress_bar.dart';
import '../widgets/onboarding_next_button.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final _nameController = TextEditingController();
  final _dayController = TextEditingController();
  final _monthController = TextEditingController();
  final _yearController = TextEditingController();

  bool get _isValid =>
      _nameController.text.isNotEmpty &&
      _dayController.text.length == 2 &&
      _monthController.text.length == 2 &&
      _yearController.text.length == 4 &&
      _getAge() != null;

  int? _getAge() {
    try {
      final day = int.parse(_dayController.text);
      final month = int.parse(_monthController.text);
      final year = int.parse(_yearController.text);
      
      final birthDate = DateTime(year, month, day);
      final today = DateTime.now();
      
      // Basic validity check for date (e.g. Feb 31)
      if (birthDate.day != day || birthDate.month != month || birthDate.year != year) {
        return null;
      }

      int age = today.year - birthDate.year;
      if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }
      return age;
    } catch (e) {
      return null;
    }
  }

  void _showAgeConfirmationDialog() {
    final age = _getAge();
    if (age == null) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'You\'re $age',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        content: const Text(
          'Make sure this is your correct age as you can\'t change this later.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
            height: 1.4,
          ),
        ),
        actionsPadding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
        actions: [
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(
                      context,
                      RouteNames.gender,
                      arguments: _nameController.text,
                    );
                  },
                  child: const Text(
                    'Confirm',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        const OnboardingProgressBar(value: 0.15),
                        const SizedBox(height: 32),
                        Text(
                          'Oh hey! Let\'s start with an\nintro.',
                          style: AppTextStyles.displayMedium.copyWith(
                            color: Colors.black87,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 40),
                        
                        // First Name Input
                        Text(
                          'Your first name',
                          style: AppTextStyles.labelLarge.copyWith(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        CustomTextField(
                          controller: _nameController,
                          hint: '',
                          onChanged: (v) => setState(() {}),
                        ),
                        
                        const SizedBox(height: 32),
                        
                        // Birthday Input
                        Text(
                          'Your birthday',
                          style: AppTextStyles.labelLarge.copyWith(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _buildBirthdayField(
                              controller: _dayController,
                              label: 'Day',
                              width: 70,
                              maxLength: 2,
                            ),
                            const SizedBox(width: 12),
                            _buildBirthdayField(
                              controller: _monthController,
                              label: 'Month',
                              width: 85,
                              maxLength: 2,
                            ),
                            const SizedBox(width: 12),
                            _buildBirthdayField(
                              controller: _yearController,
                              label: 'Year',
                              width: 85,
                              maxLength: 4,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'It\'s never too early to count down',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: Colors.black38,
                            fontSize: 13,
                          ),
                        ),
                        
                        // Fill remaining space to push button to bottom
                        const SizedBox(height: 48),
                        const Spacer(),
                        
                        // Next Button
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: OnboardingNextButton(
                              enabled: _isValid,
                              onTap: () => _showAgeConfirmationDialog(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBirthdayField({
    required TextEditingController controller,
    required String label,
    required double width,
    required int maxLength,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.labelMedium.copyWith(
            color: Colors.black45,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: width,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.start,
            maxLength: maxLength,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (v) => setState(() {}),
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              counterText: '',
              filled: true,
              fillColor: AppColors.primary.withOpacity(0.05),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.black12, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
