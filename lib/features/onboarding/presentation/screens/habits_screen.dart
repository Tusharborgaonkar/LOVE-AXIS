import 'package:flutter/material.dart';
import '../../../../core/routes/route_names.dart';
import '../widgets/onboarding_progress_bar.dart';
import '../widgets/onboarding_next_button.dart';
import '../widgets/onboarding_option_tile.dart';

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({super.key});

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  String? _drinkingHabit;
  String? _smokingHabit;

  final List<String> _drinkingOptions = ['Never', 'Occasionally', 'Socially', 'Frequently'];
  final List<String> _smokingOptions = ['Non-smoker', 'Occasionally', 'Regularly'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const OnboardingProgressBar(value: 0.80),
              const SizedBox(height: 48),
              const Text(
                "Share about your habits",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "(only what you're comfortable with)",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black45,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "🍺 Drinking",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      ..._drinkingOptions.map((option) => Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: OnboardingOptionTile(
                          title: option,
                          isSelected: _drinkingHabit == option,
                          onTap: () => setState(() => _drinkingHabit = option),
                        ),
                      )),
                      const SizedBox(height: 32),
                      const Text(
                        "🚬 Smoking",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      ..._smokingOptions.map((option) => Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: OnboardingOptionTile(
                          title: option,
                          isSelected: _smokingHabit == option,
                          onTap: () => setState(() => _smokingHabit = option),
                        ),
                      )),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: OnboardingNextButton(
                    enabled: _drinkingHabit != null && _smokingHabit != null,
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.familyKids);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
