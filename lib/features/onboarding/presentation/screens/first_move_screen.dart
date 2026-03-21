import 'package:flutter/material.dart';
import '../../../../core/routes/route_names.dart';
import '../widgets/onboarding_progress_bar.dart';
import '../widgets/onboarding_next_button.dart';
import '../widgets/onboarding_option_tile.dart';

class FirstMoveScreen extends StatefulWidget {
  const FirstMoveScreen({super.key});

  @override
  State<FirstMoveScreen> createState() => _FirstMoveScreenState();
}

class _FirstMoveScreenState extends State<FirstMoveScreen> {
  String? _selectedOption;

  final List<Map<String, String>> _options = [
    {
      'title': 'I make the first move',
      'desc': 'Take control and start the convo'
    },
    {
      'title': 'They make the first move',
      'desc': 'Let matches message you first'
    },
    {
      'title': 'Either of us',
      'desc': 'Keep it flexible'
    },
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
              const OnboardingProgressBar(value: 0.97),
              const SizedBox(height: 48),
              const Text(
                "Who should make the\nfirst move?",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 32),
              ..._options.map((opt) => Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: OnboardingOptionTile(
                  title: opt['title']!,
                  subtitle: opt['desc'],
                  isSelected: _selectedOption == opt['title'],
                  onTap: () => setState(() => _selectedOption = opt['title']),
                ),
              )),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: OnboardingNextButton(
                    enabled: _selectedOption != null,
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.infoScreen);
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
