import 'package:flutter/material.dart';
import '../../../../core/routes/route_names.dart';
import '../widgets/onboarding_progress_bar.dart';
import '../widgets/onboarding_next_button.dart';
import '../widgets/onboarding_option_tile.dart';

class ValuesScreen extends StatefulWidget {
  const ValuesScreen({super.key});

  @override
  State<ValuesScreen> createState() => _ValuesScreenState();
}

class _ValuesScreenState extends State<ValuesScreen> {
  String? _religion;
  String? _politics;

  final List<String> _religionOptions = [
    'Hindu', 'Muslim', 'Christian', 'Sikh', 'Jain', 'Spiritual', 'Not religious'
  ];
  final List<String> _politicsOptions = [
    'Liberal', 'Moderate', 'Conservative', 'Not interested'
  ];

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
              const OnboardingProgressBar(value: 0.90),
              const SizedBox(height: 48),
              const Text(
                "What's important in your life?",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "🛐 Religion",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      ..._religionOptions.map((option) => Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: OnboardingOptionTile(
                          title: option,
                          isSelected: _religion == option,
                          onTap: () => setState(() => _religion = option),
                        ),
                      )),
                      const SizedBox(height: 32),
                      const Text(
                        "🗳️ Politics",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      ..._politicsOptions.map((option) => Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: OnboardingOptionTile(
                          title: option,
                          isSelected: _politics == option,
                          onTap: () => setState(() => _politics = option),
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
                    enabled: _religion != null && _politics != null,
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.personalityPrompts);
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
